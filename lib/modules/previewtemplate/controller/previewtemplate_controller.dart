import 'dart:io';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PreviewTemplateController extends GetxController {
  final RxString filePath = ''.obs;
  final RxString uploadedFileName = 'Unknown file'.obs;
  final RxString uploadedFileExtension = ''.obs;
  final RxBool isLoading = true.obs;

  final RxInt currentPage = 1.obs;
  final RxBool pdfDocumentLoaded = false.obs;  // NEW: Track if PDF is fully loaded

  File? uploadedFile;
  final PdfViewerController pdfViewerController = PdfViewerController();

  @override
  void onInit() {
    super.onInit();
    _loadFileFromArguments();
  }

  void _loadFileFromArguments() {
    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      filePath.value = args['filePath'] ?? '';
      uploadedFileName.value = args['fileName'] ?? 'Unknown file';
      uploadedFileExtension.value = args['extension'] ?? '';

      if (filePath.value.isNotEmpty) {
        uploadedFile = File(filePath.value);
      }
    }
    isLoading.value = false;
  }

  // Called when PDF document is fully loaded
  void onPdfDocumentLoaded(PdfDocumentLoadedDetails details) {
    pdfDocumentLoaded.value = true;
  }

  @override
  void onClose() {
    pdfViewerController.dispose();
    super.onClose();
  }
}