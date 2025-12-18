import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class OnTestPaperController extends GetxController {
  // Uploaded file state
  var uploadedFileName = ''.obs;
  var uploadedFileSize = ''.obs;
  var uploadedFilePath = ''.obs;        // ← Added
  var uploadedFileExtension = ''.obs;   // ← Added
  var isFileUploaded = false.obs;

  final promptFocusNode = FocusNode();

  // Selected pre-built template
  var selectedTemplate = 'Standard'.obs;

  // Text controller for AI Custom Prompt
  final TextEditingController promptController = TextEditingController();

  // ==================== PAPER SETTINGS STATE ====================
  var selectedPaperSize = 'A4 (210 × 297 mm)'.obs;
  final List<String> paperSizes = [
    'A4 (210 × 297 mm)',
    'A3 (297 × 420 mm)',
    'Letter (8.5 × 11 in)',
    'Legal (8.5 × 14 in)',
  ];

  var isPortrait = true.obs; // true = Portrait selected
  var includeAnswerKey = true.obs;
  var addLogo = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Simulate uploaded file (as seen in your desired screenshot)
    uploadedFileName.value = 'my_test_template.pdf';
    uploadedFileSize.value = '2.1 MB';
    uploadedFilePath.value = '/path/to/my_test_template.pdf'; // dummy path for simulation
    uploadedFileExtension.value = 'pdf';
    isFileUploaded.value = true;

    // Pre-fill the AI prompt with a realistic example
    promptController.text =
        'Generate a mathematics test paper with 25 MCQs and 5 short answer questions. Include space for student details at the top, clear instructions, and proper answer sheet format. Use standard CBSE pattern with 3 hours duration.';
  }

  @override
  void onClose() {
    promptController.dispose();
    promptFocusNode.dispose();
    super.onClose();
  }

  // Select pre-built template
  void selectTemplate(String name) {
    selectedTemplate.value = name;
    Get.snackbar(
      'Template Selected',
      '$name template selected',
      backgroundColor: const Color(0xFF2DA67C),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Pick and upload custom template
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
        Get.snackbar(
          'Error',
          'File size exceeds 10MB limit',
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
        );
        return;
      }

      uploadedFileName.value = result.files.single.name;
      uploadedFilePath.value = result.files.single.path!;           // ← Save path
      uploadedFileExtension.value = result.files.single.extension ?? ''; // ← Save extension
      uploadedFileSize.value = '${sizeInMb.toStringAsFixed(1)} MB';
      isFileUploaded.value = true;

      Get.snackbar(
        'Uploaded!',
        '${result.files.single.name} uploaded successfully',
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
      );
    }
  }

  // Remove uploaded file
  void removeUploadedFile() {
    isFileUploaded.value = false;
    uploadedFileName.value = '';
    uploadedFileSize.value = '';
    uploadedFilePath.value = '';           // ← Clear path
    uploadedFileExtension.value = '';      // ← Clear extension

    Get.snackbar(
      'Removed',
      'Uploaded template has been removed',
      backgroundColor: Colors.orange.shade600,
      colorText: Colors.white,
    );
  }

  // Preview template
  void previewTemplate() {
  if (!isFileUploaded.value || uploadedFilePath.value.isEmpty) {
    Get.snackbar('No File', 'Please upload a template first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white);
    return;
  }

  Get.toNamed(
    '/previewtemplate', // Must match route name exactly
    arguments: {
      'filePath': uploadedFilePath.value,
      'fileName': uploadedFileName.value,
      'extension': uploadedFileExtension.value.toLowerCase(),
    },
  );
}

  // Final generate paper action
  void finalizeGeneratePaper() {
    String method = isFileUploaded.value
        ? 'Custom Template'
        : 'Pre-built (${selectedTemplate.value}) + AI Prompt';

    Get.snackbar(
      'Generating...',
      'Creating your test paper using $method',
      backgroundColor: const Color(0xFF2DA67C),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );

    // Simulate processing
    Future.delayed(const Duration(seconds: 2), () {
      Get.snackbar(
        'Success!',
        'Test paper generated successfully!\nReady for download or print.',
        backgroundColor: const Color(0xFF34BF8E),
        colorText: Colors.white,
        icon: const Icon(Icons.download_done, color: Colors.white),
        duration: const Duration(seconds: 4),
      );
    });
  }

  // ==================== PAPER SETTINGS METHODS ====================
  void toggleOrientation(bool portrait) {
    isPortrait.value = portrait;
  }

  void toggleAnswerKey(bool value) {
    includeAnswerKey.value = value;
  }

  void toggleAddLogo(bool value) {
    addLogo.value = value;
  }

  // Preview before generate (placeholder)
  void previewBeforeGenerate() {
    Get.snackbar(
      'Preview',
      'Previewing your test paper before generation...',
      backgroundColor: Colors.blue.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}