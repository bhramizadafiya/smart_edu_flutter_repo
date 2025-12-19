import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:smarted/modules/onpapertest/view/onpapertest_view.dart';
import 'package:smarted/theme/design_system.dart';


class OnTestPaperController extends GetxController {
  // Uploaded file state
  var uploadedFileName = ''.obs;
  var uploadedFileSize = ''.obs;
  var uploadedFilePath = ''.obs;
  var uploadedFileExtension = ''.obs;
  var isFileUploaded = false.obs;

  final promptFocusNode = FocusNode();
  var selectedTemplate = 'Standard'.obs;
  final TextEditingController promptController = TextEditingController();

  // Paper settings
  var selectedPaperSize = 'A4 (210 × 297 mm)'.obs;
  final List<String> paperSizes = [
    'A4 (210 × 297 mm)',
    'A3 (297 × 420 mm)',
    'Letter (8.5 × 11 in)',
    'Legal (8.5 × 14 in)',
  ];

  var isPortrait = true.obs;
  var includeAnswerKey = true.obs;
  var addLogo = false.obs;

  // Fake download state
  final RxDouble downloadProgress = 0.0.obs;
  final RxString currentFileName = ''.obs;
  final RxString downloadedSize = '0.0'.obs;
  final RxString totalSize = '0.0'.obs;
  Timer? _progressTimer;
  bool _isDownloading = false;

  // Download options with correct extensions
  late List<DownloadOption> downloadOptions;

  @override
  void onInit() {
    super.onInit();

    downloadOptions = [
      DownloadOption(
        title: 'Test Paper PDF',
        subtitle: 'Best for printing',
        size: '6.2 MB',
        buttonText: 'PDF',
        buttonColor: Colors.red.shade400,
        backgroundColor: const Color.fromARGB(255, 255, 247, 247),
        buttonOpacity: 0.7,
        onTap: () => startFakeDownload(
          fileName: 'test_paper.pdf',
          totalSizeMB: 6.2,
        ),
      ),
      DownloadOption(
        title: 'Test Paper DOC',
        subtitle: 'Editable format',
        size: '4.8 MB',
        buttonText: 'DOC',
        buttonColor: const Color.fromARGB(255, 6, 128, 228),
        backgroundColor: const Color.fromARGB(255, 235, 246, 255),
        buttonOpacity: 0.9,
        onTap: () => startFakeDownload(
          fileName: 'test_paper.docx',
          totalSizeMB: 4.8,
        ),
      ),
      DownloadOption(
        title: 'Answer Key PDF',
        subtitle: 'Complete solutions',
        size: '2.1 MB',
        buttonText: 'Key',
        buttonColor: AppColors.gradientEnd,
        backgroundColor: const Color.fromARGB(255, 240, 255, 240),
        buttonOpacity: 0.8,
        onTap: () => startFakeDownload(
          fileName: 'answer_key.pdf',
          totalSizeMB: 2.1,
        ),
      ),
      DownloadOption(
        title: 'Complete Bundle',
        subtitle: 'Paper + Answer Key',
        size: '8.9 MB',
        buttonText: 'All',
        buttonColor: const Color.fromARGB(255, 53, 21, 108),
        backgroundColor: const Color.fromARGB(255, 250, 244, 255),
        buttonOpacity: 0.6,
        onTap: () => startFakeDownload(
          fileName: 'test_paper_bundle.zip',
          totalSizeMB: 8.9,
        ),
      ),
    ];

    // Simulate uploaded file
    uploadedFileName.value = 'my_test_template.pdf';
    uploadedFileSize.value = '2.1 MB';
    uploadedFilePath.value = '/path/to/my_test_template.pdf';
    uploadedFileExtension.value = 'pdf';
    isFileUploaded.value = true;

    promptController.text =
        'Generate a mathematics test paper with 25 MCQs and 5 short answer questions...';
  }

  @override
  void onClose() {
    promptController.dispose();
    promptFocusNode.dispose();
    _progressTimer?.cancel();
    super.onClose();
  }

  // ==================== FAKE DOWNLOAD WITH PROGRESS ====================
 void startFakeDownload({
  required String fileName,
  required double totalSizeMB,
}) {
  // Prevent multiple simultaneous downloads
  if (_isDownloading) {
    Get.snackbar('Ongoing', 'A download is already in progress',
        backgroundColor: Colors.orange.shade600, colorText: Colors.white);
    return;
  }

  _isDownloading = true;

  // Reset values
  currentFileName.value = fileName;
  downloadProgress.value = 0.0;
  downloadedSize.value = '0.0';
  totalSize.value = totalSizeMB.toStringAsFixed(1);

  // Cancel any old timer
  _progressTimer?.cancel();

  // Close the options modal first
  if (Get.isBottomSheetOpen == true) {
    Get.back();
  }

  // Open progress modal AFTER a short delay to ensure clean transition
  Future.delayed(const Duration(milliseconds: 300), () {
    // Double-check we're still supposed to be downloading
    if (!_isDownloading) return;

    Get.bottomSheet(
      Obx(() => DownloadProgressModal(
            fileName: currentFileName.value,
            progress: downloadProgress.value,
            downloadedSize: downloadedSize.value,
            totalSize: totalSize.value,
            onCancel: cancelFakeDownload,
          )),
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      persistent: true, // Important for stability
    );
  });

  // Start fake progress simulation
  int step = 0;
  _progressTimer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
    // If cancelled midway, stop
    if (!_isDownloading) {
      timer.cancel();
      return;
    }

    step++;
    double newProgress = (step / 100.0).clamp(0.0, 1.0);

    downloadProgress.value = newProgress;
    downloadedSize.value = (newProgress * totalSizeMB).toStringAsFixed(1);

    // Completed
    if (newProgress >= 1.0) {
      timer.cancel();

      // Wait a moment then close modal and show success
      Future.delayed(const Duration(seconds: 1), () {
        if (Get.isBottomSheetOpen == true) {
          Get.back();
        }

        Get.snackbar(
          'Download Complete ✓',
          '$fileName has been saved!',
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          icon: const Icon(Icons.check_circle, color: Colors.white),
        );

        _isDownloading = false;
      });
    }
  });
}

void cancelFakeDownload() {
  if (!_isDownloading) return;

  _progressTimer?.cancel();
  _isDownloading = false;

  downloadProgress.value = 0.0;
  downloadedSize.value = '0.0';

  // Safely close modal if it's open
  if (Get.isBottomSheetOpen == true) {
    Get.back();
  }

  Get.snackbar(
    'Download Cancelled',
    'The download was stopped',
    backgroundColor: Colors.red.shade600,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
    icon: const Icon(Icons.cancel, color: Colors.white),
  );
}
  // ==================== REST OF YOUR METHODS (UNCHANGED) ====================
  void selectTemplate(String name) {
    selectedTemplate.value = name;
    Get.snackbar('Template Selected', '$name template selected',
        backgroundColor: const Color.fromARGB(255, 29, 169, 120), colorText: Colors.white);
  }

  Future<void> pickAndUploadTemplate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      double sizeInMb = file.lengthSync() / (1024 * 1024);

      if (sizeInMb > 10) {
        Get.snackbar('Error', 'File size exceeds 10MB limit',
            backgroundColor: Colors.red.shade600, colorText: Colors.white);
        return;
      }

      uploadedFileName.value = result.files.single.name;
      uploadedFilePath.value = result.files.single.path!;
      uploadedFileExtension.value = result.files.single.extension ?? '';
      uploadedFileSize.value = '${sizeInMb.toStringAsFixed(1)} MB';
      isFileUploaded.value = true;

      Get.snackbar('Uploaded!', '${result.files.single.name} uploaded successfully',
          backgroundColor: Colors.green.shade600, colorText: Colors.white);
    }
  }

  void removeUploadedFile() {
    isFileUploaded.value = false;
    uploadedFileName.value = '';
    uploadedFileSize.value = '';
    uploadedFilePath.value = '';
    uploadedFileExtension.value = '';
    Get.snackbar('Removed', 'Uploaded template has been removed',
        backgroundColor: Colors.orange.shade600, colorText: Colors.white);
  }

  void previewTemplate() {
    if (!isFileUploaded.value || uploadedFilePath.value.isEmpty) {
      Get.snackbar('No File', 'Please upload a template first',
          backgroundColor: Colors.red.shade600, colorText: Colors.white);
      return;
    }

    Get.toNamed('/previewtemplate', arguments: {
      'filePath': uploadedFilePath.value,
      'fileName': uploadedFileName.value,
      'extension': uploadedFileExtension.value.toLowerCase(),
    });
  }

  void finalizeGeneratePaper() {
    String method = isFileUploaded.value
        ? 'Custom Template'
        : 'Pre-built (${selectedTemplate.value}) + AI Prompt';

    Get.snackbar(
      'Generating...',
      'Creating your test paper using $method',
      backgroundColor: const Color(0xFF2DA67C),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Get.closeAllSnackbars();
      Get.bottomSheet(
        const DownloadOptionsModal(),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      );
    });
  }

  void toggleOrientation(bool portrait) => isPortrait.value = portrait;
  void toggleAnswerKey(bool value) => includeAnswerKey.value = value;
  void toggleAddLogo(bool value) => addLogo.value = value;
  void previewBeforeGenerate() => Get.toNamed('/papertestpreview');
}

// ==================== DOWNLOAD OPTION MODEL ====================
class DownloadOption {
  final String title;
  final String subtitle;
  final String size;
  final String buttonText;
  final Color buttonColor;
  final Color backgroundColor;
  final double buttonOpacity;
  final VoidCallback onTap;

  DownloadOption({
    required this.title,
    required this.subtitle,
    required this.size,
    required this.buttonText,
    required this.buttonColor,
    required this.backgroundColor,
    this.buttonOpacity = 1.0,
    required this.onTap,
  });
}