import 'package:get/get.dart';
import '../../subjectselection/controller/subjectselection_controller.dart';

class SubjectSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubjectSelectionController>(
      () => SubjectSelectionController(),
    );
  }
}
