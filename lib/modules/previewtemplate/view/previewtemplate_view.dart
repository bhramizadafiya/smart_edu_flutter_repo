import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:smarted/modules/previewtemplate/controller/previewtemplate_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:docx_file_viewer/docx_file_viewer.dart'; // DOCX viewer


class PreviewTemplateView extends GetView<PreviewTemplateController> {
  const PreviewTemplateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
     appBar: AppBar(
  // Static visibility icon (no onPressed)
  leading: const Padding(
    padding: EdgeInsets.all(12.0),
    child: Icon(
      Icons.visibility,
      color: Color.fromARGB(255, 58, 166, 255),
      size: 28,
    ),
  ),
  title: const Text(
    'Test - Paper Preview',
    style: TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
  ),
  centerTitle: true,
  backgroundColor: Colors.white,
  elevation: 0,
  shape: Border(
    bottom: BorderSide(
      color: Colors.grey[300]!,
      width: 1.0,
    ),
  ),
  actions: [
    Obx(() {
      if (!controller.pdfDocumentLoaded.value ||
          controller.pdfViewerController.pageCount == 0) {
        return const SizedBox.shrink();
      }

      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.shade700, width: 1.5),
          ),
          child: Text(
            'Page ${controller.pdfViewerController.pageCount}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }),
    IconButton(
      icon: const Icon(Icons.close, color: Colors.black87),
      onPressed: () => Get.back(),
    ),
    const SizedBox(width: 8),
  ],
),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.filePath.value.isEmpty) {
          return const Center(
            child: Text(
              'No file to preview',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          );
        }

        final String extension = controller.uploadedFileExtension.value.toLowerCase();

        if (extension == 'pdf') {
          return SizedBox.expand(
            child: SfPdfViewer.file(
              controller.uploadedFile!,
              controller: controller.pdfViewerController,
              scrollDirection: PdfScrollDirection.vertical,
              pageLayoutMode: PdfPageLayoutMode.continuous,
              pageSpacing: 40, // Good separation for PDF pages
              canShowScrollHead: false,
              canShowScrollStatus: false,
              canShowPaginationDialog: false,
              enableDoubleTapZooming: false,
              maxZoomLevel: 1.5,
              onDocumentLoaded: controller.onPdfDocumentLoaded,
              onPageChanged: (PdfPageChangedDetails details) {
                controller.currentPage.value = details.newPageNumber;
              },
            ),
          );
        } else if (extension == 'doc' || extension == 'docx') {
          // DOC/DOCX with bounded layout + spacing simulation
          return Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: DocxViewer(
                    file: File(controller.filePath.value),
                  ),
                ),
                const SizedBox(height: 100), // Extra space at end for page gap feel
              ],
            ),
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description, size: 100, color: Colors.grey.shade600),
                  const SizedBox(height: 24),
                  Text(
                    controller.uploadedFileName.value,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Preview not available for .$extension files',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'This file will be used as your custom template when generating the test paper.',
                    style: TextStyle(fontSize: 14, color: Colors.black45),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}