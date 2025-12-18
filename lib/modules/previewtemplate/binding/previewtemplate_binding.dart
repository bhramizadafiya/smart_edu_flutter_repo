import 'package:get/get.dart';
import 'package:smarted/modules/previewtemplate/controller/previewtemplate_controller.dart';


class PreviewTemplateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewTemplateController>(() => PreviewTemplateController());
  }
}