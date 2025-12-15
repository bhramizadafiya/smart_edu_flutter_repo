// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class EmailVerificationController extends GetxController {
//   final email = "john.doe@email.com".obs;
//   final otpControllers = List.generate(6, (_) => TextEditingController());
//   final remainingTime = (5 * 60).obs; // 5 minutes in seconds
//   Timer? timer;

//   @override
//   void onInit() {
//     super.onInit();
//     startTimer();
//   }

//   void startTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       if (remainingTime.value > 0) {
//         remainingTime.value--;
//       } else {
//         t.cancel();
//       }
//     });
//   }

//   void resendCode() {
//     remainingTime.value = 5 * 60;
//     startTimer();
//     Get.snackbar(
//       "Verification",
//       "New verification code sent to your email.",
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   void verifyCode() {
//     Get.toNamed('/login');

//     // final otp = otpControllers.map((c) => c.text).join();
//     // if (otp.length == 6) {
//     //   Get.snackbar(
//     //     "Success",
//     //     "Account verified successfully!",
//     //     snackPosition: SnackPosition.BOTTOM,
//     //   );
//     //   // Navigate to next page here
//     // } else {
//     //   Get.snackbar(
//     //     "Error",
//     //     "Please enter all 6 digits",
//     //     snackPosition: SnackPosition.BOTTOM,
//     //   );
//     // }
//   }

//   @override
//   void onClose() {
//     timer?.cancel();
//     for (var c in otpControllers) {
//       c.dispose();
//     }
//     super.onClose();
//   }
// }

// ############################################################

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class EmailVerificationController extends GetxController {
//   // Reactive configuration (set from Get.arguments in onInit)
//   final email = ''.obs;
//   final title = 'Verify'.obs;
//   final subtitle = "We've sent a 6-digit verification code to your email".obs;
//   final buttonText = 'Verify Account'.obs;
//   final nextRoute = ''.obs;
//   final mode = 'signup'.obs; // 'signup' or 'forgot' (custom)

//   // OTP controllers for 6 boxes
//   final otpControllers = List.generate(6, (_) => TextEditingController());

//   // Timer
//   final remainingTime = (5 * 60).obs; // default 5 minutes
//   Timer? _timer;

//   @override
//   void onInit() {
//     super.onInit();

//     // Read arguments passed via Get.toNamed(..., arguments: {...})
//     final args = Get.arguments;
//     if (args != null && args is Map) {
//       email.value = (args['email'] ?? email.value).toString();
//       title.value = (args['title'] ?? title.value).toString();
//       subtitle.value = (args['subtitle'] ?? subtitle.value).toString();
//       buttonText.value = (args['buttonText'] ?? buttonText.value).toString();
//       nextRoute.value = (args['nextRoute'] ?? '').toString();
//       mode.value = (args['mode'] ?? mode.value).toString();
//       final int? minutes = args['timerMinutes'] is int
//           ? args['timerMinutes'] as int
//           : null;
//       if (minutes != null && minutes > 0) {
//         remainingTime.value = minutes * 60;
//       }
//     }

//     // start countdown
//     _startTimer();
//   }

//   void _startTimer() {
//     // cancel previous timer (if any)
//     _timer?.cancel();
//     // ensure non-negative
//     if (remainingTime.value <= 0) remainingTime.value = 5 * 60;

//     _timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       if (remainingTime.value > 0) {
//         remainingTime.value--;
//       } else {
//         t.cancel();
//       }
//     });
//   }

//   /// Reset OTP inputs (useful on resend)
//   void _clearOtp() {
//     for (var c in otpControllers) {
//       c.text = '';
//     }
//     // focus first field — UI should handle focusing when needed
//   }

//   /// Called when user taps "Resend via Email"
//   void resendCode() {
//     // Cancel and restart countdown
//     remainingTime.value = 5 * 60;
//     _startTimer();

//     // Clear OTP fields
//     _clearOtp();

//     // TODO: call your API to re-send code
//     Get.snackbar(
//       'Verification',
//       'New verification code sent to ${email.value}',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }

//   /// Called when user taps primary button
//   void verifyCode() {
//     final otp = otpControllers.map((c) => c.text.trim()).join();
//     if (otp.length < 6) {
//       Get.snackbar(
//         'Error',
//         'Please enter all 6 digits',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     // TODO: call verification API with otp & email
//     // Simulate success and navigate based on mode/nextRoute
//     if (nextRoute.value.isNotEmpty) {
//       Get.offNamed(nextRoute.value);
//     } else {
//       // default behavior
//       if (mode.value.toLowerCase() == 'forgot') {
//         // go to create password
//         Get.offNamed('/create-password');
//       } else {
//         // signup -> go to login
//         Get.offNamed('/login');
//       }
//     }
//   }

//   /// Optionally allow filling OTP programmatically (e.g., from SMS read)
//   void setOtpAt(int index, String value) {
//     if (index >= 0 && index < otpControllers.length) {
//       otpControllers[index].text = value;
//     }
//   }

//   @override
//   void onClose() {
//     _timer?.cancel();
//     for (var c in otpControllers) {
//       c.dispose();
//     }
//     super.onClose();
//   }
// }

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../../utils/api_endpoints.dart';

// class EmailVerificationController extends GetxController {
//   // Reactive configuration (set from Get.arguments in onInit)
//   final email = ''.obs;
//   final title = 'Verify'.obs;
//   final subtitle = "We've sent a 6-digit verification code to your email".obs;
//   final buttonText = 'Verify Account'.obs;
//   final nextRoute = ''.obs;
//   final mode = 'signup'.obs; // 'signup' or 'forgot' (custom)

//   // OTP controllers for 6 boxes
//   final otpControllers = List.generate(6, (_) => TextEditingController());

//   // Timer
//   final remainingTime = (5 * 60).obs; // default 5 minutes
//   Timer? _timer;

//   @override
//   void onInit() {
//     super.onInit();

//     // Read arguments passed via Get.toNamed(..., arguments: {...})
//     final args = Get.arguments;
//     if (args != null && args is Map) {
//       email.value = (args['email'] ?? email.value).toString();
//       title.value = (args['title'] ?? title.value).toString();
//       subtitle.value = (args['subtitle'] ?? subtitle.value).toString();
//       buttonText.value = (args['buttonText'] ?? buttonText.value).toString();
//       nextRoute.value = (args['nextRoute'] ?? '').toString();
//       mode.value = (args['mode'] ?? mode.value).toString();
//       final int? minutes = args['timerMinutes'] is int
//           ? args['timerMinutes'] as int
//           : null;
//       if (minutes != null && minutes > 0) {
//         remainingTime.value = minutes * 60;
//       }
//     }

//     // start countdown
//     _startTimer();
//   }

//   void _startTimer() {
//     // cancel previous timer (if any)
//     _timer?.cancel();
//     // ensure non-negative
//     if (remainingTime.value <= 0) remainingTime.value = 5 * 60;

//     _timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       if (remainingTime.value > 0) {
//         remainingTime.value--;
//       } else {
//         t.cancel();
//       }
//     });
//   }

//   /// Reset OTP inputs (useful on resend)
//   void _clearOtp() {
//     for (var c in otpControllers) {
//       c.text = '';
//     }
//     // UI can set focus to first field if desired
//   }

//   /// Called when user taps "Resend via Email"
//   Future<void> resendCode() async {
//     // Only allow resend when timer reached 0 (UI should disable earlier)
//     if (remainingTime.value > 0) return;

//     // Clear OTP fields and restart timer
//     _clearOtp();
//     remainingTime.value = 5 * 60;
//     _startTimer();

//     // Show loading
//     Get.dialog(
//       const Center(child: CircularProgressIndicator()),
//       barrierDismissible: false,
//     );

//     try {
//       final uri = Uri.parse(ApiConfig.resendVerification);
//       final response = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email.value}),
//       );

//       if (Get.isDialogOpen ?? false) Get.back();

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final resJson = response.body.isNotEmpty
//             ? jsonDecode(response.body)
//             : null;
//         final msg = resJson?['message'] ?? 'Verification code sent';
//         Get.snackbar('Verification', msg, snackPosition: SnackPosition.BOTTOM);
//       } else {
//         final resJson = response.body.isNotEmpty
//             ? jsonDecode(response.body)
//             : null;
//         final msg = resJson?['message'] ?? 'Failed to resend code';
//         Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       if (Get.isDialogOpen ?? false) Get.back();
//       Get.snackbar(
//         'Error',
//         'Unable to resend code: $e',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   /// Called when user taps primary button to verify OTP
//   Future<void> verifyCode() async {
//     final otp = otpControllers.map((c) => c.text.trim()).join();
//     if (otp.length < 6) {
//       Get.snackbar(
//         'Error',
//         'Please enter all 6 digits',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }

//     // show loading
//     Get.dialog(
//       const Center(child: CircularProgressIndicator()),
//       barrierDismissible: false,
//     );

//     try {
//       final uri = Uri.parse(ApiConfig.verifyEmail);
//       final response = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email.value, 'code': otp}),
//       );

//       if (Get.isDialogOpen ?? false) Get.back();

//       if (response.statusCode == 200) {
//         final resJson = response.body.isNotEmpty
//             ? jsonDecode(response.body)
//             : null;
//         final status = resJson?['status'] ?? '';
//         if (status == 'success') {
//           Get.snackbar(
//             'Success',
//             resJson?['message'] ?? 'Email verified',
//             snackPosition: SnackPosition.BOTTOM,
//           );

//           // Navigate according to provided nextRoute or default flows
//           if (nextRoute.value.isNotEmpty) {
//             // replace current stack with next route
//             Get.offNamed(nextRoute.value);
//           } else {
//             if (mode.value.toLowerCase() == 'forgot') {
//               Get.offNamed('/create-password');
//             } else {
//               Get.offNamed('/login');
//             }
//           }
//           return;
//         } else {
//           final msg = resJson?['message'] ?? 'Verification failed';
//           Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
//           return;
//         }
//       } else {
//         final resJson = response.body.isNotEmpty
//             ? jsonDecode(response.body)
//             : null;
//         final msg = resJson?['message'] ?? 'Verification failed';
//         Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
//         return;
//       }
//     } catch (e) {
//       if (Get.isDialogOpen ?? false) Get.back();
//       Get.snackbar(
//         'Error',
//         'Something went wrong: $e',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   /// Optionally allow filling OTP programmatically (e.g., from SMS read)
//   void setOtpAt(int index, String value) {
//     if (index >= 0 && index < otpControllers.length) {
//       otpControllers[index].text = value;
//     }
//   }

//   @override
//   void onClose() {
//     _timer?.cancel();
//     for (var c in otpControllers) {
//       c.dispose();
//     }
//     super.onClose();
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api_endpoints.dart';

class EmailVerificationController extends GetxController {
  // Reactive configuration (set from Get.arguments)
  final email = ''.obs;
  final title = 'Verify'.obs;
  final subtitle = "We've sent a 6-digit verification code to your email".obs;
  final buttonText = 'Verify Account'.obs;
  final nextRoute = ''.obs;
  final mode = 'signup'.obs; // signup or forgot

  // OTP controllers for 6 boxes
  final otpControllers = List.generate(6, (_) => TextEditingController());

  // Timer
  final remainingTime = (5 * 60).obs; // 5 minutes in seconds
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args is Map) {
      email.value = (args['email'] ?? '').toString();
      title.value = (args['title'] ?? 'Verify Account').toString();
      subtitle.value =
          (args['subtitle'] ?? "We've sent a 6-digit code to your email")
              .toString();
      buttonText.value = (args['buttonText'] ?? 'Verify Account').toString();
      nextRoute.value = (args['nextRoute'] ?? '/login').toString();
      mode.value = (args['mode'] ?? 'signup').toString();
    }

    _startTimer();
  }

  // Timer countdown
  void _startTimer() {
    _timer?.cancel();
    if (remainingTime.value <= 0) remainingTime.value = 5 * 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        t.cancel();
      }
    });
  }

  // Clear OTP fields
  void _clearOtp() {
    for (var c in otpControllers) {
      c.text = '';
    }
  }

  // 🔁 RESEND CODE API CALL
  Future<void> resendCode() async {
    if (remainingTime.value > 0) return; // disable until timer expires

    _clearOtp();
    remainingTime.value = 5 * 60;
    _startTimer();

    // Show loading indicator
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final uri = Uri.parse(ApiConfig.resendVerification);
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email.value}),
      );

      if (Get.isDialogOpen ?? false) Get.back();

      final data = response.body.isNotEmpty ? jsonDecode(response.body) : {};
      final message = data['message'] ?? 'Failed to resend code.';

      if (response.statusCode == 200 && data['status'] == 'success') {
        Get.snackbar(
          'Verification',
          message,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade50,
        );
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      Get.snackbar(
        'Error',
        'Unable to resend code: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ✅ VERIFY EMAIL API CALL
  Future<void> verifyCode() async {
    final otp = otpControllers.map((c) => c.text.trim()).join();

    if (otp.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter all 6 digits',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Show loading
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final uri = Uri.parse(ApiConfig.verifyEmail);
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email.value, "code": otp}),
      );

      if (Get.isDialogOpen ?? false) Get.back();

      final resJson = response.body.isNotEmpty ? jsonDecode(response.body) : {};

      if (response.statusCode == 200 && resJson['status'] == 'success') {
        Get.snackbar(
          'Success',
          resJson['message'] ?? 'Email verified successfully.',
          snackPosition: SnackPosition.BOTTOM,
        );

        // inside verifyCode() after successful verification:
        if (nextRoute.value.isNotEmpty) {
          // if the destination needs the email/code, pass them
          if (nextRoute.value == '/create-password' ||
              mode.value.toLowerCase() == 'forgot') {
            Get.offNamed(
              nextRoute.value,
              arguments: {'email': email.value, 'code': otp},
            );
          } else {
            Get.offNamed(nextRoute.value);
          }
        } else {
          if (mode.value.toLowerCase() == 'forgot') {
            Get.toNamed(
              '/create-password',
              arguments: {'email': email.value, 'code': otp},
            );
          } else {
            Get.offNamed('/login');
          }
        }

        // Navigate to next route
        /*if (nextRoute.value.isNotEmpty) {
          Get.offNamed(nextRoute.value);
        } else {
          if (mode.value.toLowerCase() == 'forgot') {
            Get.toNamed(
              '/create-password',
              arguments: {'email': email.value, 'code': otp},
            );
          } else {
            Get.offNamed('/login');
          }
        } */
      } else {
        Get.snackbar(
          'Error',
          resJson['message'] ?? 'Verification failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade50,
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

  void setOtpAt(int index, String value) {
    if (index >= 0 && index < otpControllers.length) {
      otpControllers[index].text = value;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var c in otpControllers) {
      c.dispose();
    }
    super.onClose();
  }
}
