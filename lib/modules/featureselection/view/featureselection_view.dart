import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/theme/design_system.dart';
import '../controller/featureselection_controller.dart';
import '../../../widgets/custom_appbar.dart';

class FeatureSelectionView extends GetView<FeatureSelectionController> {
  const FeatureSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: controller.subject.value, showSearch: false),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: height * 0.02,
        ),
        child: Column(
          children: [
            _buildSectionCard(
              context: context,
              icon: Icons.cloud_upload_outlined,
              iconBgColor: AppColors.bluecolor.withOpacity(0.12),
              iconColor: AppColors.bluecolor,
              title: 'Upload Resources',
              subtitle:
                  'Upload your textbooks, notes, and study materials for AI-powered assistance',
              chips: const ['PDF Support', 'OCR Scanning', 'Smart Search'],
              chipTextColor: AppColors.bluecolor,
              chipBgColor: AppColors.bluecolor.withOpacity(0.08),
              buttonText: 'Upload Materials',
              buttonIcon: Icons.add_rounded,
              buttonColor: AppColors.bluecolor,
              onPressed: controller.onUploadPressed,
            ),
            SizedBox(height: height * 0.035),

            _buildSectionCard(
              context: context,
              icon: Icons.smart_toy_outlined,
              iconBgColor: AppColors.textcolor.withOpacity(0.12),
              iconColor: AppColors.textcolor,
              title: 'AI Chat',
              subtitle:
                  'Get instant answers, explanations, and step-by-step solutions from our AI tutor',
              chips: const ['24/7 Available', 'Multilingual', 'Voice Chat'],
              chipTextColor: AppColors.textcolor,
              chipBgColor: AppColors.textcolor.withOpacity(0.08),
              buttonText: 'Start Chatting',
              buttonIcon: Icons.chat_bubble_outline_rounded,
              buttonColor: AppColors.textcolor,
              onPressed: controller.onChatPressed,
            ),
            SizedBox(height: height * 0.035),

            _buildSectionCard(
              context: context,
              icon: Icons.article_outlined,
              iconBgColor: AppColors.orangecolor.withOpacity(0.12),
              iconColor: AppColors.orangecolor,
              title: 'Mock Test',
              subtitle:
                  'Take practice tests to evaluate your knowledge and track your progress',
              chips: const ['Timed Tests', 'Instant Results', 'Performance'],
              chipTextColor: AppColors.orangecolor,
              chipBgColor: AppColors.orangecolor.withOpacity(0.08),
              buttonText: 'Take Test',
              buttonIcon: Icons.play_arrow_rounded,
              buttonColor: AppColors.orangecolor,
              onPressed: controller.onTestPressed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required List<String> chips,
    required Color chipTextColor,
    required Color chipBgColor,
    required String buttonText,
    required Color buttonColor,
    required IconData buttonIcon, // 👈 new parameter
    required VoidCallback onPressed,
  }) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.03,
        horizontal: width * 0.05,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top circular icon
          Container(
            height: height * 0.065,
            width: height * 0.065,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBgColor,
            ),
            child: Icon(icon, color: iconColor, size: height * 0.035),
          ),
          SizedBox(height: height * 0.018),

          // Title
          Text(title, style: AppTextStyles.maintitle),

          SizedBox(height: height * 0.012),

          // Chips Row
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 6,
            children: chips
                .map(
                  (e) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                      vertical: height * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: chipBgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      e,
                      style: TextStyle(
                        fontSize: width * 0.03,
                        color: chipTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),

          SizedBox(height: height * 0.015),

          // Subtitle
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.mainsubtitle,
          ),

          SizedBox(height: height * 0.022),

          // Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(
                buttonIcon, // 👈 dynamic icon here
                color: Colors.white,
                size: height * 0.022,
              ),
              label: Text(
                buttonText,
                style: TextStyle(
                  fontSize: width * 0.038,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: height * 0.014),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildSectionCard({
  //   required BuildContext context,
  //   required IconData icon,
  //   required Color iconBgColor,
  //   required Color iconColor,
  //   required String title,
  //   required String subtitle,
  //   required List<String> chips,
  //   required Color chipTextColor,
  //   required Color chipBgColor,
  //   required String buttonText,
  //   required Color buttonColor,
  //   required VoidCallback onPressed,
  // }) {
  //   final width = MediaQuery.of(context).size.width;
  //   final height = MediaQuery.of(context).size.height;

  //   return Container(
  //     padding: EdgeInsets.symmetric(
  //       vertical: height * 0.03,
  //       horizontal: width * 0.05,
  //     ),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: Colors.grey.shade300, width: 1.5),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.08),
  //           blurRadius: 10,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         // Top circular icon
  //         Container(
  //           height: height * 0.065,
  //           width: height * 0.065,
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: iconBgColor,
  //           ),
  //           child: Icon(icon, color: iconColor, size: height * 0.035),
  //         ),
  //         SizedBox(height: height * 0.018),

  //         // Title
  //         Text(title, style: AppTextStyles.maintitle),

  //         SizedBox(height: height * 0.012),

  //         // Chips Row
  //         Wrap(
  //           alignment: WrapAlignment.center,
  //           spacing: 6,
  //           runSpacing: 6,
  //           children: chips
  //               .map(
  //                 (e) => Container(
  //                   padding: EdgeInsets.symmetric(
  //                     horizontal: width * 0.03,
  //                     vertical: height * 0.005,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: chipBgColor,
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   child: Text(
  //                     e,
  //                     style: TextStyle(
  //                       fontSize: width * 0.03,
  //                       color: chipTextColor,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ),
  //               )
  //               .toList(),
  //         ),

  //         SizedBox(height: height * 0.015),

  //         // Subtitle
  //         Text(
  //           subtitle,
  //           textAlign: TextAlign.center,
  //           style: AppTextStyles.mainsubtitle,
  //         ),

  //         SizedBox(height: height * 0.022),

  //         // Button (slightly smaller now)
  //         SizedBox(
  //           width: double.infinity,
  //           child: ElevatedButton.icon(
  //             onPressed: onPressed,
  //             icon: Icon(
  //               Icons.play_arrow_rounded,
  //               color: Colors.white,
  //               size: height * 0.022,
  //             ),
  //             label: Text(
  //               buttonText,
  //               style: TextStyle(
  //                 fontSize: width * 0.038,
  //                 fontWeight: FontWeight.w600,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             style: ElevatedButton.styleFrom(
  //               elevation: 0,
  //               backgroundColor: buttonColor,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //               padding: EdgeInsets.symmetric(vertical: height * 0.014),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
