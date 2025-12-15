// controller/testmode_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TestMode { online, paper }

class TestModeController extends GetxController {
  // Current selection
  var selectedMode = TestMode.online.obs;

  // Bottom settings (dynamic)
  var duration = 90.obs; // minutes
  var difficulty = "Mixed".obs;
  var questionTypes = "MCQ, True/False, Fill-in".obs;
  var settingsName = "Moffy Settings".obs;

  // Online Test Data
  final Map<String, dynamic> onlineTestData = {
    "title": "Online Test",
    "subtitle": "Take the test directly on your device with real-time features and instant results",
    "icon": Icons.computer,
    "color": const Color(0xFF2196F3),
    'features': [
    {
      'text': 'Live timer with warnings',
      'icon': Icons.timer,
      'color': const Color(0xFF2196F3),
    },
    {
      'text': 'Instant results & analysis',
      'icon': Icons.insights_rounded,
      'color': const Color(0xFF2196F3),
    },
    {
      'text': 'Question review & navigation',
      'icon': Icons.swap_horiz_rounded,
      'color': const Color(0xFF2196F3),
    },
    {
      'text': 'Performance analytics',
      'icon': Icons.bar_chart_rounded,
      'color': const Color(0xFF2196F3),
    },
    ],
    "pros": ["Automatic scoring", "Save progress", "Detailed analytics"],
    "cons": ["Requires stable internet", "Screen-based reading"],
    "buttonText": "Start Online Test"
  };

  // On-Paper Test Data
  final Map<String, dynamic> paperTestData = {
    "title": "On-Paper Test",
    "tag": "Traditional",
    "subtitle": "Download and print the test paper for traditional exam-style practice with manual timing",
    "icon": Icons.description,
    "color": const Color.fromARGB(255, 34, 120, 90),

    "buttonText": "Generate Paper Test"
  };

  void selectMode(TestMode mode) {
    selectedMode.value = mode;
  }

  void startOnlineTest() {
    Get.snackbar("Started", "Online Test is starting...", backgroundColor: Colors.blue, colorText: Colors.white);
    // Navigate to test screen
  }

  void generatePaperTest() {
    Get.snackbar("Generating", "PDF is being generated...", backgroundColor: Color(0xFF34BF8E), colorText: Colors.white);
    // Generate PDF
  }
}