// lib/modules/coresubjects/controller/coresubjects_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api_endpoints.dart';
import '../../../utils/auth_token_service.dart';

class CoreSubjectsController extends GetxController {
  // Dynamic class information from previous screen
  late final int classNumber;
  late final String classTitle;
  late final String standardId; // Required for API call

  // Header gradient (based on class)
  late final List<Color> headerGradient;

  // Subjects fetched from API
  final subjects = RxList<Map<String, dynamic>>([]);
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  final AuthTokenService authService = Get.find<AuthTokenService>();

  @override
  void onInit() {
    super.onInit();

    // Get arguments passed from Standards screen
    final args = Get.arguments as Map<String, dynamic>?;

    classNumber = args?['classNumber'] as int? ?? 11;
    classTitle = args?['classTitle'] as String? ?? 'Class $classNumber';
    standardId = args?['standard_id'] as String? ?? '';

    // Set header gradient based on class number
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

    // Fetch subjects if standardId is provided
    if (standardId.isNotEmpty) {
      fetchSubjects();
    } else {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = 'No standard selected';
    }
  }

  /// Fetch subjects from API using standard_id
  Future<void> fetchSubjects() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    try {
      final headers = await authService.getAuthHeaders();

      final uri = Uri.parse(ApiConfig.getSubjectsByStandardId);

      final body = jsonEncode({
        "standard_id": standardId,
      });

      final response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      debugPrint('API Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'success' && jsonData['statuscode'] == 200) {
          final List<dynamic> data = jsonData['data'] ?? [];

          subjects.clear();

          for (var item in data) {
            final String subjectName = item['subject_name']?.toString().trim() ?? 'Unknown';
            final String subjectId = item['subject_id']?.toString() ?? ''; // ← Added

            if (subjectName.isEmpty || subjectName == 'null') continue;

            // Map subject to gradient and color
            final subjectConfig = _getSubjectConfig(subjectName);

            subjects.add({
              "title": subjectName,
              "subtitle": subjectConfig['subtitle'],
              "color": subjectConfig['color'],
              "gradientColors": subjectConfig['gradientColors'],
              "subject_id": subjectId, // ← Added
            });
          }

          if (subjects.isEmpty) {
            hasError.value = true;
            errorMessage.value = 'No subjects available for this standard';
          }
        } else {
          throw Exception(jsonData['message'] ?? 'Failed to load subjects');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching subjects: $e');
      hasError.value = true;
      errorMessage.value = 'Failed to load subjects. Please try again later.';

      Get.snackbar(
        'Error',
        'Unable to fetch subjects',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade800,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Helper: Define gradient, color, and subtitle for each subject
  Map<String, dynamic> _getSubjectConfig(String subjectName) {
    final lowerName = subjectName.toLowerCase();

    switch (lowerName) {
      case 'mathematics':
      case 'maths':
        return {
          'color': const Color(0xFF1976D2),
          'gradientColors': const [Color(0xFF42A5F5), Color(0xFF1976D2), Color(0xFF0D47A1)],
          'subtitle': 'Foundation for engineering & competitive exams',
        };
      case 'physics':
        return {
          'color': const Color(0xFFFF9800),
          'gradientColors': const [Color(0xFFFFB74D), Color(0xFFFF9800), Color(0xFFF57C00)],
          'subtitle': 'Mechanics, Electricity,\nModern Physics & more',
        };
      case 'chemistry':
        return {
          'color': const Color(0xFFE91E63),
          'gradientColors': const [Color(0xFFF06292), Color(0xFFE91E63), Color(0xFFC2185B)],
          'subtitle': 'Organic, Inorganic & Physical',
        };
      case 'biology':
        return {
          'color': const Color(0xFF2E7D32),
          'gradientColors': const [Color(0xFF66BB6A), Color(0xFF2E7D32), Color(0xFF1B5E20)],
          'subtitle': 'Botany & Zoology for NEET',
        };
      case 'english':
        return {
          'color': const Color(0xFF3949AB),
          'gradientColors': const [Color(0xFF7986CB), Color(0xFF3949AB), Color(0xFF283593)],
          'subtitle': 'Advanced Grammar & Literature',
        };
      case 'hindi':
        return {
          'color': const Color(0xFF9C27B0),
          'gradientColors': const [Color(0xFFBA68C8), Color(0xFF9C27B0), Color(0xFF7B1FA2)],
          'subtitle': 'हिन्दी साहित्य एवं व्याकरण',
        };
      case 'sanskrit':
        return {
          'color': const Color(0xFFEF6C00),
          'gradientColors': const [Color(0xFFFF8A65), Color(0xFFEF6C00), Color(0xFFB53D00)],
          'subtitle': 'संस्कृत व्याकरण एवं साहित्य',
        };
      case 'social science':
        return {
          'color': const Color(0xFF795548),
          'gradientColors': const [Color(0xFFA1887F), Color(0xFF795548), Color(0xFF5D4037)],
          'subtitle': 'History, Geography, Civics & Economics',
        };
      case 'it':
        return {
          'color': const Color(0xFF1565C0),
          'gradientColors': const [Color(0xFF42A5F5), Color(0xFF1565C0), Color(0xFF0D47A1)],
          'subtitle': 'Programming, Database & Web Technology',
        };
      default:
        return {
          'color': const Color(0xFF66D1B2),
          'gradientColors': const [Color(0xFF66D1B2), Color(0xFF3BAA8F), Color(0xFF1C524A)],
          'subtitle': 'Comprehensive study material and practice',
        };
    }
  }

  /// Called when a subject card is tapped
  void onSubjectTap(String subjectName, String subjectId) {
    Get.toNamed('/uploadresource', arguments: {
      'standard_id': standardId,
      'subject_id': subjectId,
      'subject_name': subjectName,
    });
  }
}