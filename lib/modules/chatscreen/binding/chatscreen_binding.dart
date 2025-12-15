import 'package:get/get.dart';
import '../../chatscreen/controller/chatscreen_controller.dart';

class ChatScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatScreenController());
  }
}
