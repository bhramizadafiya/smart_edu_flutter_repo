// controllers/uploadresource_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/addchapter/view/addchapter_view.dart';
import 'package:smarted/modules/addstudymaterial/view/addstudymaterial_view.dart';
import 'package:smarted/modules/chapterlist/view/chapterlist_view.dart';
import 'package:smarted/modules/chatscreen/controller/chatscreen_controller.dart';
import 'package:smarted/modules/chatscreen/view/chatscreen_view.dart';
import 'package:smarted/modules/languageselection/controller/languageselection_controller.dart';
import 'package:smarted/modules/languageselection/view/languageselection_view.dart';
import 'package:smarted/modules/mocktest/controller/mocktest_controller.dart';
import 'package:smarted/modules/mocktest/view/mocktest_view.dart';
import 'package:smarted/modules/studymateriallist/controller/studymateriallist_controller.dart';
import 'package:smarted/modules/studymateriallist/view/studymateriallist_view.dart';

class FeatureItem {
  final String title;
  final String subtitle;
  final List<String> tags;
  final IconData icon;
  final Color color;
  final Color lightColor;
  final List<Color> gradientColors;
  final String buttonText;
  final IconData buttonIcon;

  FeatureItem({
    required this.title,
    required this.subtitle,
    required this.tags,
    required this.icon,
    required this.color,
    required this.lightColor,
    required this.gradientColors,
    required this.buttonText,
    required this.buttonIcon,
  
  });
}

class UploadResourceController extends GetxController {
  var subjectName = "Subject".obs;


   final features = <FeatureItem>[
    FeatureItem(
      title: "Upload Resources",
      subtitle: "Upload your textbooks, notes, and study materials for AI-powered assistance",
      tags: ["PDF Support", "OCR Scanning", "Smart Search"],
      icon: Icons.cloud_upload_rounded,
      color:   Color(0xFF2E88FF),
      lightColor: const Color(0xFFE3F2FD),
        gradientColors: const [
 Color(0xFF2E88FF),// Light Green
              Color(0xFF1B6BE0),  // Medium Green
              Color(0xFF0D47A1),  // Dark Green (bottom)
  ],
      buttonText: "Upload Materials",
      buttonIcon: Icons.add,
    ),
    FeatureItem(
      title: "AI Chat",
      subtitle: "Get instant answers, explanations, and step-by-step solutions from our AI tutor",
      tags: ["24/7 Available", "Multilingual", "Voice Chat"],
      icon: Icons.smart_toy_rounded,
      color: Color(0xFF3BAA8F),
      lightColor: const Color(0xFFE8F5E8),
      gradientColors: const [
    Color(0xFF66D1B2),  // Light Green
              Color(0xFF3BAA8F),  // Medium Green
              Color(0xFF1C524A),  // Dark Green (bottom)
  ],
      buttonText: "Start Chatting",
      buttonIcon: Icons.chat_bubble_outline_rounded,
    ),
  FeatureItem(
  title: "Mock Test",
 subtitle: "Take practice tests to evaluate your knowledge and track your progress",
 tags: ["Timed Tests", "Instant Results", "Performance"],
 icon: Icons.assignment_rounded,
 color: const Color(0xFFFF9800),           // Main orange
 lightColor: const Color(0xFFFFF3E0),       // Light orange background

 gradientColors: const [
   Color(0xFFFFB74D),  // Top glow – matches your icon perfectly
   Color(0xFFFF9800),  // Middle
   Color(0xFFF57C00),  // Deep bottom
 ],

 buttonText: "Take Test",
 buttonIcon: Icons.play_arrow_rounded,
),
    FeatureItem(
      title: "JEE/NEET Exams",
      subtitle: "Prepare for JEE, NEET and other competitive exams with specialized content",
      tags: ["JEE Prep", "NEET Ready", "Previous Papers"],
      icon: Icons.emoji_events_rounded,
      color: const Color(0xFFD32F2F),
      lightColor: const Color(0xFFFFEBEE),
      gradientColors: const [
    Color(0xFFFF5252),  // Top glow – matches your trophy icon perfectly
    Color(0xFFE53935),  // Middle
    Color(0xFFCC0000),  // Deep bottom
  ],
      buttonText: "Start Preparation",
      buttonIcon: Icons.school_rounded,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Get subject name from previous screen
    if (Get.arguments != null && Get.arguments is String) {
      subjectName.value = Get.arguments as String;
    }
  }

  // controllers/uploadresource_controller.dart

void onFeatureTap(int index) {
  switch (index) {
   case 0: // Upload Resources → Study Materials List
      // Put the controller first, then navigate
      Get.put(StudyMaterialListController());   // This line fixes the crash
      Get.to(() => const StudyMaterialListView());
      break;

    case 1: // AI Chat → Open Chat Screen
      Get.put(LanguageSelectionController());           // Put the CONTROLLER
      Get.to(() => const LanguageSelectionView());      // Navigate to View
      break;

    case 2: // Mock Test
    Get.put(MockTestController());
    Get.to(()=> const MockTestView());
 //   Get.toNamed('/mocktest');
    //  break;

    case 3: // JEE/NEET Exams
      Get.toNamed('/competitive-exams');
      break;

    default:
      Get.toNamed('/languageselection');
  }

  // Show snackbar
  Get.snackbar(
    "Feature Selected",
    features[index].title,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: features[index].color.withOpacity(0.9),
    colorText: Colors.white,
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 2),
  );
}
}