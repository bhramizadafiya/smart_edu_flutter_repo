// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CreatePasswordController extends GetxController {
//   // Text controllers
//   final TextEditingController newPasswordCtrl = TextEditingController();
//   final TextEditingController confirmPasswordCtrl = TextEditingController();

//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   // Visibility toggles
//   final isNewHidden = true.obs;
//   final isConfirmHidden = true.obs;

//   // Password requirement checks
//   final hasMinLength = false.obs; // at least 8 characters
//   final hasUppercase = false.obs; // one uppercase letter
//   final hasNumberOrSymbol = false.obs; // one number or symbol

//   // Submit state
//   final isSubmitting = false.obs;

//   @override
//   void onInit() {
//     super.onInit();

//     // Update checks on each change
//     newPasswordCtrl.addListener(_validatePassword);
//   }

//   String? validatePassword(String? value) {
//     final v = value ?? '';
//     if (v.isEmpty) return 'Password is required';
//     if (v.length < 8) return 'Password must be at least 8 characters';
//     if (!RegExp(r'[A-Z]').hasMatch(v)) {
//       return "Include at least one uppercase letter";
//     }
//     if (!RegExp(r'[\d\W]').hasMatch(v)) {
//       return 'Include at least one number or symbol';
//     }
//     return null;
//   }

//   String? validateConfirmPassword(String? value) {
//     if (value != passwordController.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   void toggleNewVisibility() => isNewHidden.value = !isNewHidden.value;
//   void toggleConfirmVisibility() =>
//       isConfirmHidden.value = !isConfirmHidden.value;

//   void _validatePassword() {
//     final value = newPasswordCtrl.text;
//     hasMinLength.value = value.length >= 8;
//     hasUppercase.value = value.contains(RegExp(r'[A-Z]'));
//     hasNumberOrSymbol.value = value.contains(
//       RegExp(r'[\d\W_]'),
//     ); // digit or non-word char
//   }

//   String? validateConfirm() {
//     if (confirmPasswordCtrl.text.isEmpty) return 'Please confirm password';
//     if (confirmPasswordCtrl.text != newPasswordCtrl.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   Future<void> submit() async {
//     // Basic validations
//     if (!hasMinLength.value ||
//         !hasUppercase.value ||
//         !hasNumberOrSymbol.value) {
//       Get.snackbar(
//         'Invalid password',
//         'Please satisfy all password requirements.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     if (confirmPasswordCtrl.text != newPasswordCtrl.text) {
//       Get.snackbar(
//         'Mismatch',
//         'Confirm password does not match.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     // Simulate submit
//     try {
//       isSubmitting.value = true;
//       await Future.delayed(const Duration(seconds: 2)); // replace with API call

//       // On success navigate to login (or next)
//       Get.offNamed('/login'); // or Get.toNamed('/login-success')
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Something went wrong. Try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isSubmitting.value = false;
//     }
//   }

//   @override
//   void onClose() {
//     newPasswordCtrl.removeListener(_validatePassword);
//     newPasswordCtrl.dispose();
//     confirmPasswordCtrl.dispose();
//     super.onClose();
//   }
// }

// ==============================================================================================
// ==============================================================================================

// lib/modules/createpassword/controller/createpassword_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CreatePasswordController extends GetxController {
//   // Text controllers used by the view
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   // Visibility toggles
//   final isNewHidden = true.obs;
//   final isConfirmHidden = true.obs;

//   // Password requirement checks
//   final hasMinLength = false.obs; // at least 8 characters
//   final hasUppercase = false.obs; // one uppercase letter
//   final hasNumberOrSymbol = false.obs; // one number or symbol

//   // Submit state
//   final isSubmitting = false.obs;

//   final code = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     final args = Get.arguments;
//     if (args != null && args is Map) {
//       code.value = (args['code'] ?? '').toString();
//     }
//     // Listen password field and validate live
//     passwordController.addListener(_validatePassword);
//   }

//   // Toggle helpers used by the view
//   void toggleNewVisibility() => isNewHidden.value = !isNewHidden.value;
//   void toggleConfirmVisibility() =>
//       isConfirmHidden.value = !isConfirmHidden.value;

//   // Live validation for requirement checkboxes
//   void _validatePassword() {
//     final value = passwordController.text;
//     hasMinLength.value = value.length >= 8;
//     hasUppercase.value = value.contains(RegExp(r'[A-Z]'));
//     hasNumberOrSymbol.value = value.contains(
//       RegExp(r'[\d\W_]'),
//     ); // digit or symbol
//   }

//   // Validator for the password field (used by form.fields)
//   String? validatePassword(String? value) {
//     final v = value ?? passwordController.text;
//     if (v.isEmpty) return 'Password is required';
//     if (v.length < 8) return 'Password must be at least 8 characters';
//     if (!RegExp(r'[A-Z]').hasMatch(v)) {
//       return 'Include at least one uppercase letter';
//     }
//     if (!RegExp(r'[\d\W]').hasMatch(v)) {
//       return 'Include at least one number or symbol';
//     }
//     return null;
//   }

//   // Validator for confirm password field
//   String? validateConfirmPassword(String? value) {
//     final confirmValue = value ?? confirmPasswordController.text;
//     if (confirmValue.isEmpty) return 'Please confirm password';
//     if (confirmValue != passwordController.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   // Submit handler
//   Future<void> submit() async {
//     // Basic requirement checks first (these are live so they should be accurate)
//     if (!hasMinLength.value ||
//         !hasUppercase.value ||
//         !hasNumberOrSymbol.value) {
//       Get.snackbar(
//         'Invalid password',
//         'Please satisfy all password requirements.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     if (confirmPasswordController.text != passwordController.text) {
//       Get.snackbar(
//         'Mismatch',
//         'Confirm password does not match.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     try {
//       isSubmitting.value = true;
//       // Replace with real API call
//       await Future.delayed(const Duration(seconds: 2));

//       // On success navigate to login or wherever needed
//       Get.offNamed('/login');
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Something went wrong. Try again.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isSubmitting.value = false;
//     }
//   }

//   @override
//   void onClose() {
//     // cleanup
//     passwordController.removeListener(_validatePassword);
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.onClose();
//   }
// }

// lib/modules/createpassword/controller/createpassword_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api_endpoints.dart';

class CreatePasswordController extends GetxController {
  // Text controllers used by the view
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Visibility toggles
  final isNewHidden = true.obs;
  final isConfirmHidden = true.obs;

  // Password requirement checks
  final hasMinLength = false.obs; // at least 8 characters
  final hasUppercase = false.obs; // one uppercase letter
  final hasNumberOrSymbol = false.obs; // one number or symbol

  // Submit state
  final isSubmitting = false.obs;

  // values passed via navigation arguments
  final code = ''.obs;
  final email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      code.value = (args['code'] ?? args['verification_code'] ?? '').toString();
      email.value = (args['email'] ?? '').toString();
    }
    // Listen password field and validate live
    passwordController.addListener(_validatePassword);
  }

  // Toggle helpers used by the view
  void toggleNewVisibility() => isNewHidden.value = !isNewHidden.value;
  void toggleConfirmVisibility() =>
      isConfirmHidden.value = !isConfirmHidden.value;

  // Live validation for requirement checkboxes
  void _validatePassword() {
    final value = passwordController.text;
    hasMinLength.value = value.length >= 8;
    hasUppercase.value = value.contains(RegExp(r'[A-Z]'));
    hasNumberOrSymbol.value = value.contains(
      RegExp(r'[\d\W_]'),
    ); // digit or symbol
  }

  // Validator for the password field (used by form.fields)
  String? validatePassword(String? value) {
    final v = value ?? passwordController.text;
    if (v.isEmpty) return 'Password is required';
    if (v.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(v)) {
      return 'Include at least one uppercase letter';
    }
    if (!RegExp(r'[\d\W]').hasMatch(v)) {
      return 'Include at least one number or symbol';
    }
    return null;
  }

  // Validator for confirm password field
  String? validateConfirmPassword(String? value) {
    final confirmValue = value ?? confirmPasswordController.text;
    if (confirmValue.isEmpty) return 'Please confirm password';
    if (confirmValue != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Call backend reset-password API
  Future<void> submit() async {
    // Basic requirement checks first (these are live so they should be accurate)
    if (!hasMinLength.value ||
        !hasUppercase.value ||
        !hasNumberOrSymbol.value) {
      Get.snackbar(
        'Invalid password',
        'Please satisfy all password requirements.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (confirmPasswordController.text != passwordController.text) {
      Get.snackbar(
        'Mismatch',
        'Confirm password does not match.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final newPassword = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final verificationCode = code.value.trim();
    final userEmail = email.value.trim();

    debugPrint(
      'Submitting reset password for $userEmail with code $verificationCode',
    );

    if (userEmail.isEmpty) {
      Get.snackbar(
        'Missing email',
        'Email is required to reset the password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (verificationCode.isEmpty) {
      Get.snackbar(
        'Missing code',
        'Verification code is required. Please request a reset code again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isSubmitting.value = true;

      final uri = Uri.parse(ApiConfig.resetPassword);
      final body = jsonEncode({
        'email': userEmail,
        'code': verificationCode,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      });

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      Map<String, dynamic>? payload;
      try {
        payload = jsonDecode(response.body) as Map<String, dynamic>?;
      } catch (_) {
        payload = null;
      }

      if (response.statusCode == 200) {
        final message =
            payload?['message'] as String? ?? 'Password reset successfully.';
        Get.snackbar(
          'Success',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade50,
          colorText: Colors.green.shade800,
        );

        // navigate to login after a short delay
        Future.delayed(const Duration(milliseconds: 600), () {
          Get.offNamed('/login');
        });
      } else {
        // handle known failure cases
        final error = payload?['error'] as String?;
        final message =
            payload?['message'] as String? ?? 'Failed to reset password';

        if (response.statusCode == 400 && error == 'CodeNotFound') {
          Get.snackbar(
            'Code Not Found',
            message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange.shade50,
            colorText: Colors.orange.shade800,
          );
        } else {
          Get.snackbar(
            'Error',
            message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade50,
            colorText: Colors.red.shade800,
          );
        }
      }
    } catch (e, st) {
      debugPrint('Reset password error: $e\n$st');
      Get.snackbar(
        'Network Error',
        'Unable to contact server. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    // cleanup
    passwordController.removeListener(_validatePassword);
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
