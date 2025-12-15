// addchapter_controller.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadFileModel {
  final String name;
  final String type; // "PDF", "DOC", "IMG"
  final double sizeMB;
  RxDouble progress = 0.0.obs;
  RxBool uploaded = false.obs;

  UploadFileModel({
    required this.name,
    required this.type,
    required this.sizeMB,
  });
}

class AddStudyMaterialController extends GetxController {
  // Form controllers
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  // Dropdowns
  final language = 'English'.obs;
  final category = 'Textbook'.obs;
  final isPublic = true.obs;

  // File uploads
  final RxList<UploadFileModel> files = <UploadFileModel>[].obs;
  final Rxn<String> coverImagePath = Rxn<String>();

  // UI state
  final RxBool uploading = false.obs;
  final RxBool saving = false.obs;

  // Mock: supported languages and categories
  final languages = ['English', 'Hindi', 'Gujarati', 'Spanish'];
  final categories = [
    'Textbook',
    'Notes',
    'Reference Material',
    'Question Bank',
  ];

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.onClose();
  }

  // Add a mock file (simulate browsing)
  void addMockFile({String? name, String type = 'PDF', double sizeMB = 5.2}) {
    final file = UploadFileModel(
      name: name ?? 'file_${files.length + 1}.pdf',
      type: type,
      sizeMB: sizeMB,
    );
    files.add(file);
    _simulateUpload(file);
  }

  // Simulate upload progress for a file
  void _simulateUpload(UploadFileModel file) {
    uploading.value = true;
    file.progress.value = 0;
    Timer.periodic(const Duration(milliseconds: 200), (t) {
      final cur = file.progress.value + (0.12 + (0.08 * (files.length % 3)));
      file.progress.value = cur.clamp(0.0, 1.0);
      if (file.progress.value >= 1.0) {
        file.uploaded.value = true;
        file.progress.value = 1.0;
        t.cancel();
        // check if all uploaded
        if (files.every((f) => f.uploaded.value)) uploading.value = false;
      }
    });
  }

  // Remove file
  void removeFile(int index) {
    files.removeAt(index);
  }

  // Pick cover image (mock) — open sheet and set a placeholder path
  void openCoverPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.green,
                  ),
                  title: const Text('Take Photo'),
                  onTap: () {
                    coverImagePath.value = 'assets/mock_cover_camera.png';
                    Get.back();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_rounded,
                    color: Colors.green,
                  ),
                  title: const Text('From Gallery'),
                  onTap: () {
                    coverImagePath.value = 'assets/mock_cover_gallery.png';
                    Get.back();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image_outlined, color: Colors.grey),
                  title: const Text('Default'),
                  onTap: () {
                    coverImagePath.value = null;
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Save resource (validate basic fields)
  Future<void> saveResource() async {
    if (titleCtrl.text.trim().isEmpty) {
      Get.snackbar(
        'Validation',
        'Please enter resource title',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (files.isEmpty) {
      Get.snackbar(
        'Validation',
        'Please upload at least one file',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // make sure uploads complete
    if (files.any((f) => !f.uploaded.value)) {
      Get.snackbar(
        'Uploads',
        'Please wait for all uploads to complete',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    saving.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    // TODO: call API / save logic
    saving.value = false;
    Get.snackbar(
      'Success',
      'Resource uploaded successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
    // Optionally clear form
    titleCtrl.clear();
    descCtrl.clear();
    files.clear();
    coverImagePath.value = null;
    isPublic.value = true;
  }
}
