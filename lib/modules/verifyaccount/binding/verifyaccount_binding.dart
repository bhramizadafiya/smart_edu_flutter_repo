import 'package:get/get.dart';
import '../controller/verifyaccount_controller.dart';

class VerifyAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyAccountController>(() => VerifyAccountController());
  }
}
