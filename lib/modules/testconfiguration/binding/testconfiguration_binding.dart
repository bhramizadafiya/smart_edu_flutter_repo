// lib/modules/testconfiguration/binding/test_configuration_binding.dart
import 'package:get/get.dart';
import 'package:smarted/modules/testconfiguration/controller/testconfiguration_controller.dart';


class TestConfigurationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestConfigurationController>(() => TestConfigurationController());
  }
}