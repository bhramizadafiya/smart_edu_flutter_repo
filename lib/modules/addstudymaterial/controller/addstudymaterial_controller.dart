// addstudymaterial_controller.dart
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import '../../studymateriallist/controller/studymateriallist_controller.dart';

class UploadFileModel {
  final String name;
  final String type;
  final double sizeMB;
  final File file;
  RxDouble progress = 0.0.obs;
  RxBool uploaded = false.obs;

  UploadFileModel({
    required this.name,
    required this.type,
    required this.sizeMB,
    required this.file,
  });
}

class AddStudyMaterialController extends GetxController {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  final language = 'English'.obs;
  final category = 'Textbook'.obs;
  final isPublic = true.obs;

  final RxList<UploadFileModel> files = <UploadFileModel>[].obs;
  final Rxn<File> coverImage = Rxn<File>();

  final RxBool uploading = false.obs;
  final RxBool saving = false.obs;

  final languages = ['English', 'Hindi', 'Gujarati', 'Spanish'];
  final categories = [
    'Textbook',
    'Notes',
    'Reference Material',
    'Question Bank',
  ];

  // Will be set from Get.arguments
  late String standardId;
  late String subjectId;

  // Fixed language ID
  final String languageId = 'ybai_language_4m142x5lth';

  // Authorization token – use secure storage in production
  final String authToken = '19jnUAD7PlsPXatEukd5tEnCjsfCc3tvpBnejsqc';

  StudyMaterialListController? listController;

  final dio.Dio _dio = dio.Dio();

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;

    standardId = args?['standard_id'] as String? ?? '';
    subjectId = args?['subject_id'] as String? ?? '';

    if (standardId.isEmpty || subjectId.isEmpty) {
      Get.snackbar(
        'Error',
        'Missing standard or subject information. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 5),
      );
    }

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

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null) {
      for (var platformFile in result.files) {
        if (platformFile.path == null) continue;

        final file = File(platformFile.path!);
        final sizeMB = platformFile.size / (1024 * 1024);
        final extension = platformFile.extension?.toUpperCase() ?? 'FILE';

        final uploadFile = UploadFileModel(
          name: platformFile.name,
          type: extension,
          sizeMB: sizeMB,
          file: file,
        );
        files.add(uploadFile);
      }
    }
  }

  Future<void> pickCoverImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 85);

    if (picked != null) {
      coverImage.value = File(picked.path);
    }
  }

  void clearCoverImage() {
    coverImage.value = null;
  }

  void removeFile(int index) {
    if (index >= 0 && index < files.length) {
      files.removeAt(index);
    }
  }

  Future<void> saveResource() async {
    if (titleCtrl.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter a resource title',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900);
      return;
    }

    if (files.isEmpty) {
      Get.snackbar('Error', 'Please select at least one file',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900);
      return;
    }

    if (standardId.isEmpty || subjectId.isEmpty) {
      Get.snackbar('Error', 'Invalid standard or subject. Cannot upload.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900);
      return;
    }

    saving.value = true;
    uploading.value = true;

    try {
      final formData = dio.FormData();

      formData.fields.addAll([
        MapEntry('title', titleCtrl.text.trim()),
        if (descCtrl.text.trim().isNotEmpty)
          MapEntry('description', descCtrl.text.trim()),
        MapEntry('category', category.value.toLowerCase()),
        MapEntry('language_id', languageId),
        MapEntry('is_public', isPublic.value.toString()),
        MapEntry('standard_id', standardId),
        MapEntry('subject_id', subjectId),
      ]);

      if (coverImage.value != null) {
        formData.files.add(MapEntry(
          'cover_image',
          await dio.MultipartFile.fromFile(
            coverImage.value!.path,
            filename: coverImage.value!.path.split('/').last,
          ),
        ));
      }

      for (var uploadFile in files) {
        formData.files.add(MapEntry(
          'file',
          await dio.MultipartFile.fromFile(
            uploadFile.file.path,
            filename: uploadFile.name,
          ),
        ));
      }

      final response = await _dio.post(
        'http://smarted.ybaisolution.com/ybai/upload-resource',
        data: formData,
        options: dio.Options(
          headers: {'Authorization': 'Bearer $authToken'},
          contentType: 'multipart/form-data',
        ),
        onSendProgress: (sent, total) {
          if (total > 0) {
            final overallProgress = sent / total;
            for (var f in files) {
              f.progress.value = overallProgress;
            }
          }
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Mark all files as fully uploaded
        for (var f in files) {
          f.uploaded.value = true;
          f.progress.value = 1.0;
        }

        // Refresh the list from server
        if (listController != null) {
   listController!.refreshList();
}

        // Show success message
        Get.snackbar(
          'Success!',
          'Study material uploaded successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
        );

        // Clear the form
        titleCtrl.clear();
        descCtrl.clear();
        files.clear();
        coverImage.value = null;
        language.value = 'English';
        category.value = 'Textbook';
        isPublic.value = true;

        // === REDIRECT TO STUDY MATERIAL LIST ===
        // Replace current screen with the list screen
        Get.offNamed('/study-material-list', arguments: {
          'standard_id': standardId,
          'subject_id': subjectId,
        });

        // Alternative if you don't use named routes:
        // Get.offAll(() => StudyMaterialListView(
        //   standardId: standardId,
        //   subjectId: subjectId,
        // ));
      } else {
        throw 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      String errorMsg = 'Upload failed';
      if (e is dio.DioException) {
        errorMsg += ': ${e.message ?? ''}';
        if (e.response?.data != null) {
          errorMsg += ' - ${e.response?.data}';
        }
      } else {
        errorMsg += ': $e';
      }
      Get.snackbar('Error', errorMsg,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
          duration: const Duration(seconds: 6));
    } finally {
      uploading.value = false;
      saving.value = false;
    }
  }
}