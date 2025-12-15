// lib/modules/viewsolutions/controller/viewsolutions_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/onlinetest/controller/onlinetest_controller.dart'; // This line is CRITICAL

class ViewSolutionsController extends GetxController {
  late List<Question> allQuestions;   // Real Question objects
  late List<dynamic> userAnswers;

  final RxString currentFilter = "All".obs; 

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null ||
        args['allQuestions'] == null ||
        args['userAnswers'] == null) {
      Get.snackbar("Error", "No solutions data", backgroundColor: Colors.red);
      Get.back();
      return;
    }

    // This is the correct way – objects are already Question instances
    allQuestions = (args['allQuestions'] as List)
        .map((e) => e as Question)   // Safe cast
        .toList();

    userAnswers = List<dynamic>.from(args['userAnswers'] as List);

    // Fix length mismatch
    while (userAnswers.length < allQuestions.length) {
      userAnswers.add(null);
    }

    print("ViewSolutions → ${allQuestions.length} questions loaded successfully");
  }

  bool isCorrect(int index) {
    final q = allQuestions[index];
    final ans = index < userAnswers.length ? userAnswers[index] : null;

    if (q.type == "fib") {
      String userInput = (ans?.toString() ?? "").trim().toLowerCase();
      String correct = q.correctAnswer.toString().trim().toLowerCase();
      return userInput.isNotEmpty && userInput == correct;
    }

    return ans == q.correctAnswer;
  }

  Color getOptionColor(int qIndex, int optIndex) {
    final ans = userAnswers[qIndex];
    final correct = allQuestions[qIndex].correctAnswer;

    if (optIndex == correct) return Colors.green.withOpacity(0.35);
    if (ans == optIndex) return Colors.red.withOpacity(0.35);
    return Colors.transparent;
  }
}