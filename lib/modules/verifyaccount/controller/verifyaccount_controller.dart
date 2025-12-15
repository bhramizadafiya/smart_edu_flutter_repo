import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyAccountController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final isSending = false.obs;

  /// Validate and simulate sending reset code
  Future<void> sendResetCode() async {
    final form = formKey.currentState;
    if (form == null) return;

    if (!form.validate()) {
      return;
    }

    try {
      isSending.value = true;

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // On success — show a snackbar and (optionally) navigate to verification screen
      Get.snackbar(
        'Reset Code Sent',
        'We have sent a reset code to ${emailController.text.trim()}',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
      );

      Get.toNamed(
        '/email-verification',
        arguments: {
          'mode': 'verify',
          'email': 'john.doe@email.com',
          'title': 'Verify Your Account',
          'buttonText': 'Continue',
          'nextRoute': '/login',
        },
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send reset code. Try again.',
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
