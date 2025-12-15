import 'package:get/get.dart';
import 'package:smarted/modules/onlinetestsummary/controller/onlinetestsummary_controller.dart';


class OnlineTestSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlineTestSummaryController>(() => OnlineTestSummaryController());
  }
}