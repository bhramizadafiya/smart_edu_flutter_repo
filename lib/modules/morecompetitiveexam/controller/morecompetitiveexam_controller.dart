// modules/morecompetitiveexam/controller/morecompetitiveexam_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 // ← Import your AppColors
import 'package:smarted/modules/dashboard/controller/dashboard_controller.dart';
import 'package:smarted/theme/design_system.dart';

class MoreCompetitiveExamsController extends GetxController {
  final RxList<ExamItem> exams = <ExamItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    final dashboardCtrl = Get.find<DashboardController>();
    exams.assignAll(dashboardCtrl.exams);
  }

  /// Returns the primary (middle) color for text/icons/badges
  Color getExamColor(String code) {
    switch (code) {
      case 'JEE':
        return AppColors.gradientRedMiddle;
      case 'NEET':
        return AppColors.gradientMiddle;
      case 'CLAT':
        return AppColors.gradientPurpleMiddle;
      case 'CAT':
        return AppColors.gradientOrangeMiddle;
      case 'UGC':
        return AppColors.gradientUgcMiddle;
      case 'GATE':
        return AppColors.gradientGateMiddle;
      default:
        return Colors.blue.shade700;
    }
  }

  /// Returns gradient colors list for CircleAvatar background
  List<Color> getGradientColors(String code) {
    switch (code) {
      case 'JEE':
        return [
          AppColors.gradientRedStart,
          AppColors.gradientRedMiddle,
          AppColors.gradientRedEnd,
        ];
      case 'NEET':
        return [
          AppColors.gradientStart,
          AppColors.gradientMiddle,
          AppColors.gradientEnd,
        ];
      case 'CLAT':
        return [
          AppColors.gradientPurpleStart,
          AppColors.gradientPurpleMiddle,
          AppColors.gradientPurpleEnd,
        ];
      case 'CAT':
        return [
          AppColors.gradientOrangeStart,
          AppColors.gradientOrangeMiddle,
          AppColors.gradientOrangeEnd,
        ];
      case 'UGC':
        return [
          AppColors.gradientUgcStart,
          AppColors.gradientUgcMiddle,
          AppColors.gradientUgcEnd,
        ];
      case 'GATE':
        return [
          AppColors.gradientGateStart,
          AppColors.gradientGateMiddle,
          AppColors.gradientGateEnd,
        ];
      default:
        return [Colors.blue, Colors.blue.shade700, Colors.blue.shade900];
    }
  }

  /// Optional: Get BoxDecoration with gradient (for direct use in view)
  BoxDecoration getGradientDecoration(String code) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: getGradientColors(code),
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shape: BoxShape.circle,
    );
  }

  void selectExam(ExamItem exam) {
    Get.find<DashboardController>().openExam(exam);
  }
}