// lib/modules/testconfiguration/controller/testconfiguration_controller.dart
import 'package:get/get.dart';
import 'package:smarted/modules/onlinetestsummary/binding/onlinetestsummary_binding.dart';
import 'package:smarted/modules/onlinetestsummary/view/onlinetestsummary_view.dart';

class TestConfigurationController extends GetxController {
  // Question Types
  var multipleChoice = true.obs;
  var trueFalse = true.obs;
  var fillInTheBlanks = false.obs;

  // Duration
  var selectedDuration = "standard".obs;
  var customHours = 1.obs;
  var customMinutes = 30.obs;

  final List<Map<String, dynamic>> durationOptions = [
    {"key": "quick", "title": "Quick Test", "duration": "30 minutes"},
    {"key": "standard", "title": "Standard Test", "duration": "90 minutes"},
    {"key": "extended", "title": "Extended Test", "duration": "180 minutes"},
    {"key": "custom", "title": "Custom Duration", "isCustom": true},
  ];

  final List<int> hoursList = List.generate(13, (i) => i);
  final List<int> minutesList = List.generate(60, (i) => i);

  var selectedDifficulties = <String>[].obs;
  var aiCustomization = false.obs;

  @override
  void onInit() {
    super.onInit();
    selectedDifficulties.add("Medium");
  }

  void toggleDifficulty(String level) {
    if (selectedDifficulties.contains(level)) {
      selectedDifficulties.remove(level);
    } else {
      selectedDifficulties.add(level);
    }
  }

  void selectDuration(String key) {
    selectedDuration.value = key;
  }

 // lib/modules/testconfiguration/controller/testconfiguration_controller.dart

void goToNext() {
  String durationText;
  int durationInMinutes = 90;   // ← default

  if (selectedDuration.value == "custom") {
    final h = customHours.value;
    final m = customMinutes.value;
    durationInMinutes = h * 60 + m;
    if (durationInMinutes == 0) durationInMinutes = 30;

    durationText = h > 0
        ? m > 0
            ? "$h" + "h $m" + "m"
            : "$h" + "h"
        : "$m" + "m";
  } else {
    final option = durationOptions.firstWhere((e) => e['key'] == selectedDuration.value);
    durationText = option['duration'] ?? "90 minutes";

    // Convert standard options to minutes
    switch (selectedDuration.value) {
      case "quick":
        durationInMinutes = 30;
        break;
      case "standard":
        durationInMinutes = 90;
        break;
      case "extended":
        durationInMinutes = 180;
        break;
    }
  }

  final config = {
    'selectedQuestionTypes': {
      'mcq': multipleChoice.value,
      'tf': trueFalse.value,
      'fib': fillInTheBlanks.value,
    },
    'duration': durationText,                    // for display only
    'durationMinutes': durationInMinutes,        // ← THIS IS THE KEY
    'difficulty': selectedDifficulties.isEmpty ? ['Medium'] : selectedDifficulties.toList(),
  };

  Get.to(
    () => const OnlineTestSummaryView(),
    binding: OnlineTestSummaryBinding(),
    arguments: config,
  );
}
}