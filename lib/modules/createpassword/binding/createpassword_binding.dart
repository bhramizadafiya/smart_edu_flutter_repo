import 'package:get/get.dart';
import '../controller/createpassword_controller.dart';

class CreatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePasswordController>(() => CreatePasswordController());
  }
}
