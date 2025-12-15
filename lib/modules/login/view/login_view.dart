// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/login_controller.dart';
// import '../../../theme/design_system.dart';

// class LoginView extends GetView<LoginController> {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;

//     // Responsive breakpoints
//     final bool isTablet = width >= 600 && width < 1024;
//     final bool isDesktop = width >= 1024;

//     // Dynamic scaling factors
//     double scaleFactor = 1.0;
//     if (isTablet) scaleFactor = 1.2;
//     if (isDesktop) scaleFactor = 1.4;

//     // Dynamic padding based on screen size
//     double horizontalPadding = 24;
//     if (isTablet) horizontalPadding = width * 0.2;
//     if (isDesktop) horizontalPadding = width * 0.3;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//             horizontal: horizontalPadding,
//             vertical: 32 * scaleFactor * 0.8,
//           ),
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 500),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Logo Circle
//                 Container(
//                   width: 80 * scaleFactor,
//                   height: 80 * scaleFactor,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF234C3C),
//                     borderRadius: BorderRadius.circular(20 * scaleFactor),
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     "YB",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 28 * scaleFactor,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 24 * scaleFactor),

//                 // Welcome Text
//                 Text(
//                   "Welcome",
//                   style: AppTextStyles.maintitle.copyWith(
//                     fontSize: AppTextStyles.maintitle.fontSize! * scaleFactor,
//                   ),
//                 ),
//                 SizedBox(height: 8 * scaleFactor),
//                 Text(
//                   "Sign in to continue your learning journey",
//                   textAlign: TextAlign.center,
//                   style: AppTextStyles.mainsubtitle.copyWith(
//                     fontSize:
//                         AppTextStyles.mainsubtitle.fontSize! *
//                         (scaleFactor * 0.95),
//                   ),
//                 ),
//                 SizedBox(height: 32 * scaleFactor),

//                 // Email or Phone
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Email or Phone",
//                     style: AppTextStyles.labelfield.copyWith(
//                       fontSize:
//                           AppTextStyles.labelfield.fontSize! * scaleFactor,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 8 * scaleFactor),
//                 TextField(
//                   controller: controller.emailController,
//                   style: TextStyle(fontSize: 14 * scaleFactor),
//                   decoration: InputDecoration(
//                     hintText: "Enter email or phone",
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: 16 * scaleFactor,
//                       vertical: 16 * scaleFactor,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8 * scaleFactor),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20 * scaleFactor),

//                 // Password
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Password",
//                     style: AppTextStyles.labelfield.copyWith(
//                       fontSize:
//                           AppTextStyles.labelfield.fontSize! * scaleFactor,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 8 * scaleFactor),
//                 Obx(
//                   () => TextField(
//                     controller: controller.passwordController,
//                     obscureText: !controller.isPasswordVisible.value,
//                     style: TextStyle(fontSize: 14 * scaleFactor),
//                     decoration: InputDecoration(
//                       hintText: "Enter your password",
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: 16 * scaleFactor,
//                         vertical: 16 * scaleFactor,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8 * scaleFactor),
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           controller.isPasswordVisible.value
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: Colors.grey,
//                           size: 22 * scaleFactor,
//                         ),
//                         onPressed: controller.togglePasswordVisibility,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 12 * scaleFactor),

//                 // Forgot & Verify
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton(
//                       onPressed: controller.forgotPassword,
//                       child: Text(
//                         "Forgot Password?",
//                         style: AppTextStyles.linktext.copyWith(
//                           fontSize:
//                               AppTextStyles.linktext.fontSize! * scaleFactor,
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: controller.verifyAccount,
//                       child: Text(
//                         "Verify Account",
//                         style: AppTextStyles.linktext.copyWith(
//                           fontSize:
//                               AppTextStyles.linktext.fontSize! * scaleFactor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16 * scaleFactor),

//                 // Sign In Button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 52 * scaleFactor,
//                   child: ElevatedButton(
//                     onPressed: controller.signIn,
//                     style: AppTextStyles.button,
//                     child: Text(
//                       "Sign In",
//                       style: AppTextStyles.userbuttontext.copyWith(
//                         fontSize:
//                             AppTextStyles.userbuttontext.fontSize! *
//                             scaleFactor,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 24 * scaleFactor),

//                 // Create Account
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "New to YB Nexus? ",
//                       style: AppTextStyles.mainsubtitle.copyWith(
//                         fontSize:
//                             AppTextStyles.mainsubtitle.fontSize! * scaleFactor,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: controller.createAccount,
//                       child: Text(
//                         "Create Account",
//                         style: AppTextStyles.linktext.copyWith(
//                           fontSize:
//                               AppTextStyles.linktext.fontSize! * scaleFactor,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';
import '../../../theme/design_system.dart';
import '../../../utils/custom_text_field.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final bool showBackButton = false;

    // Responsive breakpoints
    final bool isTablet = width >= 600 && width < 1024;
    final bool isDesktop = width >= 1024;

    // Dynamic scaling factors
    double scaleFactor = 1.0;
    if (isTablet) scaleFactor = 1.2;
    if (isDesktop) scaleFactor = 1.4;

    // Dynamic padding based on screen size
    double horizontalPadding = 24;
    if (isTablet) horizontalPadding = width * 0.2;
    if (isDesktop) horizontalPadding = width * 0.3;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: showBackButton,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Center(
        child: SingleChildScrollView(
          // padding: EdgeInsets.symmetric(
          //   horizontal: horizontalPadding,
          //   vertical: 32 * scaleFactor * 0.8,
          // ),
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            top: 8 * scaleFactor, // less top space → moves content up
            bottom: 8 * scaleFactor,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Circle
                Container(
                  width: 80 * scaleFactor,
                  height: 80 * scaleFactor,
                  decoration: BoxDecoration(
                    color: AppColors.textcolor,
                    borderRadius: BorderRadius.circular(20 * scaleFactor),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "YB",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28 * scaleFactor,
                    ),
                  ),
                ),
                SizedBox(height: 24 * scaleFactor),

                // Welcome Text
                Text(
                  "Welcome",
                  style: AppTextStyles.maintitle.copyWith(
                    fontSize: AppTextStyles.maintitle.fontSize! * scaleFactor,
                  ),
                ),
                SizedBox(height: 8 * scaleFactor),
                Text(
                  "Sign in to continue your learning journey",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.mainsubtitle.copyWith(
                    fontSize:
                        AppTextStyles.mainsubtitle.fontSize! *
                        (scaleFactor * 0.95),
                  ),
                ),
                SizedBox(height: 32 * scaleFactor),

                CustomTextField(
                  label: "Email or Phone",
                  controller: controller.emailController,
                  hint: "Enter email or phone",
                  validator: controller.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: 20 * scaleFactor),

                Obx(
                  () => CustomTextField(
                    label: "Password",
                    controller: controller.passwordController,
                    hint: "Enter your password",
                    validator: controller.validatePassword,
                    obscureText: !controller.isPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),
                SizedBox(height: 12 * scaleFactor),

                // Forgot & Verify
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: controller.forgotPassword,
                      child: Text(
                        "Forgot Password?",
                        style: AppTextStyles.linktext.copyWith(
                          fontSize:
                              AppTextStyles.linktext.fontSize! * scaleFactor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: controller.verifyAccount,
                      child: Text(
                        "Verify Account",
                        style: AppTextStyles.linktext.copyWith(
                          fontSize:
                              AppTextStyles.linktext.fontSize! * scaleFactor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16 * scaleFactor),

                // Sign In Button
                // SizedBox(
                //   width: double.infinity,
                //   height: 52 * scaleFactor,
                //   child: ElevatedButton(
                //     onPressed: controller.signIn,
                //     style: AppTextStyles.button,
                //     child: Text(
                //       "Sign In",
                //       style: AppTextStyles.userbuttontext.copyWith(
                //         fontSize:
                //             AppTextStyles.userbuttontext.fontSize! *
                //             scaleFactor,
                //       ),
                //     ),
                //   ),
                // ),

                // Sign In Button (replace previous SizedBox ElevatedButton block)
                Obx(() {
                  final loading = controller.isLoading.value;
                  return SizedBox(
                    width: double.infinity,
                    height: 52 * scaleFactor,
                    child: ElevatedButton(
                      onPressed: loading ? null : controller.signIn,
                      style: AppTextStyles.button,
                      child: loading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "Signing In...",
                                  style: AppTextStyles.userbuttontext.copyWith(
                                    fontSize:
                                        AppTextStyles.userbuttontext.fontSize! *
                                        scaleFactor,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              "Sign In",
                              style: AppTextStyles.userbuttontext.copyWith(
                                fontSize:
                                    AppTextStyles.userbuttontext.fontSize! *
                                    scaleFactor,
                              ),
                            ),
                    ),
                  );
                }),

                SizedBox(height: 24 * scaleFactor),

                // Create Account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to YB Nexus? ",
                      style: AppTextStyles.mainsubtitle.copyWith(
                        fontSize:
                            AppTextStyles.mainsubtitle.fontSize! * scaleFactor,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.createAccount,
                      child: Text(
                        "Create Account",
                        style: AppTextStyles.linktext.copyWith(
                          fontSize:
                              AppTextStyles.linktext.fontSize! * scaleFactor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
