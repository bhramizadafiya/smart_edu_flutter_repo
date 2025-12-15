import 'package:get/get.dart';
import '../controller/emailverification_controller.dart';

class EmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailVerificationController>(
      () => EmailVerificationController(),
    );
  }
}
