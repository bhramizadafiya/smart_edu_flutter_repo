import 'package:get/get.dart';

class FeatureSelectionController extends GetxController {
  final subject = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args is Map) {
      subject.value = (args['subject']).toString();
    }
  }

  /// Handles 'Upload Materials' button
  void onUploadPressed() {
    Get.snackbar(
      'Upload Resources',
      'Upload Materials clicked',
      snackPosition: SnackPosition.BOTTOM,
    );

    // Navigate to the upload materials page
    Get.toNamed('/study-material-list', arguments: {'subject': subject.value});
  }

  /// Handles 'Start Chatting' button
  void onChatPressed() {
    Get.snackbar(
      'AI Chat',
      'Start Chatting clicked',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.toNamed('/language-selection', arguments: {'subject': subject.value});
  }

  /// Handles 'Take Test' button
  void onTestPressed() {
    Get.snackbar(
      'Mock Test',
      'Take Test clicked',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
