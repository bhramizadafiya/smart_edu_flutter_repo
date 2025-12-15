// chatresourceselection_binding.dart
import 'package:get/get.dart';
import '../controller/chatresourceselection_controller.dart';

class ChatResourceSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatResourceSelectionController>(
      () => ChatResourceSelectionController(),
    );
  }
}
