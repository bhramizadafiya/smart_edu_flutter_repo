import 'package:get/get.dart';

enum UserRole { student, professor }

class UserRoleController extends GetxController {
  var selectedRole = Rxn<UserRole>();

  void selectRole(UserRole role) {
    selectedRole.value = role;
  }

  void continueNext() {
    if (selectedRole.value == null) {
      Get.snackbar(
        "Select Role",
        "Please choose your role before continuing",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // pass role string to next screen
    final roleStr = selectedRole.value == UserRole.professor
        ? 'Professor'
        : 'Student';

    Get.toNamed('/create-account', arguments: {'role': roleStr});
  }
}
