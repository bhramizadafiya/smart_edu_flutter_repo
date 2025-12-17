import 'package:get/get.dart';
import 'package:smarted/modules/onpapertest/controller/onpapertest_controller.dart';


class OnTestPaperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnTestPaperController>(() => OnTestPaperController());
  }
}