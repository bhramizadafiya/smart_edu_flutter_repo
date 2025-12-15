// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CreateAccountController extends GetxController {
//   final formKey = GlobalKey<FormState>();

//   final fullNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final instituteController = TextEditingController();

//   var isPasswordHidden = true.obs;
//   var isConfirmPasswordHidden = true.obs;
//   var isTermsAccepted = false.obs;
//   var emailError = ''.obs;

//   void togglePasswordVisibility() {
//     isPasswordHidden.value = !isPasswordHidden.value;
//   }

//   void toggleConfirmPasswordVisibility() {
//     isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
//   }

//   String? validateName(String? value) =>
//       value == null || value.trim().isEmpty ? 'Please enter your name' : null;

//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter email';
//     const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$';
//     if (!RegExp(pattern).hasMatch(value)) {
//       emailError.value = "Please enter a valid email address";
//       return '';
//     }
//     emailError.value = '';
//     return null;
//   }

//   String? validatePassword(String? value) {
//     if (value == null || value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   String? validateConfirmPassword(String? value) {
//     if (value != passwordController.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   String? validateInstitute(String? value) =>
//       value == null || value.trim().isEmpty
//       ? 'Please enter your institute name'
//       : null;

//   void sendCode() {
//     // if (!isTermsAccepted.value) {
//     //   Get.snackbar(
//     //     'Error',
//     //     'Please accept the Terms & Privacy Policy',
//     //     backgroundColor: Colors.redAccent,
//     //     colorText: Colors.white,
//     //   );
//     //   return;
//     // }

//     // if (formKey.currentState!.validate()) {
//     //   Get.snackbar(
//     //     'Success',
//     //     'Verification code sent!',
//     //     backgroundColor: Colors.green,
//     //     colorText: Colors.white,
//     //   );
//     // }

//     Get.toNamed(
//       '/email-verification',
//       arguments: {
//         'mode': 'signup',
//         'email': 'john.doe@email.com',
//         'title': 'Verify Your Account',
//         'buttonText': 'Verify Account',
//         'nextRoute': '/login',
//       },
//     );
//   }

//   @override
//   void onClose() {
//     fullNameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     instituteController.dispose();
//     super.onClose();
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api_endpoints.dart';

class CreateAccountController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final designationController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final instituteController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  var isTermsAccepted = false.obs;

  // Field-specific error messages
  var nameError = ''.obs;
  var designationError = ''.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var confirmPasswordError = ''.obs;
  var instituteError = ''.obs;
  var termsError = ''.obs;

  // Role passed from previous screen (default Student)
  String selectedRole = 'Student';

  void togglePasswordVisibility() =>
      isPasswordHidden.value = !isPasswordHidden.value;

  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;

  @override
  void onInit() {
    super.onInit();
    // read role from arguments (if provided)
    final args = Get.arguments;
    if (args is Map && args['role'] != null) {
      selectedRole = args['role'].toString();
    }
  }

  // Validation logic for each field
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      nameError.value = 'Please enter your name';
      return '';
    }
    nameError.value = '';
    return null;
  }

  // Validation logic for each field
  String? validateDesignation(String? value) {
    if (value == null || value.trim().isEmpty) {
      designationError.value = 'Please enter your designation';
      return '';
    }
    designationError.value = '';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      emailError.value = 'Please enter email';
      return '';
    }
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$';
    if (!RegExp(pattern).hasMatch(value.trim())) {
      emailError.value = 'Please enter a valid email address';
      return '';
    }
    emailError.value = '';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      passwordError.value = 'Please enter password';
      return '';
    }
    if (value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      return '';
    }
    passwordError.value = '';
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      return '';
    }
    if (value != passwordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
      return '';
    }
    confirmPasswordError.value = '';
    return null;
  }

  String? validateInstitute(String? value) {
    if (value == null || value.trim().isEmpty) {
      instituteError.value = 'Please enter your institute name';
      return '';
    }
    instituteError.value = '';
    return null;
  }

  Future<void> sendCode() async {
    // Reset and validate all field errors
    termsError.value = '';
    nameError.value = '';
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    instituteError.value = '';
    designationError.value = '';

    final formState = formKey.currentState;
    if (formState == null) return;

    formState.validate();

    if (!isTermsAccepted.value) {
      termsError.value = 'Please accept the Terms & Privacy Policy';
    }

    if ([
      nameError.value,
      emailError.value,
      passwordError.value,
      confirmPasswordError.value,
      instituteError.value,
      termsError.value,
      designationError.value,
    ].any((e) => e.isNotEmpty)) {
      return;
    }

    final body = {
      "full_name": fullNameController.text.trim(),
      "email": emailController.text.trim(),
      "organization_name": instituteController.text.trim(),
      "designation": designationController.text.trim(),
      "password": passwordController.text,
      "role": selectedRole,
      "accept_terms": true,
    };

    // Loading indicator
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // Use centralized endpoint
      final uri = Uri.parse(ApiConfig.register);
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (Get.isDialogOpen ?? false) Get.back();

      final resJson = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : null;

      if (response.statusCode == 201 && resJson['status'] == 'success') {
        Get.snackbar(
          'Success',
          resJson['message'] ?? 'Verification code sent',
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.toNamed(
          '/email-verification',
          arguments: {
            'mode': 'signup',
            'email': emailController.text.trim(),
            'title': 'Verify Your Account',
            'buttonText': 'Verify Account',
            'nextRoute': '/login',
          },
        );
      } else {
        final msg = resJson?['message'] ?? 'Registration failed';
        if (resJson?['statuscode'] == 409 ||
            resJson?['error'] == 'DuplicateEmail') {
          emailError.value = msg;
        }
        Get.snackbar(
          'Registration Failed',
          msg,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // void sendCode() {
  //   termsError.value = '';

  //   final formState = formKey.currentState;
  //   if (formState == null) return;

  //   formState.validate(); // trigger all field validators

  //   if (!isTermsAccepted.value) {
  //     termsError.value = 'Please accept the Terms & Privacy Policy';
  //   } else {
  //     termsError.value = '';
  //   }

  //   // Check if any field has error
  //   if ([
  //     nameError.value,
  //     emailError.value,
  //     passwordError.value,
  //     confirmPasswordError.value,
  //     instituteError.value,
  //     termsError.value,
  //   ].any((e) => e.isNotEmpty)) {
  //     return; // stop if any error exists
  //   }

  //   // ✅ Everything is perfect — proceed
  //   final email = emailController.text.trim();

  //   Get.toNamed(
  //     '/email-verification',
  //     arguments: {
  //       'mode': 'signup',
  //       'email': email,
  //       'title': 'Verify Your Account',
  //       'buttonText': 'Verify Account',
  //       'nextRoute': '/login',
  //     },
  //   );
  // }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    instituteController.dispose();
    super.onClose();
  }
}
