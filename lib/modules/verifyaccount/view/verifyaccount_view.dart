import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/verifyaccount_controller.dart';
import '../../../theme/design_system.dart'; // For AppColors / AppTextStyles (if available)
import '../../../utils/custom_text_field.dart'; // Your reusable text field

class VerifyAccountView extends GetView<VerifyAccountController> {
  const VerifyAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive helpers
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final bool isTablet = width >= 600 && width < 1024;
    final bool isDesktop = width >= 1024;

    final double scaleFactor = isDesktop ? 1.35 : (isTablet ? 1.12 : 1.0);

    // Constrain the inner content to a comfortable width so it looks centered on large screens
    final double maxInnerWidth = isDesktop ? 540 : (isTablet ? 520 : 420);

    // Colors (use your design_system AppColors if available)
    final Color hintGrey = Colors.grey.shade600;

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
            horizontal: (width * 0.06).clamp(16.0, 80.0),
            vertical: 24.0 * scaleFactor,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxInnerWidth),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon container
                  Container(
                    width: 80 * scaleFactor,
                    height: 80 * scaleFactor,
                    decoration: BoxDecoration(
                      color: AppColors.textcolor,
                      borderRadius: BorderRadius.circular(20 * scaleFactor),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.vpn_key_rounded,
                        color: Colors.white,
                        size: 28 * scaleFactor,
                      ),
                    ),
                  ),

                  SizedBox(height: 18 * scaleFactor),

                  // Title
                  Text(
                    'Verify Account',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.maintitle,
                  ),

                  SizedBox(height: 8 * scaleFactor),

                  // Subtitle
                  Text(
                    "Don't worry! Enter your email and we'll send you a reset code.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.mainsubtitle,
                  ),

                  SizedBox(height: 20 * scaleFactor),

                  // Custom text field (uses your shared widget)
                  CustomTextField(
                    label: 'Email Address',
                    controller: controller.emailController,
                    hint: 'Enter your email address',
                    validator: controller.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    // If your CustomTextField supports validator, wrap accordingly; otherwise validate on submit
                  ),

                  SizedBox(height: 20 * scaleFactor),

                  // Send Reset Code button
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 52 * scaleFactor,
                      child: ElevatedButton(
                        onPressed: controller.isSending.value
                            ? null
                            : controller.sendResetCode,
                        style: AppTextStyles.button,
                        child: controller.isSending.value
                            ? SizedBox(
                                height: 20 * scaleFactor,
                                width: 20 * scaleFactor,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                'Send Reset Code',
                                style: AppTextStyles.userbuttontext,
                              ),
                      ),
                    ),
                  ),

                  SizedBox(height: 22 * scaleFactor),

                  // Back to Sign In
                  GestureDetector(
                    onTap: () => Get.back(),
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 18 * scaleFactor,
                          color: hintGrey,
                        ),
                        SizedBox(width: 8 * scaleFactor),
                        Text('Back', style: AppTextStyles.mainsubtitle),
                      ],
                    ),
                  ),

                  SizedBox(height: 16 * scaleFactor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
