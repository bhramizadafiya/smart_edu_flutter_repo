import 'package:get/get.dart';
import '../controller/userrole_controller.dart';

class UserRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRoleController>(() => UserRoleController());
  }
}
