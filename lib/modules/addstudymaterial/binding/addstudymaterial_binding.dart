// addstudymaterial_binding.dart
import 'package:get/get.dart';
import '../controller/addstudymaterial_controller.dart';

class AddStudyMaterialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddStudyMaterialController>(() => AddStudyMaterialController());
  }
}
