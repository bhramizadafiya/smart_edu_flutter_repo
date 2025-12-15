// bindings/testmode_binding.dart
import 'package:get/get.dart';
import '../controller/testmode_controller.dart';

class TestModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestModeController>(() => TestModeController());
  }
}