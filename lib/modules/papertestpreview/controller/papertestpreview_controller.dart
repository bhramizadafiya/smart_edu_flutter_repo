// papertestpreview_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/onpapertest/controller/onpapertest_controller.dart';
import 'package:smarted/theme/design_system.dart'; // Adjust path if needed

class PaperTestPreviewController extends GetxController {
  final RxString subjectName = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxString generatedPreview = ''.obs;
  final RxDouble progress = 75.0.obs;

  // Observe Answer Key toggle state from main controller
  late final OnTestPaperController onPaperTestController;

  // Local state for male/female icon (only shown when includeAnswerKey is true)
  final RxBool showAnswerKey = false.obs;

  @override
  void onInit() {
    super.onInit();
    onPaperTestController = Get.find<OnTestPaperController>();

    extractSubjectFromPrompt();

    // Listen to changes in includeAnswerKey from main controller
    ever(onPaperTestController.includeAnswerKey, (bool value) {
      // Optionally reset local toggle when entering preview
      showAnswerKey.value = false;
    });
  }

  void extractSubjectFromPrompt() {
    String prompt = onPaperTestController.promptController.text.toLowerCase();

    List<String> subjects = [
      'mathematics', 'maths', 'math', 'physics', 'chemistry', 'biology',
      'english', 'history', 'geography', 'science', 'social science',
      'hindi', 'computer science',
    ];

    for (String subj in subjects) {
      if (prompt.contains(subj)) {
        String formatted = subj.split(' ').map((s) => s[0].toUpperCase() + s.substring(1)).join(' ');
        subjectName.value = formatted;
        break;
      }
    }
    if (subjectName.value.isEmpty) subjectName.value = 'General';
  }

  void toggleAnswerKey() {
  // Optional: Keep local toggle if you still want to track state
  showAnswerKey.value = true; // Set to true when opening

  // Open the Answer Key full-screen page
  Get.toNamed('/answerkey');

  // Optional: Show a subtle notification (you can remove if not needed)
  Get.snackbar(
    'Answer Key',
    'Opening Answer Key...',
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 1),
    backgroundColor: AppColors.greenbutton.withOpacity(0.9),
    colorText: Colors.white,
    margin: const EdgeInsets.all(16),
    borderRadius: 8,
  );
}

  void increaseProgress() {
  if (progress.value < 200) {
    progress.value += 5;
  }
}

void decreaseProgress() {
  if (progress.value > 0) {
    progress.value -= 5;
  }
}

  void downloadTest() {
    Get.snackbar('Download', 'Downloading test paper...');
  }

  void previousPage() {
    if (currentPage.value > 1) currentPage.value--;
  }

  void nextPage() {
    if (currentPage.value < 6) currentPage.value++;
  }
}