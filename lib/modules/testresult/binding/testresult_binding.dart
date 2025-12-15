// lib/modules/testresult/binding/testresult_binding.dart

import 'package:get/get.dart';
import '../controller/testresult_controller.dart';

class TestResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestResultController>(() => TestResultController());
  }
}