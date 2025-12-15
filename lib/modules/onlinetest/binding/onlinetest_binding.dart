// onlinetest_binding.dart
import 'package:get/get.dart';
import 'package:smarted/modules/onlinetest/controller/onlinetest_controller.dart';


class OnlineTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnlineTestController());
  }
}