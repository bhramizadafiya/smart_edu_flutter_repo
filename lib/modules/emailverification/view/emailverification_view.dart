// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/emailverification_controller.dart';
// import '../../../theme/design_system.dart';

// class EmailVerificationView extends GetView<EmailVerificationController> {
//   const EmailVerificationView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final bool isTablet = width >= 600 && width < 1024;
//     final bool isDesktop = width >= 1024;

//     double scaleFactor = 1.0;
//     if (isTablet) scaleFactor = 1.2;
//     if (isDesktop) scaleFactor = 1.4;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//             horizontal: width * 0.08,
//             vertical: 24 * scaleFactor,
//           ),
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxWidth: 400),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // 🔒 Icon
//                 Container(
//                   padding: EdgeInsets.all(18 * scaleFactor),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFE8F0EC),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.verified_user_outlined,
//                     color: AppColors.textcolor,
//                     size: 42 * scaleFactor,
//                   ),
//                 ),
//                 SizedBox(height: 24 * scaleFactor),

//                 // Title
//                 Text("Verify Your Account", style: AppTextStyles.maintitle),
//                 SizedBox(height: 8 * scaleFactor),

//                 // Subtitle
//                 Text(
//                   "We've sent a 6-digit verification code to your email",
//                   textAlign: TextAlign.center,
//                   style: AppTextStyles.mainsubtitle,
//                 ),
//                 SizedBox(height: 12 * scaleFactor),

//                 // Email Display
//                 Obx(
//                   () => Text(
//                     controller.email.value,
//                     style: TextStyle(
//                       fontSize: 16 * scaleFactor,
//                       fontWeight: FontWeight.w600,
//                       color: const Color(0xFF1A1F36),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 24 * scaleFactor),

//                 // Verification Code Label
//                 Text(
//                   "Enter Verification Code",
//                   style: TextStyle(
//                     fontSize: 15 * scaleFactor,
//                     fontWeight: FontWeight.w500,
//                     color: const Color(0xFF1A1F36),
//                   ),
//                 ),
//                 SizedBox(height: 12 * scaleFactor),

//                 // OTP Boxes
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(
//                     6,
//                     (index) => SizedBox(
//                       width: 45 * scaleFactor,
//                       height: 55 * scaleFactor,
//                       child: TextField(
//                         controller: controller.otpControllers[index],
//                         textAlign: TextAlign.center,
//                         keyboardType: TextInputType.number,
//                         maxLength: 1,
//                         decoration: InputDecoration(
//                           counterText: "",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: const BorderSide(
//                               color: AppColors.textcolor,
//                               width: 1.5,
//                             ),
//                           ),
//                         ),
//                         onChanged: (value) {
//                           if (value.isNotEmpty && index < 5) {
//                             FocusScope.of(context).nextFocus();
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20 * scaleFactor),

//                 // Countdown Timer
//                 Obx(() {
//                   final minutes = (controller.remainingTime.value ~/ 60)
//                       .toString()
//                       .padLeft(2, '0');
//                   final seconds = (controller.remainingTime.value % 60)
//                       .toString()
//                       .padLeft(2, '0');
//                   return Column(
//                     children: [
//                       Text(
//                         "Code expires in",
//                         style: TextStyle(
//                           fontSize: 14 * scaleFactor,
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         "$minutes:$seconds",
//                         style: TextStyle(
//                           fontSize: 16 * scaleFactor,
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//                 SizedBox(height: 20 * scaleFactor),

//                 // Resend Option
//                 Column(
//                   children: [
//                     Text(
//                       "Didn't receive the code?",
//                       style: TextStyle(
//                         fontSize: 14 * scaleFactor,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: controller.resendCode,
//                       child: Text(
//                         "Resend via Email",
//                         style: TextStyle(
//                           color: AppColors.textcolor,
//                           fontSize: 14 * scaleFactor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 24 * scaleFactor),

//                 // Verify Button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 52 * scaleFactor,
//                   child: ElevatedButton(
//                     onPressed: controller.verifyCode,
//                     style: AppTextStyles.button,
//                     child: Text(
//                       "Verify Account",
//                       style: AppTextStyles.userbuttontext,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20 * scaleFactor),

//                 // Back to Registration
//                 GestureDetector(
//                   onTap: () => Get.back(),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(
//                         Icons.arrow_back,
//                         size: 18,
//                         color: Colors.grey,
//                       ),
//                       SizedBox(width: 4 * scaleFactor),
//                       Text(
//                         "Back to Registration",
//                         style: AppTextStyles.mainsubtitle,
//                       ),
//                     ],
//                   ),
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
import '../controller/emailverification_controller.dart';
import '../../../theme/design_system.dart'; // optional: for colors & textstyles

class EmailVerificationView extends GetView<EmailVerificationController> {
  const EmailVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final bool isTablet = width >= 600 && width < 1024;
    final bool isDesktop = width >= 1024;
    final double scale = isDesktop ? 1.4 : (isTablet ? 1.15 : 1.0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.08,
            vertical: 24 * scale,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 520 : 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon circle (static)
                Container(
                  padding: EdgeInsets.all(18 * scale),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F0EC),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified_user_outlined,
                    color: AppColors.textcolor,
                    size: 42 * scale,
                  ),
                ),
                SizedBox(height: 24 * scale),

                // Title (dynamic) - only this Text is reactive
                Obx(
                  () => Text(
                    ctrl.title.value,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.maintitle.copyWith(
                      fontSize:
                          (AppTextStyles.maintitle.fontSize ?? 22) * scale,
                    ),
                  ),
                ),

                SizedBox(height: 8 * scale),

                // Subtitle (dynamic)
                Obx(
                  () => Text(
                    ctrl.subtitle.value,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.mainsubtitle.copyWith(
                      fontSize:
                          (AppTextStyles.mainsubtitle.fontSize ?? 14) * scale,
                    ),
                  ),
                ),
                SizedBox(height: 12 * scale),

                // Email display (dynamic)
                Obx(
                  () => Text(
                    ctrl.email.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16 * scale,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1F36),
                    ),
                  ),
                ),
                SizedBox(height: 24 * scale),

                // Enter Verification label (static)
                Text(
                  'Enter Verification Code',
                  style: TextStyle(
                    fontSize: 15 * scale,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1A1F36),
                  ),
                ),
                SizedBox(height: 12 * scale),

                // OTP boxes (static widgets but they update by controllers)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    final boxWidth =
                        (isDesktop ? 56 : (isTablet ? 52 : 44)) * scale;
                    final boxHeight =
                        (isDesktop ? 68 : (isTablet ? 60 : 54)) * scale;
                    return SizedBox(
                      width: boxWidth,
                      height: boxHeight,
                      child: TextField(
                        controller: ctrl.otpControllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.textcolor,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.textcolor,
                              width: 1.8,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            // move focus to next
                            if (index < 5) {
                              FocusScope.of(context).nextFocus();
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          } else {
                            // if empty, move back
                            if (index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          }
                        },
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20 * scale),

                // Countdown (reactive)
                Obx(() {
                  final minutes = (ctrl.remainingTime.value ~/ 60)
                      .toString()
                      .padLeft(2, '0');
                  final seconds = (ctrl.remainingTime.value % 60)
                      .toString()
                      .padLeft(2, '0');
                  return Column(
                    children: [
                      Text(
                        'Code expires in',
                        style: TextStyle(
                          fontSize: 14 * scale,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '$minutes:$seconds',
                        style: TextStyle(
                          fontSize: 16 * scale,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 20 * scale),

                // Resend area: the availability is reactive (using remainingTime)
                Column(
                  children: [
                    Text(
                      'Didn\'t receive the code?',
                      style: TextStyle(
                        fontSize: 14 * scale,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 6),
                    // Only this Text depends on remainingTime, so wrap the smallest widget
                    Obx(() {
                      final bool canResend = ctrl.remainingTime.value == 0;
                      return GestureDetector(
                        onTap: canResend ? ctrl.resendCode : null,
                        child: Text(
                          'Resend via Email',
                          style: TextStyle(
                            fontSize: 14 * scale,
                            color: canResend
                                ? AppColors.textcolor
                                : Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 24 * scale),

                // Primary button (dynamic text) - wrap only the text that changes
                SizedBox(
                  width: double.infinity,
                  height: 52 * scale,
                  child: ElevatedButton(
                    onPressed: ctrl.verifyCode,
                    style: AppTextStyles.button,
                    child: Obx(
                      () => Text(
                        ctrl.buttonText.value,
                        style: AppTextStyles.userbuttontext,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20 * scale),

                // Back link (static)
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        size: 18,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 6 * scale),
                      Text('Back', style: AppTextStyles.mainsubtitle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
