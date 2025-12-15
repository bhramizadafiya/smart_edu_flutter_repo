
import 'package:get/get.dart';
import '../controller/coresubjects_controller.dart';

class CoreSubjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoreSubjectsController>(() => CoreSubjectsController());
  }
}