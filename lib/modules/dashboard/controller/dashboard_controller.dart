// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import '../../../utils/api_endpoints.dart'; // adjust path if needed

// /// Small DTOs used by the controller
// class ActivityItem {
//   final String title;
//   final String meta;
//   final String timeAgo;
//   final Color color;
//   final String status;
//   ActivityItem({
//     required this.title,
//     required this.meta,
//     required this.timeAgo,
//     required this.color,
//     required this.status,
//   });
// }

// class StandardItem {
//   final String title;
//   final String subtitle;
//   final int badge;
//   final String progress;
//   StandardItem({
//     required this.title,
//     required this.subtitle,
//     required this.badge,
//     required this.progress,
//   });
// }

// class ExamItem {
//   final String code;
//   final String title;
//   final String subtitle;
//   final String difficulty;
//   ExamItem({
//     required this.code,
//     required this.title,
//     required this.subtitle,
//     required this.difficulty,
//   });
// }

// class DashboardController extends GetxController {
//   // Header (welcome text)
//   final welcome = 'Welcome back, John!'.obs;
//   final appTitle = 'YB Nexus'.obs;

//   // Progress placeholder - in a real app this can be detailed model
//   final hasProgress = false.obs;
//   final progressPercent = 0.0.obs;

//   // Recent Activity
//   final recentActivity = RxList<ActivityItem>([
//     ActivityItem(
//       title: 'Mathematics Mock Test',
//       meta: 'Scored 85% in Algebra & Geometry test',
//       timeAgo: '2 hours ago',
//       color: Colors.blue,
//       status: 'Completed',
//     ),
//     ActivityItem(
//       title: 'AI Chat Session',
//       meta: 'Discussed derivatives and limits concepts',
//       timeAgo: 'Yesterday',
//       color: Colors.green,
//       status: 'Discussion',
//     ),
//     ActivityItem(
//       title: 'Uploaded Study Material',
//       meta: 'Added Physics Chapter 5: Light & Reflection',
//       timeAgo: '3 days ago',
//       color: Colors.orange,
//       status: 'Uploaded',
//     ),
//     ActivityItem(
//       title: 'Practice Quiz Attempt',
//       meta: 'Attempted Chemistry quick quiz - Need improvement',
//       timeAgo: '5 days ago',
//       color: Colors.red,
//       status: 'Needs Work',
//     ),
//   ]);

//   // Standards
//   final standards = RxList<StandardItem>([
//     StandardItem(
//       title: 'Class 10th',
//       subtitle: 'CBSE Board Preparation',
//       badge: 10,
//       progress: 'In Progress',
//     ),
//     StandardItem(
//       title: 'Class 11th Science',
//       subtitle: 'PCM/PCB Stream',
//       badge: 11,
//       progress: 'Locked',
//     ),
//     StandardItem(
//       title: 'Class 12th Science',
//       subtitle: 'Board Exams & Entrance Prep',
//       badge: 12,
//       progress: 'Advanced',
//     ),
//   ]);

//   // Competitive Exams
//   final exams = RxList<ExamItem>([
//     ExamItem(
//       code: 'JEE',
//       title: 'JEE Main & Advanced',
//       subtitle: 'Engineering Entrance Preparation',
//       difficulty: 'High',
//     ),
//     ExamItem(
//       code: 'NEET',
//       title: 'NEET Medical Entrance',
//       subtitle: 'Medical & Dental Preparation',
//       difficulty: 'High',
//     ),
//     ExamItem(
//       code: 'UGC',
//       title: 'UGC NET',
//       subtitle: 'University Grants Commission',
//       difficulty: 'Medium',
//     ),
//     ExamItem(
//       code: 'GATE',
//       title: 'GATE',
//       subtitle: 'Graduate Aptitude Test',
//       difficulty: 'High',
//     ),
//   ]);

//   final GetStorage _box = GetStorage();
//   var isLoggingOut = false.obs;

//   // Actions
//   void openActivityDetails(ActivityItem item) {
//     // placeholder - route or modal
//     Get.snackbar(
//       'Activity',
//       item.title,
//       snackPosition: SnackPosition.BOTTOM,
//       duration: const Duration(milliseconds: 900),
//     );
//   }

//   void openStandard(StandardItem item) {
//     Get.snackbar('Standard', item.title, snackPosition: SnackPosition.BOTTOM);
//     Get.toNamed('/subject-selection');
//   }

//   void openExam(ExamItem exam) {
//     Get.snackbar('Exam', exam.title, snackPosition: SnackPosition.BOTTOM);
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   /// Call backend logout API, clear session storage and navigate to login.
//   Future<void> logout() async {
//     if (isLoggingOut.value) return;
//     isLoggingOut.value = true;

//     final storedUserId = _box.read('user_id') as String?;
//     try {
//       // Optional: show quick snackbar while working
//       Get.snackbar(
//         'Logging out',
//         'Signing you out...',
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       final uri = Uri.parse(ApiConfig.logout); // ensure ApiConfig.logout exists
//       final body = jsonEncode({
//         if (storedUserId != null) 'user_id': storedUserId,
//         // include other params if your backend requires (e.g. auth_token)
//       });

//       final response = await http.post(
//         uri,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },

//         body: body,
//       );

//       if (response.statusCode == 200) {
//         // success: clear session and navigate
//         await _box.remove('user_id');
//         // remove other stored keys you might have used
//         // await _box.remove('auth_token');

//         Get.snackbar(
//           'Logged out',
//           'You have been signed out.',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.shade50,
//           colorText: Colors.green.shade800,
//         );

//         // navigate to login and remove all routes
//         Future.delayed(const Duration(milliseconds: 300), () {
//           Get.offAllNamed('/login');
//         });
//       } else {
//         // try to parse error message
//         String message = 'Logout failed';
//         try {
//           final payload = jsonDecode(response.body) as Map<String, dynamic>?;
//           message = payload?['message'] as String? ?? message;
//         } catch (_) {}

//         Get.snackbar(
//           'Logout Error',
//           message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.orange.shade50,
//           colorText: Colors.orange.shade800,
//         );

//         // still clear local session in case server is not reachable / to force sign out:
//         // await _box.remove('user_id');
//         // Get.offAllNamed('/login');
//       }
//     } catch (e, st) {
//       debugPrint("Logout error: $e\n$st");
//       Get.snackbar(
//         'Network Error',
//         'Unable to logout. Clearing local session.',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.shade50,
//         colorText: Colors.red.shade800,
//       );

//       // fallback: clear local session
//       await _box.remove('user_id');
//       Future.delayed(const Duration(milliseconds: 300), () {
//         Get.offAllNamed('/login');
//       });
//     } finally {
//       isLoggingOut.value = false;
//     }
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../utils/api_endpoints.dart'; // adjust path if needed
import '../../../utils/auth_token_service.dart';

/// Small DTOs used by the controller
class ActivityItem {
  final String title;
  final String meta;
  final String timeAgo;
  final Color color;
  final String status;
  ActivityItem({
    required this.title,
    required this.meta,
    required this.timeAgo,
    required this.color,
    required this.status,
  });
}

// models/standard_item.dart
// models/standard_item.dart
class StandardItem {
  final String title;
  final String subtitle;
  final String secondSubtitle;
  final int badge;
  final String progress;
  final String streamText;
  final IconData streamIcon; // Required – no null allowed

  StandardItem({
    required this.title,
    required this.subtitle,
    required this.secondSubtitle,
    required this.badge,
    required this.progress,
    required this.streamText,
    required this.streamIcon,
  });
}

// models/exam_item.dart
class ExamItem {
  final String code;
  final String title;
  final String subtitle;
  final String subjectsIcon;     // Short: "PCM", "PCB", "Multiple"
  final String subjects;         // Full: "Physics, Chemistry, Mathematics"
  final String duration;         // "2 Years", "1 Year"
  final String accessType;       // "Premium" or "Available"
  final String difficulty;       // "High", "Medium"

  ExamItem({
    required this.code,
    required this.title,
    required this.subtitle,
    required this.subjectsIcon,
    required this.subjects,
    required this.duration,
    required this.accessType,
    required this.difficulty,
  });
}

class DashboardController extends GetxController {
  // Header (welcome text)
  final welcome = 'Welcome back, John!'.obs;
  final appTitle = 'YB Nexus'.obs;

  // Progress placeholder - in a real app this can be detailed model
  final hasProgress = false.obs;
  final progressPercent = 0.0.obs;

  // Auth service (centralized token handling)
  final AuthTokenService authService = Get.find<AuthTokenService>();

  // Recent Activity
  final recentActivity = RxList<ActivityItem>([
    ActivityItem(
      title: 'Mathematics Mock Test',
      meta: 'Scored 85% in Algebra & Geometry test',
      timeAgo: '2 hours ago',
      color: Colors.blue,
      status: 'Completed',
    ),
    ActivityItem(
      title: 'AI Chat Session',
      meta: 'Discussed derivatives and limits concepts',
      timeAgo: 'Yesterday',
      color: Colors.green,
      status: 'Discussion',
    ),
    ActivityItem(
      title: 'Uploaded Study Material',
      meta: 'Added Physics Chapter 5: Light & Reflection',
      timeAgo: '3 days ago',
      color: Colors.orange,
      status: 'Uploaded',
    ),
    ActivityItem(
      title: 'Practice Quiz Attempt',
      meta: 'Attempted Chemistry quick quiz - Need improvement',
      timeAgo: '5 days ago',
      color: Colors.red,
      status: 'Needs Work',
    ),
  ]);



// In your DashboardController
final standards = RxList<StandardItem>([
  // Class 9th - New!
  StandardItem(
    title: 'Class 09th',
    subtitle: 'CBSE Board Preparation',
    secondSubtitle: 'Foundation for higher studies',
    badge: 9,
    progress: 'In Progress',
    streamText: '6 Subjects',
    streamIcon: Icons.menu_book,
  ),

  // Class 10th
  StandardItem(
    title: 'Class 10th',
    subtitle: 'CBSE Board Preparation',
    secondSubtitle: 'Foundation for higher studies',
    badge: 10,
    progress: 'In Progress',
    streamText: '6 Subjects',
    streamIcon: Icons.menu_book,
  ),

  // Class 11th Science
  StandardItem(
    title: 'Class 11th Science',
    subtitle: 'PCM/PCB Stream',
    secondSubtitle: 'JEE/NEET foundation preparation',
    badge: 11,
    progress: 'Locked',
    streamText: 'PCM/PCB',
    streamIcon: Icons.science,
  ),

  // Class 12th Science
  StandardItem(
    title: 'Class 12th Science',
    subtitle: 'Board Exams & Entrance Prep',
    secondSubtitle: 'Final year preparation',
    badge: 12,
    progress: 'Locked',
    streamText: 'Advanced',
    streamIcon: Icons.school,
  ),
]);
  // Competitive Exams
 final exams = RxList<ExamItem>([
  ExamItem(
    code: 'JEE',
    title: 'JEE Main & Advanced',
    subtitle: 'Engineering Entrance Preparation',
    subjectsIcon: 'PCM',
    subjects: 'Physics, Chemistry, Mathematics',
    duration: '2 Years',
    accessType: 'Premium',
    difficulty: 'High',
  ),
  ExamItem(
    code: 'NEET',
    title: 'NEET Medical Entrance',
    subtitle: 'Medical & Dental Preparation',
    subjectsIcon: 'PCB',
    subjects: 'Physics, Chemistry, Biology',
    duration: '2 Years',
    accessType: 'Premium',
    difficulty: 'High',
  ),
  ExamItem(
    code: 'UGC',
    title: 'UGC NET',
    subtitle: 'University Grants Commission',
    subjectsIcon: 'Multiple',
    subjects: 'Multiple Subjects',
    duration: 'Flexible',
    accessType: 'Available',
    difficulty: 'Medium',
  ),
  ExamItem(
    code: 'GATE',
    title: 'GATE',
    subtitle: 'Graduate Aptitude Test',
    subjectsIcon: 'Engineering',
    subjects: 'Engineering Subjects',
    duration: '1 Year',
    accessType: 'Premium',
    difficulty: 'High',
  ),
  // Add more if needed
  ExamItem(
    code: 'CLAT',
    title: 'CLAT (Law Entrance)',
    subtitle: 'Law College Admission Test',
    subjectsIcon: 'GK',
    subjects: 'English, GK, Legal Reasoning',
    duration: '1 Year',
    accessType: 'Premium',
    difficulty: 'Medium',
  ),
  ExamItem(
    code: 'CAT',
    title: 'CAT (MBA Entrance)',
    subtitle: 'Management Entrance Test',
    subjectsIcon: 'QA',
    subjects: 'QA, VARC, DILR sections',
    duration: '1 Year',
    accessType: 'Premium',
    difficulty: 'High',
  ),
]);
  // secure storage instance (still used for user_id cleanup)
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  var isLoggingOut = false.obs;

  // Actions
  void openActivityDetails(ActivityItem item) {
    // placeholder - route or modal
    Get.snackbar(
      'Activity',
      item.title,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(milliseconds: 900),
    );
  }

  void openStandard(StandardItem item) {
    Get.snackbar('Standard', item.title, snackPosition: SnackPosition.BOTTOM);
    Get.toNamed('/coresubjects');
  }

  void selectStandard(StandardItem standard) {
    // Handle navigation or logic when a standard is selected
    Get.snackbar(
      "Selected",
      "${standard.title} selected",
      snackPosition: SnackPosition.BOTTOM,
    );

    // Example navigation:
    // Get.to(() => StandardContentView(standard: standard));
  }

  void openExam(ExamItem exam) {
    Get.snackbar('Exam', exam.title, snackPosition: SnackPosition.BOTTOM);
  }

  

  @override
  void onClose() {
    super.onClose();
  }

  /// Example: fetch dashboard data using centralized auth headers
  Future<void> fetchDashboardData() async {
    try {
      final headers = await authService.getAuthHeaders();
      final uri = Uri.parse(
        ApiConfig.baseUrl + '/dashboard-data',
      ); // replace with real endpoint
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        // parse and update observables
        // final payload = jsonDecode(response.body);
        // update controller state accordingly
      } else if (response.statusCode == 401) {
        // optional: handle unauthorized (authService.getValidToken will refresh next time)
        Get.snackbar(
          'Unauthorized',
          'Session expired. Trying to refresh token.',
          snackPosition: SnackPosition.BOTTOM,
        );
        // you could call authService.getValidToken() and retry if desired
      } else {
        debugPrint(
          'Dashboard fetch failed: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e, st) {
      debugPrint('fetchDashboardData error: $e\n$st');
    }
  }

  /// Call backend logout API, clear secure storage and navigate to login.
  /// Uses AuthTokenService for headers and clearing token.
  Future<void> logout() async {
    if (isLoggingOut.value) return;
    isLoggingOut.value = true;

    try {
      // Optional: show quick snackbar while working
      Get.snackbar(
        'Logging out',
        'Signing you out...',
        snackPosition: SnackPosition.BOTTOM,
      );

      // get headers (authService will provide Bearer token if available/valid)
      final headers = await authService.getAuthHeaders();

      // read stored user id for backend payload (if needed)
      final storedUserId = await _secureStorage.read(key: 'user_id');

      final uri = Uri.parse(ApiConfig.logout); // ensure ApiConfig.logout exists
      final body = jsonEncode({
        if (storedUserId != null) 'user_id': storedUserId,
        // add other params if backend requires
      });

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        // success: clear session and navigate
        await authService.clearToken();
        await _secureStorage.delete(key: 'user_id');

        Get.snackbar(
          'Logged out',
          'You have been signed out.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade50,
          colorText: Colors.green.shade800,
        );

        // navigate to login and remove all routes
        Future.delayed(const Duration(milliseconds: 300), () {
          Get.offAllNamed('/login');
        });
      } else {
        // try to parse error message
        String message = 'Logout failed';
        try {
          final payload = jsonDecode(response.body) as Map<String, dynamic>?;
          message = payload?['message'] as String? ?? message;
        } catch (_) {}

        Get.snackbar(
          'Logout Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.shade50,
          colorText: Colors.orange.shade800,
        );

        // optionally still clear local session to force sign out:
        // await authService.clearToken();
        // await _secureStorage.delete(key: 'user_id');
        // Get.offAllNamed('/login');
      }
    } catch (e, st) {
      debugPrint("Logout error: $e\n$st");
      Get.snackbar(
        'Network Error',
        'Unable to logout. Clearing local session.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade800,
      );

      // fallback: clear local session
      await authService.clearToken();
      await _secureStorage.delete(key: 'user_id');
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.offAllNamed('/login');
      });
    } finally {
      isLoggingOut.value = false;
    }
  }
}
