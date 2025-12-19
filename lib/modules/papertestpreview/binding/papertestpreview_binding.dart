import 'package:get/get.dart';
import 'package:smarted/modules/papertestpreview/controller/papertestpreview_controller.dart';


class PaperTestPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaperTestPreviewController>(() => PaperTestPreviewController());
  }
}