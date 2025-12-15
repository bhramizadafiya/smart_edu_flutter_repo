import 'package:get/get.dart';
import '../controller/studymateriallist_controller.dart';

class StudyMaterialListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudyMaterialListController>(
      () => StudyMaterialListController(),
    );
  }
}
