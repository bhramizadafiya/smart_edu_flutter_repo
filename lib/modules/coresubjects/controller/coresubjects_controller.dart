// lib/modules/coresubjects/controller/coresubjects_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoreSubjectsController extends GetxController {
  var showAllSubjects = false.obs;

  // Dynamic class information
  late final int classNumber;
  late final String classTitle;
  late final List<Color> headerGradient;

  // Core Subjects (shown by default)
  final List<Map<String, dynamic>> coreSubjects = [
    {
      "title": "Mathematics",
      "subtitle": "Foundation for engineering &\ncompetitive exams",
      "color": const Color(0xFF1976D2),
      "gradientColors": const [
        Color(0xFF42A5F5),
        Color(0xFF1976D2),
        Color(0xFF0D47A1)
      ],
    },
    {
      "title": "Science",
      "subtitle": "NEET & JEE foundation\npreparation",
      "color": const Color(0xFF3BAA8F),
      "gradientColors": const [
        Color(0xFF66D1B2),
        Color.fromARGB(255, 29, 152, 121),
        Color(0xFF1C524A)
      ],
    },
    {
      "title": "Physics",
      "subtitle": "Mechanics, Electricity,\nModern Physics & more",
      "color": const Color(0xFFFF9800),
      "gradientColors": const [
        Color(0xFFFFB74D),
        Color(0xFFFF9800),
        Color(0xFFF57C00)
      ],
    },
  ];

  // More Subjects (shown when "View More" is tapped)
  final List<Map<String, dynamic>> moreSubjects = [
    {
      "title": "Hindi",
      "subtitle": "हिन्दी साहित्य एवं व्याकरण",
      "color": const Color(0xFF9C27B0),
      "gradientColors": const [
        Color(0xFFBA68C8),
        Color(0xFF9C27B0),
        Color(0xFF7B1FA2)
      ],
    },
    {
      "title": "Sanskrit",
      "subtitle": "संस्कृत व्याकरण एवं साहित्य",
      "color": const Color(0xFFEF6C00),
      "gradientColors": const [
        Color(0xFFFF8A65),
        Color(0xFFEF6C00),
        Color(0xFFB53D00)
      ],
    },
    {
      "title": "Social Science",
      "subtitle": "History, Geography, Civics & Economics",
      "color": const Color(0xFF795548),
      "gradientColors": const [
        Color(0xFFA1887F),
        Color(0xFF795548),
        Color(0xFF5D4037)
      ],
    },
    {
      "title": "IT",
      "subtitle": "Programming, Database & Web Technology",
      "color": const Color(0xFF1565C0),
      "gradientColors": const [
        Color(0xFF42A5F5),
        Color(0xFF1565C0),
        Color(0xFF0D47A1)
      ],
    },
    {
      "title": "English",
      "subtitle": "Advanced Grammar & Literature",
      "color": const Color(0xFF3949AB),
      "gradientColors": const [
        Color(0xFF7986CB),
        Color(0xFF3949AB),
        Color(0xFF283593)
      ],
    },
    {
      "title": "Chemistry",
      "subtitle": "Organic, Inorganic & Physical",
      "color": const Color(0xFFE91E63),
      "gradientColors": const [
        Color(0xFFF06292),
        Color(0xFFE91E63),
        Color(0xFFC2185B)
      ],
    },
    {
      "title": "Biology",
      "subtitle": "Botany & Zoology for NEET",
      "color": const Color(0xFF2E7D32),
      "gradientColors": const [
        Color(0xFF66BB6A),
        Color(0xFF2E7D32),
        Color(0xFF1B5E20)
      ],
    },
  ];

  @override
  void onInit() {
    super.onInit();

    // Get arguments passed from Standards card tap
    final args = Get.arguments as Map<String, dynamic>?;

    classNumber = args?['classNumber'] as int? ?? 11;
    classTitle = args?['classTitle'] as String? ?? 'Class $classNumber';

    // Set header gradient based on class
    switch (classNumber) {
      case 10:
        headerGradient = const [
          Color(0xFF66D1B2),
          Color(0xFF3BAA8F),
          Color(0xFF1C524A),
        ];
        break;
      case 11:
        headerGradient = const [
          Color(0xFF42A5F5),
          Color(0xFF1E88E5),
          Color(0xFF1565C0),
        ];
        break;
      case 12:
        headerGradient = const [
          Color(0xFFF06292),
          Color(0xFFE91E63),
          Color(0xFFC2185B),
        ];
        break;
      default:
        headerGradient = const [
          Color(0xFF66D1B2),
          Color(0xFF3BAA8F),
          Color(0xFF1C524A),
        ];
    }
  }

  void toggleViewMore() {
    showAllSubjects.value = !showAllSubjects.value;
  }

  void onSubjectTap(String subjectName) {
    Get.toNamed('/uploadresource', arguments: subjectName);
  }
}