import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/userrole_controller.dart';
import '../../../theme/design_system.dart';

class UserRoleView extends GetView<UserRoleController> {
  const UserRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    final bool showBackButton = false;

    final bool isTablet = width >= 600 && width < 1024;
    final bool isDesktop = width >= 1024;

    double scaleFactor = 1.0;
    if (isTablet) scaleFactor = 1.2;
    if (isDesktop) scaleFactor = 1.4;

    double horizontalPadding = 24;
    if (isTablet) horizontalPadding = width * 0.2;
    if (isDesktop) horizontalPadding = width * 0.3;

    final Color hintGrey = Colors.grey.shade600;

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
                // Logo
                Container(
                  width: 80 * scaleFactor,
                  height: 80 * scaleFactor,
                  decoration: BoxDecoration(
                    color: const Color(0xFF234C3C),
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

                // Title
                Text(
                  "YB Nexus",
                  style: AppTextStyles.maintitle.copyWith(
                    fontSize: AppTextStyles.maintitle.fontSize! * scaleFactor,
                  ),
                ),
                SizedBox(height: 8 * scaleFactor),

                // Subtitle
                Text(
                  "Your AI-Powered Learning Companion",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.mainsubtitle.copyWith(
                    fontSize:
                        AppTextStyles.mainsubtitle.fontSize! * (scaleFactor),
                  ),
                ),
                SizedBox(height: 32 * scaleFactor),

                Text(
                  "Choose Your Role",
                  style: AppTextStyles.labelfield.copyWith(
                    fontSize: 16 * scaleFactor,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0E1621),
                  ),
                ),
                SizedBox(height: 24 * scaleFactor),

                // Student Option
                Obx(() {
                  final isSelected =
                      controller.selectedRole.value == UserRole.student;
                  return GestureDetector(
                    onTap: () => controller.selectRole(UserRole.student),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 20 * scaleFactor,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFEFF6F3)
                            : const Color(0xFFF9FAFB),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF234C3C)
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12 * scaleFactor),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 40 * scaleFactor,
                            color: const Color(0xFF234C3C),
                          ),
                          SizedBox(height: 8 * scaleFactor),
                          Text(
                            "Student",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0E1621),
                              fontSize: 16 * scaleFactor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(height: 16 * scaleFactor),

                // Professor Option
                Obx(() {
                  final isSelected =
                      controller.selectedRole.value == UserRole.professor;
                  return GestureDetector(
                    onTap: () => controller.selectRole(UserRole.professor),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 20 * scaleFactor,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFEFF6F3)
                            : const Color(0xFFF9FAFB),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF234C3C)
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12 * scaleFactor),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 40 * scaleFactor,
                            color: const Color(0xFF234C3C),
                          ),
                          SizedBox(height: 8 * scaleFactor),
                          Text(
                            "Professor",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0E1621),
                              fontSize: 16 * scaleFactor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                SizedBox(height: 32 * scaleFactor),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 52 * scaleFactor,
                  child: ElevatedButton(
                    onPressed: controller.continueNext,
                    style: AppTextStyles.button,
                    child: Text(
                      "Continue",
                      style: AppTextStyles.userbuttontext.copyWith(
                        fontSize:
                            AppTextStyles.userbuttontext.fontSize! *
                            scaleFactor,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
