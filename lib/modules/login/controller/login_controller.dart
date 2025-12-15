// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class LoginController extends GetxController {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   var isPasswordVisible = false.obs;
//   var emailError = ''.obs;

//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   void signIn() {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       Get.snackbar(
//         "Error",
//         "Please enter both email and password",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.shade50,
//         colorText: Colors.red.shade800,
//       );
//       return;
//     }

//     if (email == 'yash@gmail.com' && password == 'yash') {
//       Get.snackbar(
//         "Success",
//         "Signed in successfully",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green.shade50,
//         colorText: Colors.green.shade800,
//       );

//       // Navigate to dashboard page
//       Future.delayed(const Duration(milliseconds: 800), () {
//         Get.offNamed('/dashboard');
//       });
//     } else {
//       Get.snackbar(
//         "Invalid Credentials",
//         "Incorrect email or password",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange.shade50,
//         colorText: Colors.orange.shade800,
//       );
//     }
//   }

//   void forgotPassword() {
//     Get.toNamed('/forgot-password');
//     // Get.snackbar(
//     //   "Forgot Password",
//     //   "Navigate to reset password screen",
//     //   snackPosition: SnackPosition.BOTTOM,
//     // );
//   }

//   void verifyAccount() {
//     Get.snackbar(
//       "Verify Account",
//       "Navigate to verify account screen",
//       snackPosition: SnackPosition.BOTTOM,
//     );

//     Get.toNamed('/verify-account');
//   }

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

//   void createAccount() {
//     Get.toNamed('/role-selection');
//   }
// }

// ========================================================================================================
// ========================================================================================================
// ========================================================================================================

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../../utils/api_endpoints.dart';

// class LoginController extends GetxController {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   var isPasswordVisible = false.obs;
//   var isLoading = false.obs;
//   var emailError = ''.obs;

//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   Future<void> signIn() async {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();

//     // client-side validation
//     final emailValidation = validateEmail(email);
//     if (emailValidation != null) {
//       Get.snackbar(
//         "Invalid Email",
//         emailValidation,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange.shade50,
//         colorText: Colors.orange.shade800,
//       );
//       return;
//     }

//     final passwordValidation = validatePassword(password);
//     if (passwordValidation != null) {
//       Get.snackbar(
//         "Invalid Password",
//         passwordValidation,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange.shade50,
//         colorText: Colors.orange.shade800,
//       );
//       return;
//     }

//     isLoading.value = true;

//     try {
//       final uri = Uri.parse(ApiConfig.login);

//       final body = jsonEncode({'email': email, 'password': password});

//       final response = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: body,
//       );

//       if (response.statusCode == 200) {
//         // success
//         final data = jsonDecode(response.body) as Map<String, dynamic>;
//         final userId = data['data']?['user_id'] as String?;
//         Get.snackbar(
//           "Success",
//           "Signed in successfully",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green.shade50,
//           colorText: Colors.green.shade800,
//         );

//         // Save user id/session as needed. Example:
//         // await storage.write(key: 'user_id', value: userId);

//         // navigate to dashboard
//         // small delay to let user read snackbar
//         Future.delayed(const Duration(milliseconds: 600), () {
//           Get.offNamed('/dashboard', arguments: {'user_id': userId});
//         });
//       } else {
//         // parse failure payload
//         final payload = jsonDecode(response.body) as Map<String, dynamic>?;

//         final error = payload?['error'] as String?;
//         final message = payload?['message'] as String? ?? 'Login failed';

//         // handle known errors from API spec
//         switch (response.statusCode) {
//           case 401:
//             // Invalid credentials
//             Get.snackbar(
//               "Invalid Credentials",
//               message,
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.orange.shade50,
//               colorText: Colors.orange.shade800,
//             );
//             break;
//           case 403:
//             // Could be EmailNotVerified or InactiveAccount
//             if (error == 'EmailNotVerified') {
//               Get.snackbar(
//                 "Email Not Verified",
//                 "Please verify your email before login.",
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.orange.shade50,
//                 colorText: Colors.orange.shade800,
//               );

//               // optionally navigate to verify screen and pass email
//               Future.delayed(const Duration(milliseconds: 400), () {
//                 Get.toNamed('/verify-account', arguments: {'email': email});
//               });
//             } else if (error == 'InactiveAccount') {
//               Get.snackbar(
//                 "Account Inactive",
//                 "User account is inactive. Please contact support.",
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.orange.shade50,
//                 colorText: Colors.orange.shade800,
//               );
//             } else {
//               Get.snackbar(
//                 "Error",
//                 message,
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.orange.shade50,
//                 colorText: Colors.orange.shade800,
//               );
//             }
//             break;
//           case 404:
//             // User not found
//             Get.snackbar(
//               "User Not Found",
//               message,
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.orange.shade50,
//               colorText: Colors.orange.shade800,
//             );
//             break;
//           default:
//             Get.snackbar(
//               "Error",
//               message,
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.red.shade50,
//               colorText: Colors.red.shade800,
//             );
//         }
//       }
//     } catch (e, st) {
//       // network or parsing error
//       debugPrint("Login error: $e\n$st");
//       Get.snackbar(
//         "Network Error",
//         "Unable to contact server. Please try again.",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.shade50,
//         colorText: Colors.red.shade800,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void forgotPassword() {
//     Get.toNamed('/forgot-password');
//   }

//   void verifyAccount() {
//     // optional: route to verify-account
//     Get.toNamed('/verify-account');
//   }

//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter email';
//     const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$';
//     if (!RegExp(pattern).hasMatch(value)) {
//       emailError.value = "Please enter a valid email address";
//       return 'Please enter a valid email address';
//     }
//     emailError.value = '';
//     return null;
//   }

//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter password';
//     }
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   void createAccount() {
//     Get.toNamed('/role-selection');
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }

// ========================================================================================================
// ========================================================================================================
// ========================================================================================================

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:get_storage/get_storage.dart';
// import '../../../utils/api_endpoints.dart';

// class LoginController extends GetxController {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   var isPasswordVisible = false.obs;
//   var isLoading = false.obs;
//   var emailError = ''.obs;

//   // small helper to access GetStorage box
//   final GetStorage _box = GetStorage();

//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   /// Sign in and persist user_id into session storage on success.
//   Future<void> signIn() async {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();

//     // client-side validation
//     final emailValidation = validateEmail(email);
//     if (emailValidation != null) {
//       Get.snackbar(
//         "Invalid Email",
//         emailValidation,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange.shade50,
//         colorText: Colors.orange.shade800,
//       );
//       return;
//     }

//     final passwordValidation = validatePassword(password);
//     if (passwordValidation != null) {
//       Get.snackbar(
//         "Invalid Password",
//         passwordValidation,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.orange.shade50,
//         colorText: Colors.orange.shade800,
//       );
//       return;
//     }

//     isLoading.value = true;

//     try {
//       final uri = Uri.parse(ApiConfig.login);
//       final body = jsonEncode({'email': email, 'password': password});

//       final response = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: body,
//       );

//       if (response.statusCode == 200) {
//         // success - parse and persist user_id
//         final data = jsonDecode(response.body) as Map<String, dynamic>;
//         final userId = data['data']?['user_id'] as String?;

//         if (userId != null && userId.isNotEmpty) {
//           // persist user_id in GetStorage
//           await _box.write('user_id', userId);

//           // optionally persist other session info:
//           // await _box.write('auth_token', token);
//           // await _box.write('user_email', email);

//           Get.snackbar(
//             "Success",
//             "Signed in successfully",
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.green.shade50,
//             colorText: Colors.green.shade800,
//           );

//           // navigate to dashboard (small delay to let user read snackbar)
//           Future.delayed(const Duration(milliseconds: 600), () {
//             Get.offNamed('/dashboard', arguments: {'user_id': userId});
//           });
//         } else {
//           // no user id in response — treat as failure
//           Get.snackbar(
//             "Error",
//             "Login succeeded but no user id returned.",
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.orange.shade50,
//             colorText: Colors.orange.shade800,
//           );
//         }
//       } else {
//         // parse failure payload
//         final payload = jsonDecode(response.body) as Map<String, dynamic>?;
//         final error = payload?['error'] as String?;
//         final message = payload?['message'] as String? ?? 'Login failed';

//         // handle known errors from API spec
//         switch (response.statusCode) {
//           case 401:
//             Get.snackbar(
//               "Invalid Credentials",
//               message,
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.orange.shade50,
//               colorText: Colors.orange.shade800,
//             );
//             break;
//           case 403:
//             if (error == 'EmailNotVerified') {
//               Get.snackbar(
//                 "Email Not Verified",
//                 "Please verify your email before login.",
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.orange.shade50,
//                 colorText: Colors.orange.shade800,
//               );

//               Future.delayed(const Duration(milliseconds: 400), () {
//                 Get.toNamed('/verify-account', arguments: {'email': email});
//               });
//             } else if (error == 'InactiveAccount') {
//               Get.snackbar(
//                 "Account Inactive",
//                 "User account is inactive. Please contact support.",
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.orange.shade50,
//                 colorText: Colors.orange.shade800,
//               );
//             } else {
//               Get.snackbar(
//                 "Error",
//                 message,
//                 snackPosition: SnackPosition.BOTTOM,
//                 backgroundColor: Colors.orange.shade50,
//                 colorText: Colors.orange.shade800,
//               );
//             }
//             break;
//           case 404:
//             Get.snackbar(
//               "User Not Found",
//               message,
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.orange.shade50,
//               colorText: Colors.orange.shade800,
//             );
//             break;
//           default:
//             Get.snackbar(
//               "Error",
//               message,
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.red.shade50,
//               colorText: Colors.red.shade800,
//             );
//         }
//       }
//     } catch (e, st) {
//       debugPrint("Login error: $e\n$st");
//       Get.snackbar(
//         "Network Error",
//         "Unable to contact server. Please try again.",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.shade50,
//         colorText: Colors.red.shade800,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Helper to get stored user id (returns null if not found)
//   String? getUserId() {
//     return _box.read('user_id') as String?;
//   }

//   /// Logout / clear session
//   Future<void> logout() async {
//     await _box.remove('user_id');
//     // remove other keys if stored:
//     // await _box.remove('auth_token');
//     // optionally navigate to sign-in screen:
//     Get.offAllNamed('/login');
//   }

//   void forgotPassword() {
//     Get.toNamed('/forgot-password');
//   }

//   void verifyAccount() {
//     Get.toNamed('/verify-account');
//   }

//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter email';
//     const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$';
//     if (!RegExp(pattern).hasMatch(value)) {
//       emailError.value = "Please enter a valid email address";
//       return 'Please enter a valid email address';
//     }
//     emailError.value = '';
//     return null;
//   }

//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter password';
//     }
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   void createAccount() {
//     Get.toNamed('/role-selection');
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.onClose();
//   }
// }

// ========================================================================================================
// ========================================================================================================
// ========================================================================================================

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../utils/api_endpoints.dart';
import '../../../utils/auth_token_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;
  var emailError = ''.obs;

  // secure storage instance (const constructor recommended)
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final authTokenService = Get.find<AuthTokenService>();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Sign in and persist user_id into secure storage on success.
  Future<void> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // client-side validation
    final emailValidation = validateEmail(email);
    if (emailValidation != null) {
      Get.snackbar(
        "Invalid Email",
        emailValidation,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade50,
        colorText: Colors.orange.shade800,
      );
      return;
    }

    final passwordValidation = validatePassword(password);
    if (passwordValidation != null) {
      Get.snackbar(
        "Invalid Password",
        passwordValidation,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade50,
        colorText: Colors.orange.shade800,
      );
      return;
    }

    isLoading.value = true;

    try {
      final uri = Uri.parse(ApiConfig.login);
      final body = jsonEncode({'email': email, 'password': password});

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        // success - parse and persist user_id
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final userId = data['data']?['user_id'] as String?;

        if (userId != null && userId.isNotEmpty) {
          // persist user_id in secure storage
          await _secureStorage.write(key: 'user_id', value: userId);

          // optionally persist other session info securely:
          // await _secureStorage.write(key: 'auth_token', value: token);
          // await _secureStorage.write(key: 'user_email', value: email);

          //Generate and save token right after login
          await authTokenService.getValidToken();

          Get.snackbar(
            "Success",
            "Signed in successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.shade50,
            colorText: Colors.green.shade800,
          );

          // navigate to dashboard (small delay to let user read snackbar)
          Future.delayed(const Duration(milliseconds: 600), () {
            Get.offNamed('/dashboard', arguments: {'user_id': userId});
          });
        } else {
          // no user id in response — treat as failure
          Get.snackbar(
            "Error",
            "Login succeeded but no user id returned.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange.shade50,
            colorText: Colors.orange.shade800,
          );
        }
      } else {
        // parse failure payload
        final payload = jsonDecode(response.body) as Map<String, dynamic>?;
        final error = payload?['error'] as String?;
        final message = payload?['message'] as String? ?? 'Login failed';

        // handle known errors from API spec
        switch (response.statusCode) {
          case 401:
            Get.snackbar(
              "Invalid Credentials",
              message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange.shade50,
              colorText: Colors.orange.shade800,
            );
            break;
          case 403:
            if (error == 'EmailNotVerified') {
              Get.snackbar(
                "Email Not Verified",
                "Please verify your email before login.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.orange.shade50,
                colorText: Colors.orange.shade800,
              );

              Future.delayed(const Duration(milliseconds: 400), () {
                Get.toNamed('/verify-account', arguments: {'email': email});
              });
            } else if (error == 'InactiveAccount') {
              Get.snackbar(
                "Account Inactive",
                "User account is inactive. Please contact support.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.orange.shade50,
                colorText: Colors.orange.shade800,
              );
            } else {
              Get.snackbar(
                "Error",
                message,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.orange.shade50,
                colorText: Colors.orange.shade800,
              );
            }
            break;
          case 404:
            Get.snackbar(
              "User Not Found",
              message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange.shade50,
              colorText: Colors.orange.shade800,
            );
            break;
          default:
            Get.snackbar(
              "Error",
              message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.shade50,
              colorText: Colors.red.shade800,
            );
        }
      }
    } catch (e, st) {
      debugPrint("Login error: $e\n$st");
      Get.snackbar(
        "Network Error",
        "Unable to contact server. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade800,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Helper to get stored user id (returns null if not found)
  Future<String?> getUserId() async {
    return await _secureStorage.read(key: 'user_id');
  }

  /// Logout / clear session
  Future<void> logout() async {
    await _secureStorage.delete(key: 'user_id');
    // remove other keys if stored:
    // await _secureStorage.delete(key: 'auth_token');
    // optionally navigate to sign-in screen:
    Get.offAllNamed('/login');
  }

  void forgotPassword() {
    Get.toNamed('/forgot-password');
  }

  void verifyAccount() {
    Get.toNamed('/verify-account');
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter email';
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$';
    if (!RegExp(pattern).hasMatch(value)) {
      emailError.value = "Please enter a valid email address";
      return 'Please enter a valid email address';
    }
    emailError.value = '';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void createAccount() {
    Get.toNamed('/role-selection');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
