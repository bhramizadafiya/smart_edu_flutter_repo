// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ForgotPasswordController extends GetxController {
//   final formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();

//   final isSending = false.obs;

//   /// Validate and simulate sending reset code
//   Future<void> sendResetCode() async {
//     final form = formKey.currentState;
//     if (form == null) return;

//     if (!form.validate()) {
//       return;
//     }

//     try {
//       isSending.value = true;

//       // Simulate API call delay
//       await Future.delayed(const Duration(seconds: 2));

//       // On success — show a snackbar and (optionally) navigate to verification screen
//       Get.snackbar(
//         'Reset Code Sent',
//         'We have sent a reset code to ${emailController.text.trim()}',
//         snackPosition: SnackPosition.BOTTOM,
//         margin: const EdgeInsets.all(12),
//       );

//       Get.toNamed(
//         '/email-verification',
//         arguments: {
//           'mode': 'forgot',
//           'email': 'john.doe@email.com',
//           'title': 'Reset Password',
//           'buttonText': 'Continue',
//           'nextRoute': '/create-password',
//         },
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to send reset code. Try again.',
//         snackPosition: SnackPosition.BOTTOM,
//         margin: const EdgeInsets.all(12),
//       );
//     } finally {
//       isSending.value = false;
//     }
//   }

//   String? validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your email address';
//     }
//     final email = value.trim();
//     final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
//     if (!emailRegex.hasMatch(email)) {
//       return 'Please enter a valid email address';
//     }
//     return null;
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//     super.onClose();
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api_endpoints.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final isSending = false.obs;

  /// Call backend forgot-password API and navigate to email verification on success.
  Future<void> sendResetCode() async {
    final form = formKey.currentState;
    if (form == null) return;

    if (!form.validate()) return;

    final email = emailController.text.trim();
    if (email.isEmpty) return;

    isSending.value = true;
    try {
      final uri = Uri.parse(ApiConfig.forgotPassword);
      final body = jsonEncode({'email': email});

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // Try to parse response safely
      Map<String, dynamic>? payload;
      try {
        payload = jsonDecode(response.body) as Map<String, dynamic>?;
      } catch (_) {
        payload = null;
      }

      if (response.statusCode == 200) {
        // expected success
        final message = payload?['message'] as String? ?? 'Reset code sent';
        Get.snackbar(
          'Reset Code Sent',
          message,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(12),
        );

        // Navigate to email verification and pass the actual email and mode
        Get.toNamed(
          '/email-verification',
          arguments: {
            'mode': 'forgot',
            'email': email,
            'title': 'Reset Password',
            'buttonText': 'Continue',
            'nextRoute': '/create-password',
          },
        );
      } else {
        // Handle common failure cases
        final message =
            payload?['message'] as String? ?? 'Failed to send reset code';

        switch (response.statusCode) {
          case 404:
            Get.snackbar(
              'User Not Found',
              message,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(12),
              backgroundColor: Colors.orange.shade50,
              colorText: Colors.orange.shade800,
            );
            break;
          case 403:
            // maybe email not verified or other condition
            Get.snackbar(
              'Not Allowed',
              message,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(12),
              backgroundColor: Colors.orange.shade50,
              colorText: Colors.orange.shade800,
            );
            break;
          case 422:
          case 400:
            Get.snackbar(
              'Invalid Request',
              message,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(12),
              backgroundColor: Colors.orange.shade50,
              colorText: Colors.orange.shade800,
            );
            break;
          default:
            Get.snackbar(
              'Error',
              message,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(12),
              backgroundColor: Colors.red.shade50,
              colorText: Colors.red.shade800,
            );
        }
      }
    } catch (e, st) {
      debugPrint('Forgot password error: $e\n$st');
      Get.snackbar(
        'Network Error',
        'Unable to contact server. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );
    } finally {
      isSending.value = false;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    final email = value.trim();
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
