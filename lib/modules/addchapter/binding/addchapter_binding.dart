import 'package:get/get.dart';
import '../controller/addchapter_controller.dart';

class AddChapterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddChapterController>(() => AddChapterController());
  }
}
