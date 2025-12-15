
import 'package:get/get.dart';
import '../controller/uploadresource_controller.dart';

class UploadResourceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadResourceController>(() => UploadResourceController());
  }
}