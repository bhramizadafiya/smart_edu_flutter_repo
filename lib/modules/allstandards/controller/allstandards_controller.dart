// controller/allstandards_controller.dart
import 'package:get/get.dart';
import 'package:smarted/modules/dashboard/controller/dashboard_controller.dart';


class AllStandardsController extends GetxController {
  final DashboardController dashboardController = Get.find<DashboardController>();

  // Expose the list directly
  RxList<StandardItem> get standards => dashboardController.standards;

  void selectStandard(StandardItem standard) {
    dashboardController.selectStandard(standard);
  }
}