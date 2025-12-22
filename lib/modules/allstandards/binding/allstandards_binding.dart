// binding/allstandards_binding.dart
import 'package:get/get.dart';
import '../controller/allstandards_controller.dart';

class AllStandardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllStandardsController>(() => AllStandardsController());
  }
}