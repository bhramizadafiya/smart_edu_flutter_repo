// bindings/mocktest_binding.dart
import 'package:get/get.dart';
import '../controller/mocktest_controller.dart';

class MockTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MockTestController>(() => MockTestController());
  }
}