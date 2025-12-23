// addstudymaterial_controller.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../studymateriallist/controller/studymateriallist_controller.dart';

class UploadFileModel {
  final String name;
  final String type;
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
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  final language = 'English'.obs;
  final category = 'Textbook'.obs;
  final isPublic = true.obs;

  final RxList<UploadFileModel> files = <UploadFileModel>[].obs;
  final Rxn<String> coverImagePath = Rxn<String>();

  final RxBool uploading = false.obs;
  final RxBool saving = false.obs;

  final languages = ['English', 'Hindi', 'Gujarati', 'Spanish'];
  final categories = [
    'Textbook',
    'Notes',
    'Reference Material',
    'Question Bank',
  ];

  // Reference to StudyMaterialListController
  StudyMaterialListController? listController;

  @override
  void onInit() {
    super.onInit();
    // Safely try to find the list controller
    if (Get.isRegistered<StudyMaterialListController>()) {
      listController = Get.find<StudyMaterialListController>();
    }
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.onClose();
  }

  void addMockFile({String? name, String type = 'PDF', double sizeMB = 15.2}) {
    final file = UploadFileModel(
      name: name ?? 'calculus_textbook.pdf',
      type: type,
      sizeMB: sizeMB,
    );
    files.add(file);
    _simulateUpload(file);
  }

  void _simulateUpload(UploadFileModel file) {
    uploading.value = true;
    file.progress.value = 0.0;

    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      file.progress.value = (file.progress.value + 0.15).clamp(0.0, 1.0);

      if (file.progress.value >= 1.0) {
        file.uploaded.value = true;
        timer.cancel();

        // Check if all files are uploaded
        if (files.every((f) => f.uploaded.value)) {
          uploading.value = false;
        }
      }
    });
  }

  void removeFile(int index) {
    if (index >= 0 && index < files.length) {
      files.removeAt(index);
    }
  }

  void clearCoverImage() {
  coverImagePath.value = null;
}

  void openCoverPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: Colors.green, size: 28),
                title: const Text('Take Photo', style: TextStyle(fontSize: 16)),
                onTap: () {
                  coverImagePath.value = 'assets/mock_cover_camera.png';
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: Colors.green, size: 28),
                title: const Text('From Gallery', style: TextStyle(fontSize: 16)),
                onTap: () {
                  coverImagePath.value = 'assets/mock_cover_gallery.png';
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image_outlined, color: Colors.grey, size: 28),
                title: const Text('Default', style: TextStyle(fontSize: 16)),
                onTap: () {
                  coverImagePath.value = null;
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveResource() async {
    // Validation
    if (titleCtrl.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter a resource title', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red.shade100, colorText: Colors.red.shade900);
      return;
    }

    if (files.isEmpty) {
      Get.snackbar('Error', 'Please upload at least one file', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red.shade100, colorText: Colors.red.shade900);
      return;
    }

    if (files.any((f) => !f.uploaded.value)) {
      Get.snackbar('Please Wait', 'All files must finish uploading', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    saving.value = true;

    // Simulate save delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Create new material
    final newMaterial = {
      'title': titleCtrl.text.trim(),
      'subtitle': descCtrl.text.trim().isEmpty ? 'No description' : descCtrl.text.trim(),
      'type': '${files.first.type} • ${files.first.sizeMB.toStringAsFixed(1)} MB',
      'status': 'Processed',
      'statusColor': 0xFF00C853,
      'icon': files.first.type == 'PDF' ? '📘' : files.first.type == 'DOC' ? '📄' : '🖼️',
      'time': 'Just now',
    };

    // Update the main list if possible
    if (listController != null && Get.isRegistered<StudyMaterialListController>()) {
      listController!.studyMaterials.insert(0, newMaterial);
      listController!.applyFilterAndSort(); // Refresh UI
    }

    saving.value = false;

    // Success message
    Get.snackbar(
      'Success!',
      'Study material uploaded successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade900,
      duration: const Duration(seconds: 3),
    );

    // Clear form
    titleCtrl.clear();
    descCtrl.clear();
    files.clear();
    coverImagePath.value = null;
    language.value = 'English';
    category.value = 'Textbook';
    isPublic.value = true;

    // Go back to list
    Get.back();
  }
}