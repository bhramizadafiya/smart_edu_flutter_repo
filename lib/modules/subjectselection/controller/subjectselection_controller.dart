// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectSelectionController extends GetxController {
  // Reactive list so UI updates if data changes dynamically
  var subjects = <Map<String, dynamic>>[
    {
      "title": "Mathematics",
      "subtitle": "Foundation for engineering & competitive exams",
      "color": 0xFF3B82F6,
      "icon": "math",
    },
    {
      "title": "Science",
      "subtitle": "NEET & JEE foundation preparation",
      "color": 0xFF10B981,
      "icon": "science",
    },
    {
      "title": "Physics",
      "subtitle": "Essential communication skills development",
      "color": 0xFFF59E0B,
      "icon": "en",
    },
  ].obs;

  /// Show snackbar when a subject is tapped
  void onSubjectTap(String subjectName) {
    // Get.snackbar(
    //   "Subject Selected",
    //   subjectName,
    //   snackPosition: SnackPosition.BOTTOM,
    //   margin: const EdgeInsets.all(12),
    // );

    Get.toNamed('/feature-selection', arguments: {'subject': subjectName});
  }
}
