// lib/modules/testresult/controller/testresult_controller.dart
import 'package:flutter/material.dart';
import 'package:get/Get.dart';

class TestResultController extends GetxController {
  // Overall Score
  int overallPercentage = 0;
  int totalMarksEarned = 0;
  int totalMarks = 0;

  // MCQ Stats
  int mcqCorrect = 0;
  int mcqTotal = 0;
  int mcqEarnedMarks = 0;
  int mcqTotalMarks = 0;
  int mcqPercentage = 0;

  // True/False Stats
  int tfCorrect = 0;
  int tfTotal = 0;
  int tfEarnedMarks = 0;
  int tfTotalMarks = 0;
  int tfPercentage = 0;

  // Fill in the Blanks Stats
  int fibCorrect = 0;
  int fibTotal = 0;
  int fibEarnedMarks = 0;
  int fibTotalMarks = 0;
  int fibPercentage = 0;

  final RxBool hasMcq = false.obs;
final RxBool hasTf = false.obs;
final RxBool hasFib = false.obs;

  // Time Stats
  int timeUsed = 0;
  int timeRemaining = 0;

@override
void onInit() {
  super.onInit();
  final args = Get.arguments as Map<String, dynamic>? ?? {};

  totalMarksEarned = args['totalMarksEarned'] ?? 0;
  totalMarks = args['totalMarks'] ?? 0; // This is now original total from summary
  overallPercentage = totalMarks == 0 ? 0 : ((totalMarksEarned / totalMarks) * 100).round();

  // Use original question counts from summary
  mcqTotal = args['mcqTotal'] ?? 0;
  tfTotal = args['tfTotal'] ?? 0;
  fibTotal = args['fibTotal'] ?? 0;

  mcqCorrect = args['mcqCorrect'] ?? 0;
  tfCorrect = args['tfCorrect'] ?? 0;
  fibCorrect = args['fibCorrect'] ?? 0;

  mcqEarnedMarks = args['mcqMarks'] ?? 0;
  tfEarnedMarks = args['tfMarks'] ?? 0;
  fibEarnedMarks = args['fibMarks'] ?? 0;

  mcqTotalMarks = args['mcqTotalMarks'] ?? 0;
  tfTotalMarks = args['tfTotalMarks'] ?? 0;
  fibTotalMarks = args['fibTotalMarks'] ?? 0;

  mcqPercentage = mcqTotal > 0 ? ((mcqCorrect / mcqTotal) * 100).round() : 0;
  tfPercentage = tfTotal > 0 ? ((tfCorrect / tfTotal) * 100).round() : 0;
  fibPercentage = fibTotal > 0 ? ((fibCorrect / fibTotal) * 100).round() : 0;

  timeUsed = args['timeUsed'] ?? 0;
  timeRemaining = args['timeRemaining'] ?? 0;
}
  // Action Buttons
void viewSolutions() {
  final args = Get.arguments as Map<String, dynamic>?;
  if (args == null) return;

  Get.toNamed('/viewsolutions', arguments: {
    'allQuestions': args['allQuestions'],
    'userAnswers':  args['userAnswers'],
  });
}

  void retakeTest() {
    Get.back();
  }

  

  void downloadResult() {
    Get.snackbar(
      "Downloaded!",
      "Your result PDF has been downloaded successfully.",
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.download_done, color: Colors.white),
    );
  }
}