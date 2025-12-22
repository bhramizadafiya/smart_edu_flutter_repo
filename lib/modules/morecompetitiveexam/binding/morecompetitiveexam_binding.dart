// modules/morecompetitiveexam/binding/morecompetitiveexam_binding.dart
import 'package:get/get.dart';
import '../controller/morecompetitiveexam_controller.dart';

class MoreCompetitiveExamsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoreCompetitiveExamsController>(
      () => MoreCompetitiveExamsController(),
    );
  }
}