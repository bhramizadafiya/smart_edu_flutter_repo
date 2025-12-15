import 'package:get/get.dart';

class SplashController extends GetxController {
  /// Duration to keep splash before navigating away
  final int splashSeconds = 4;

  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(Duration(seconds: splashSeconds));
    Get.offNamed('/login');
  }

  /*void _navigateToNext() async {
    await Future.delayed(Duration(seconds: splashSeconds));

    final bool isLoggedIn = false; // Replace with your auth logic
    if (isLoggedIn) {
      Get.offNamed('/home');
    } else {
      Get.offNamed('/login');
    }
  } */
}
