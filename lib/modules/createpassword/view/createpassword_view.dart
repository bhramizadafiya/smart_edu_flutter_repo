import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/createpassword_controller.dart';
import '../../../theme/design_system.dart';
import '../../../utils/custom_text_field.dart';

class CreatePasswordView extends GetView<CreatePasswordController> {
  const CreatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive scaling
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final bool isTablet = width >= 600 && width < 1024;
    final bool isDesktop = width >= 1024;

    final double scaleFactor = isDesktop ? 1.4 : (isTablet ? 1.18 : 1.0);
    final double maxContentWidth = isDesktop ? 640 : (isTablet ? 520 : 420);

    // Colors & styles (kept local so file is copy-paste runnable)
    const Color lightText = Color(0xFF2B2B2B);
    const Color muted = Color(0xFF8A8A8A);

    final Color hintGrey = Colors.grey.shade600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Create New Password', style: AppTextStyles.maintitle),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: (width * 0.06).clamp(16.0, 80.0),
            vertical: 20 * scaleFactor,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                Container(
                  width: 92 * scaleFactor,
                  height: 92 * scaleFactor,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF6F0),
                    borderRadius: BorderRadius.circular(18 * scaleFactor),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.verified_user_outlined,
                      color: AppColors.textcolor,
                      size: 42 * scaleFactor,
                    ),
                  ),
                ),

                SizedBox(height: 18 * scaleFactor),

                // Subtitle text
                Text(
                  'Create a strong password to secure your account',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.mainsubtitle,
                ),

                SizedBox(height: 24 * scaleFactor),

                Obx(
                  () => CustomTextField(
                    label: "Password",
                    hint: "Enter your new password",
                    controller: controller.passwordController,
                    validator: controller.validatePassword,
                    obscureText: controller.isNewHidden.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isNewHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: controller.toggleNewVisibility,
                    ),
                  ),
                ),

                SizedBox(height: 18 * scaleFactor),

                Obx(
                  () => CustomTextField(
                    label: "Confirm Password",
                    hint: "Confirm your new password",
                    controller: controller.confirmPasswordController,
                    validator: controller.validateConfirmPassword,
                    obscureText: controller.isConfirmHidden.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: controller.toggleConfirmVisibility,
                    ),
                  ),
                ),

                SizedBox(height: 22 * scaleFactor),

                // Password requirements
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password Requirements:',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: lightText,
                      fontSize: 13 * scaleFactor,
                    ),
                  ),
                ),
                SizedBox(height: 10 * scaleFactor),

                // Requirement: at least 8 chars
                Obx(
                  () => _requirementRow(
                    ticked: controller.hasMinLength.value,
                    text: 'At least 8 characters',
                    scale: scaleFactor,
                    primary: AppColors.textcolor,
                    muted: muted,
                  ),
                ),
                SizedBox(height: 8 * scaleFactor),

                // Requirement: one uppercase
                Obx(
                  () => _requirementRow(
                    ticked: controller.hasUppercase.value,
                    text: 'One uppercase letter',
                    scale: scaleFactor,
                    primary: AppColors.textcolor,
                    muted: muted,
                  ),
                ),
                SizedBox(height: 8 * scaleFactor),

                // Requirement: one number or symbol
                Obx(
                  () => _requirementRow(
                    ticked: controller.hasNumberOrSymbol.value,
                    text: 'One number or symbol',
                    scale: scaleFactor,
                    primary: AppColors.textcolor,
                    muted: muted,
                  ),
                ),

                SizedBox(height: 28 * scaleFactor),

                // Submit button
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 54 * scaleFactor,
                    child: ElevatedButton(
                      onPressed: controller.isSubmitting.value
                          ? null
                          : controller.submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.textcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * scaleFactor),
                        ),
                      ),
                      child: controller.isSubmitting.value
                          ? SizedBox(
                              width: 24 * scaleFactor,
                              height: 24 * scaleFactor,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                                strokeWidth: 2.4,
                              ),
                            )
                          : Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16 * scaleFactor,
                              ),
                            ),
                    ),
                  ),
                ),

                SizedBox(height: 18 * scaleFactor),

                // Back to login
                GestureDetector(
                  onTap: () => Get.offNamed('/login'),
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

                SizedBox(height: 18 * scaleFactor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // small helper for requirement row
  Widget _requirementRow({
    required bool ticked,
    required String text,
    required double scale,
    required Color primary,
    required Color muted,
  }) {
    return Row(
      children: [
        Container(
          width: 20 * scale,
          height: 20 * scale,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ticked ? primary : Colors.grey.shade300,
              width: 2,
            ),
            color: ticked ? const Color(0xFFEAF6F0) : Colors.transparent,
          ),
          child: ticked
              ? Icon(Icons.check, size: 14 * scale, color: primary)
              : const SizedBox.shrink(),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: muted, fontSize: 13 * scale),
          ),
        ),
      ],
    );
  }
}
