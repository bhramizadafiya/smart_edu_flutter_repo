// lib/modules/onlinetest/controller/onlinetest_controller.dart

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/onlinetestsummary/controller/onlinetestsummary_controller.dart';

class Question {
  final String text;
  final List<String> options;
  final dynamic correctAnswer;
  final String type;
  final int marks;

  Question({
    required this.text,
    this.options = const [],
    required this.correctAnswer,
    required this.type,
    required this.marks,
  });
}

class OnlineTestController extends GetxController {
  final ScrollController paletteScrollController = ScrollController();
  Timer? _timer;

  // Fixed: use normal int with .obs (RxInt)
  final RxInt currentIndex = 0.obs;
  final RxInt totalQuestions = 0.obs;
  final RxInt answeredCount = 0.obs;
  final RxInt remainingTime = 0.obs;

  final RxList<Question> allQuestions = <Question>[].obs;
  final RxList<dynamic> userAnswers = <dynamic>[].obs;
  final RxList<int> reviewList = <int>[].obs;

  late OnlineTestSummaryController controller; // Add this line

  late List<String> selectedQuestionTypes;
  late int durationInMinutes;

  int mcqMarksPerQ = 4;
  int tfMarksPerQ = 2;
  int fibMarksPerQ = 3;

  final Random random = Random();

  @override
  void onInit() {
    super.onInit();

    controller = Get.find<OnlineTestSummaryController>();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) {
      Get.snackbar("Error", "No test data!", backgroundColor: Colors.red);
      Get.back();
      return;
    }

    selectedQuestionTypes = List<String>.from(args['questionTypes'] ?? []);
    durationInMinutes = args['durationInMinutes'] as int? ?? 90;
    final int? totalFromSummary = args['totalQuestionsFromSummary'] as int?;

    mcqMarksPerQ = args['mcqMarksPerQ'] as int? ?? 4;
    tfMarksPerQ = args['tfMarksPerQ'] as int? ?? 2;
    fibMarksPerQ = args['fibMarksPerQ'] as int? ?? 3;

    if (selectedQuestionTypes.isEmpty) {
      Get.snackbar("Error", "No question types selected!", backgroundColor: Colors.red);
      Get.back();
      return;
    }

        _prepareQuestions();

    if (allQuestions.isEmpty) {
      Get.snackbar("Error", "No questions loaded!", backgroundColor: Colors.red);
      Get.back();
      return;
    }

    // FIXED: Show EXACT number of questions selected in summary
    if (totalFromSummary != null && 
        totalFromSummary > 0 && 
        totalFromSummary <= allQuestions.length) {
      totalQuestions.value = totalFromSummary;
      allQuestions.assignAll(allQuestions.take(totalFromSummary).toList());
    } else {
      // Fallback: use all available if something wrong
      totalQuestions.value = allQuestions.length;
    }

    // Initialize user answers with correct length
    userAnswers.assignAll(List.filled(totalQuestions.value, null));

    // Start timer
    remainingTime.value = durationInMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        _timer?.cancel();
        submitTest();
      }
    });
  }

  String get formattedTime {
    final secs = remainingTime.value;
    if (secs <= 0) return "00:00";
    final m = (secs ~/ 60).toString().padLeft(2, '0');
    final s = (secs % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

 void _prepareQuestions() {
  List<Question> selectedPool = [];

  // Get exact number from summary controller
  final int tfCount = controller.tfQuestions.value;
  final int fibCount = controller.fibQuestions.value;
  final int mcqCount = controller.mcqQuestions.value;

  // Add exact number of each type (in order: MCQ → TF → FIB)
  if (selectedQuestionTypes.contains("Multiple Choice Questions") && mcqCount > 0) {
    final mcqList = _getMcqs();
    selectedPool.addAll(mcqList.take(mcqCount));
  }
  if (selectedQuestionTypes.contains("True/False Questions") && tfCount > 0) {
    final tfList = _getTrueFalse();
    selectedPool.addAll(tfList.take(tfCount));
  }
  if (selectedQuestionTypes.contains("Fill in the Blanks") && fibCount > 0) {
    final fibList = _getFillInBlanks();
    selectedPool.addAll(fibList.take(fibCount));
  }

  if (selectedPool.isEmpty) {
    Get.snackbar("Error", "No questions available!", backgroundColor: Colors.red);
    Get.back();
    return;
  }

  // Shuffle only the final selected list → order is random, but count is exact!
  selectedPool.shuffle(random);
  allQuestions.assignAll(selectedPool);
}

  List<Question> _getMcqs() => List.generate(100, (i) {
        final a = (i % 20) + 2;
        final b = (i % 15) + 2;
        final correct = a * b;
        final opts = [correct, correct + 7, correct - 5, correct + 12]..shuffle(random);
        return Question(
          text: "What is $a × $b?",
          options: opts.map((e) => e.toString()).toList(),
          correctAnswer: opts.indexOf(correct),
          type: "mcq",
          marks: mcqMarksPerQ,
        );
      });

  List<Question> _getTrueFalse() => List.generate(80, (i) {
        final correct = i % 3 == 0;
        final val = i + 10;
        return Question(
          text: "$val × 2 = ${correct ? val * 2 : val * 2 + 1}",
          options: const ["True", "False"],
          correctAnswer: correct ? 0 : 1,
          type: "true_false",
          marks: tfMarksPerQ,
        );
      });

  List<Question> _getFillInBlanks() {
   final templates = [
  () => Question(text: "Capital of France is ______", correctAnswer: "paris", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "π ≈ ______ (2 decimals)", correctAnswer: "3.14", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "Speed of light is ______ m/s", correctAnswer: "300000000", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "Chemical symbol for Gold is ______", correctAnswer: "au", type: "fib", marks: fibMarksPerQ),

  // === 10 MORE ADDED BELOW ===
  () => Question(text: "Largest planet in the solar system is ______", correctAnswer: "jupiter", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "Number of bones in an adult human body is ______", correctAnswer: "206", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "Chemical symbol for Water is ______", correctAnswer: "h2o", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "Inventor of the telephone is ______", correctAnswer: "alexander graham bell", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "Smallest prime number is ______", correctAnswer: "2", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "Currency of Japan is ______", correctAnswer: "yen", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "Longest river in the world is ______", correctAnswer: "nile", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "Atomic number of Carbon is ______", correctAnswer: "6", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "Planet closest to the Sun is ______", correctAnswer: "mercury", type: "fib", marks: fibMarksPerQ),
  () => Question(text: "E = mc² was proposed by ______", correctAnswer: "albert einstein", type: "fib", marks: fibMarksPerQ),
];
    return List.generate(100, (_) => templates[random.nextInt(templates.length)]());
  }

  // Fixed: use .value to set
  void selectOption(int optionIndex) {
    final idx = currentIndex.value;
    if (userAnswers[idx] == null) answeredCount.value++;
    userAnswers[idx] = optionIndex;
  }

  void answerFib(String text) {
    final idx = currentIndex.value;
    final trimmed = text.trim();
    final wasEmpty = (userAnswers[idx] as String? ?? "").trim().isEmpty;

    userAnswers[idx] = trimmed;

    if (wasEmpty && trimmed.isNotEmpty) answeredCount.value++;
    if (!wasEmpty && trimmed.isEmpty) answeredCount.value--;
  }

  void clearResponse() {
    final idx = currentIndex.value;
    if (userAnswers[idx] != null) {
      userAnswers[idx] = null;
      answeredCount.value--;
    }
  }

  void toggleReview() {
    final idx = currentIndex.value;
    if (reviewList.contains(idx)) {
      reviewList.remove(idx);
    } else {
      reviewList.add(idx);
    }
  }

  // Fixed navigation methods
  void goToPrevious() {
    if (currentIndex.value > 0) currentIndex.value--;
  }

  void goToNext() {
    if (currentIndex.value < totalQuestions.value - 1) currentIndex.value++;
  }

  void goToQuestion(int index) {
    currentIndex.value = index;
  }

  // 100% CORRECT SCORING – ONLY COUNTS QUESTIONS ACTUALLY SHOWN
  void submitTest() {
    _timer?.cancel();

    final args = Get.arguments as Map<String, dynamic>? ?? {};

    int totalEarned = 0;
    int totalPossible = 0;

    int mcqCorrect = 0, mcqTotal = 0, mcqEarned = 0, mcqPossible = 0;
    int tfCorrect = 0, tfTotal = 0, tfEarned = 0, tfPossible = 0;
    int fibCorrect = 0, fibTotal = 0, fibEarned = 0, fibPossible = 0;

    for (int i = 0; i < allQuestions.length; i++) {
      final q = allQuestions[i];
      final userAnswer = i < userAnswers.length ? userAnswers[i] : null;

      bool isCorrect = false;

      if (q.type == "fib") {
        String user = (userAnswer as String?)?.trim().toLowerCase() ?? "";
        String correct = q.correctAnswer.toString().toLowerCase();
        isCorrect = user == correct && user.isNotEmpty;
      } else {
        isCorrect = userAnswer == q.correctAnswer;
      }

      final int marks = q.marks;
      totalPossible += marks;
      if (isCorrect) totalEarned += marks;

      if (q.type == "mcq") {
        mcqTotal++;
        mcqPossible += marks;
        if (isCorrect) {
          mcqCorrect++;
          mcqEarned += marks;
        }
      } else if (q.type == "true_false") {
        tfTotal++;
        tfPossible += marks;
        if (isCorrect) {
          tfCorrect++;
          tfEarned += marks;
        }
      } else if (q.type == "fib") {
        fibTotal++;
        fibPossible += marks;
        if (isCorrect) {
          fibCorrect++;
          fibEarned += marks;
        }
      }
    }

    final int percentage = totalPossible == 0 ? 0 : ((totalEarned / totalPossible) * 100).round();

    final int timeUsed = durationInMinutes - (remainingTime.value / 60).ceil();
    final int timeRemaining = (remainingTime.value / 60).floor();

  Get.offNamed('/testresult', arguments: {
  'totalMarksEarned': totalEarned,
  'totalMarks': args['totalMarksFromSummary'] ?? totalPossible, // Show original total

  // Original question counts from summary (for accurate display)
  'mcqTotal': args['mcqQuestionsCount'] ?? 0,
  'tfTotal': args['tfQuestionsCount'] ?? 0,
  'fibTotal': args['fibQuestionsCount'] ?? 0,

  // Correct answers & marks (calculated)
  'mcqCorrect': mcqCorrect,
  'tfCorrect': tfCorrect,
  'fibCorrect': fibCorrect,



  'mcqMarks': mcqEarned,
  'tfMarks': tfEarned,
  'fibMarks': fibEarned,

  'mcqTotalMarks': (args['mcqQuestionsCount'] ?? 0) * mcqMarksPerQ,
  'tfTotalMarks': (args['tfQuestionsCount'] ?? 0) * tfMarksPerQ,
  'fibTotalMarks': (args['fibQuestionsCount'] ?? 0) * fibMarksPerQ,

  'timeUsed': timeUsed,
  'timeRemaining': timeRemaining,

  // ADD THESE TWO LINES – THIS IS THE KEY
  'allQuestions': allQuestions,   // ← pass questions
  'userAnswers':  userAnswers,    // ← pass user answers
});
  }

  bool get isLastQuestion => currentIndex.value == totalQuestions.value - 1;
  bool get isFirstQuestion => currentIndex.value == 0;

  @override
  void onClose() {
    _timer?.cancel();
    paletteScrollController.dispose();
    super.onClose();
  }

 void viewSolutions() {
  // DO NOT use Get.find<OnlineTestController>() here — it fails after test ends!
  // Instead, pass the data directly from current instance

  Get.toNamed(
    '/viewsolutions',
    arguments: {
      'allQuestions': allQuestions,      // Current instance has the data
      'userAnswers': userAnswers,        // Current instance has the data
    },
  );
}
}