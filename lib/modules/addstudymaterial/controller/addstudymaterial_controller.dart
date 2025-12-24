// addstudymaterial_controller.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/api_endpoints.dart';
import '../../../utils/auth_token_service.dart';
import '../../studymateriallist/controller/studymateriallist_controller.dart';

class UploadFileModel {
  final File file;
  final String name;
  final String type;
  final double sizeMB;
  RxDouble progress = 0.0.obs;
  RxBool uploaded = false.obs;

  UploadFileModel({
    required this.file,
    required this.name,
    required this.type,
    required this.sizeMB,
  });
}

class AddStudyMaterialController extends GetxController {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  final languageId = 'ybai_language_4m142x5lth'.obs;
  final isPublic = true.obs;

  final RxList<UploadFileModel> files = <UploadFileModel>[].obs;
  final Rxn<File> coverImageFile = Rxn<File>();

  final RxBool uploading = false.obs;
  final RxBool saving = false.obs;

  final AuthTokenService authService = Get.find<AuthTokenService>();

  String standardId = '';
  String subjectId = '';

  StudyMaterialListController? listController;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    standardId = args?['standard_id'] ?? '';
    subjectId = args?['subject_id'] ?? '';

    if (Get.isRegistered<StudyMaterialListController>()) {
      listController = Get.find<StudyMaterialListController>();
    }
  }

  @override
  void onReady() {
    super.onReady();

    if (standardId.isEmpty || subjectId.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a subject first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 3),
      );
      Get.back();
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final sizeMB = file.lengthSync() / (1024 * 1024);

      final uploadFile = UploadFileModel(
        file: file,
        name: result.files.single.name,
        type: path.extension(result.files.single.name).toUpperCase().replaceFirst('.', ''),
        sizeMB: sizeMB,
      );

      files.clear();
      files.add(uploadFile);
      _simulateUpload(uploadFile);
    }
  }

  void _simulateUpload(UploadFileModel file) {
    uploading.value = true;
    file.progress.value = 0.0;

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      file.progress.value = (file.progress.value + 0.1).clamp(0.0, 1.0);
      if (file.progress.value >= 1.0) {
        file.uploaded.value = true;
        timer.cancel();
        uploading.value = false;
      }
    });
  }

  void removeFile(int index) {
    files.removeAt(index);
  }

  Future<void> pickCoverImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 85);

    if (pickedFile != null) {
      coverImageFile.value = File(pickedFile.path);
    }
  }

  void clearCoverImage() {
    coverImageFile.value = null;
  }

  void openCoverPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: Colors.green),
                title: const Text('Take Photo'),
                onTap: () async {
                  Get.back();
                  await pickCoverImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: Colors.green),
                title: const Text('From Gallery'),
                onTap: () async {
                  Get.back();
                  await pickCoverImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.crop_square_rounded, color: Colors.grey),
                title: const Text('Default (No Cover)'),
                onTap: () {
                  Get.back();
                  clearCoverImage();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveResource() async {
    if (titleCtrl.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter a title');
      return;
    }

    if (files.isEmpty) {
      Get.snackbar('Error', 'Please upload a file');
      return;
    }

    if (!files.first.uploaded.value) {
      Get.snackbar('Wait', 'File is still uploading');
      return;
    }

    saving.value = true;

    try {
      final headers = await authService.getAuthHeaders();
      final uri = Uri.parse(ApiConfig.uploadResource);

      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);

      request.fields.addAll({
        'title': titleCtrl.text.trim(),
        'description': descCtrl.text.trim(),
        'language_id': languageId.value,
        'is_public': isPublic.value.toString(),
        'standard_id': standardId,
        'subject_id': subjectId,
      });

      final mainFile = files.first.file;
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        mainFile.path,
        filename: files.first.name,
      ));

      if (coverImageFile.value != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'cover_image',
          coverImageFile.value!.path,
          filename: path.basename(coverImageFile.value!.path),
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        Get.snackbar(
          'Success!',
          jsonData['message'] ?? 'Resource uploaded successfully',
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
          duration: const Duration(seconds: 3),
        );

        listController?.fetchMaterials();

        _clearForm();
        Get.back();
      } else {
        final jsonData = jsonDecode(response.body);
        Get.snackbar('Error', jsonData['message'] ?? 'Upload failed');
      }
    } catch (e) {
      debugPrint('Upload error: $e');
      Get.snackbar('Error', 'Network error. Please try again.');
    } finally {
      saving.value = false;
    }
  }

  void _clearForm() {
    titleCtrl.clear();
    descCtrl.clear();
    files.clear();
    coverImageFile.value = null;
    isPublic.value = true;
  }

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.onClose();
  }
}