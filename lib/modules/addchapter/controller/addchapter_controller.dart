import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../chapterlist/controller/chapterlist_controller.dart';

class AddChapterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // No initial text — fields will be empty on load
  final TextEditingController chapterNameCtrl = TextEditingController();
  final TextEditingController startPageCtrl = TextEditingController();
  final TextEditingController endPageCtrl = TextEditingController();

  final RxBool saving = false.obs;

  ChapterListController? chapterListController;

  @override
  void onInit() {
    super.onInit();
    try {
      chapterListController = Get.find<ChapterListController>();
    } catch (_) {
      chapterListController = null;
    }
  }

  String? validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter chapter name';
    if (v.trim().length < 2) return 'Name too short';
    return null;
  }

  String? validatePage(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    final n = int.tryParse(v.trim());
    if (n == null || n < 1) return 'Enter a valid page number';
    return null;
  }

  void saveChapter() async {
    if (!formKey.currentState!.validate()) return;

    final start = int.tryParse(startPageCtrl.text.trim());
    final end = int.tryParse(endPageCtrl.text.trim());

    if (start == null || end == null || start > end) {
      Get.snackbar(
        'Invalid pages',
        'Start page cannot be greater than End page',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      return;
    }

    saving.value = true;
    await Future.delayed(const Duration(milliseconds: 800));

    final chapter = {
      'title': chapterNameCtrl.text.trim(),
      'pages': 'Pages $start–$end • ${end - start + 1} pages',
    };

    if (chapterListController != null) {
      chapterListController!.addChapter(chapter);
    } else {
      debugPrint('Chapter created locally: $chapter');
    }

    saving.value = false;
    Get.back();

    Get.snackbar(
      'Success',
      'Chapter saved successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade900,
    );
  }

  @override
  void onClose() {
    chapterNameCtrl.dispose();
    startPageCtrl.dispose();
    endPageCtrl.dispose();
    super.onClose();
  }
}