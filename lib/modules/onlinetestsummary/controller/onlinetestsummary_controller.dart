// lib/modules/onlinetestsummary/controller/onlinetestsummary_controller.dart

import 'package:get/Get.dart';
import 'package:smarted/modules/onlinetest/binding/onlinetest_binding.dart';
import 'package:smarted/modules/onlinetest/view/onlinetest_view.dart';

class OnlineTestSummaryController extends GetxController {
  final RxInt mcqQuestions = 15.obs;
  final RxInt mcqMarksPerQ = 4.obs;
  final RxInt tfQuestions = 10.obs;
  final RxInt tfMarksPerQ = 2.obs;
  final RxInt fibQuestions = 8.obs;
  final RxInt fibMarksPerQ = 3.obs;

  final RxInt mcqTotal = 0.obs;
  final RxInt tfTotal = 0.obs;
  final RxInt fibTotal = 0.obs;

  final RxInt totalQuestions = 0.obs;
  final RxInt totalMarks = 0.obs;

  // THIS IS THE SOURCE OF TRUTH – integer minutes
  final RxInt testDurationMinutes = 90.obs;

  // FIXED: Beautiful formatted duration getter
  String get testDuration {
    final int mins = testDurationMinutes.value;
    if (mins < 60) return "$mins m";
    final h = mins ~/ 60;
    final m = mins % 60;
    return m > 0 ? "$h h $m m" : "$h h";
  }

  final RxString difficulty = "Medium".obs;
  final RxBool showMcq = true.obs;
  final RxBool showTf = true.obs;
  final RxBool showFib = true.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      final types = args['selectedQuestionTypes'] as Map<String, dynamic>?;
      if (types != null) {
        showMcq.value = types['mcq'] == true;
        showTf.value = types['tf'] == true;
        showFib.value = types['fib'] == true;
      }

      if (args['durationMinutes'] != null) {
        testDurationMinutes.value = args['durationMinutes'] as int;
      }

      // Handle difficulty safely (String or List)
      if (args['difficulty'] != null) {
        final diff = args['difficulty'];
        if (diff is String) {
          difficulty.value = diff;
        } else if (diff is List) {
          difficulty.value = diff.join(", ");
        }
      }
    }

    

    // Reactive updates
    debounce(mcqQuestions, (_) => _updateTotals(), time: 100.milliseconds);
    debounce(mcqMarksPerQ, (_) => _updateTotals(), time: 100.milliseconds);
    debounce(tfQuestions, (_) => _updateTotals(), time: 100.milliseconds);
    debounce(tfMarksPerQ, (_) => _updateTotals(), time: 100.milliseconds);
    debounce(fibQuestions, (_) => _updateTotals(), time: 100.milliseconds);
    debounce(fibMarksPerQ, (_) => _updateTotals(), time: 100.milliseconds);
    debounce(showMcq, (_) => _updateTotals(), time: 100.milliseconds);
    debounce(showTf, (_) => _updateTotals(), time: 100.milliseconds);
    debounce(showFib, (_) => _updateTotals(), time: 100.milliseconds);

    _updateTotals();
  }

  void _updateTotals() {
    mcqTotal.value = mcqQuestions.value * mcqMarksPerQ.value;
    tfTotal.value = tfQuestions.value * tfMarksPerQ.value;
    fibTotal.value = fibQuestions.value * fibMarksPerQ.value;

    int q = 0, m = 0;
    if (showMcq.value) { q += mcqQuestions.value; m += mcqTotal.value; }
    if (showTf.value) { q += tfQuestions.value; m += tfTotal.value; }
    if (showFib.value) { q += fibQuestions.value; m += fibTotal.value; }

    totalQuestions.value = q;
    totalMarks.value = m;
  }

  

  void updateValue(RxInt obs, int change) {
    obs.value = (obs.value + change).clamp(0, 100);
  }

  void goToPrevious() => Get.back();

void startTest() {
  final List<String> types = [];
  if (showMcq.value) types.add("Multiple Choice Questions");
  if (showTf.value) types.add("True/False Questions");
  if (showFib.value) types.add("Fill in the Blanks");

  Get.to(
    () => const OnlineTestView(),
    binding: OnlineTestBinding(),
    arguments: {
      'questionTypes': types,
      'durationInMinutes': testDurationMinutes.value,

      // CRITICAL FIX: Only pass count if the type is ENABLED
      'mcqQuestionsCount': showMcq.value ? mcqQuestions.value : 0,
      'tfQuestionsCount': showTf.value ? tfQuestions.value : 0,
      'fibQuestionsCount': showFib.value ? fibQuestions.value : 0,

      'mcqMarksPerQ': mcqMarksPerQ.value,
      'tfMarksPerQ': tfMarksPerQ.value,
      'fibMarksPerQ': fibMarksPerQ.value,

      'totalQuestionsFromSummary': totalQuestions.value,
      'totalMarksFromSummary': totalMarks.value,
    },
  );
}
}