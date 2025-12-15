import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../chapterlist/controller/chapterlist_controller.dart';

class AddChapterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController chapterNameCtrl = TextEditingController();
  final TextEditingController startPageCtrl = TextEditingController(text: '1');
  final TextEditingController endPageCtrl = TextEditingController(text: '1');

  final RxBool saving = false.obs;

  /// Optional: If you want to push the new chapter to ChapterListController
  ChapterListController? chapterListController;

  @override
  void onInit() {
    super.onInit();
    // try to find ChapterListController if it's already in memory
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
    final form = formKey.currentState;
    if (form == null) return;
    if (!form.validate()) return;

    final start = int.parse(startPageCtrl.text.trim());
    final end = int.parse(endPageCtrl.text.trim());
    if (start > end) {
      Get.snackbar(
        'Invalid pages',
        'Start page cannot be greater than End page',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    saving.value = true;

    // simulate API / DB delay
    await Future.delayed(const Duration(milliseconds: 500));

    final chapter = {
      'title': chapterNameCtrl.text.trim(),
      'pages': 'Pages $start–$end • ${end - start + 1} pages',
    };

    // If ChapterListController exists add the new chapter there
    if (chapterListController != null) {
      chapterListController!.addChapter(chapter);
    } else {
      // fallback: store locally or show toast
      debugPrint(
        'No ChapterListController found — chapter created locally: $chapter',
      );
    }

    saving.value = false;
    Get.back(); // close Add chapter screen
    Get.snackbar(
      'Saved',
      'Chapter saved successfully',
      snackPosition: SnackPosition.BOTTOM,
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
