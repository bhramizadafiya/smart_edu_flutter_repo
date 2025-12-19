// answerkey_binding.dart
import 'package:get/get.dart';
import '../controller/answerkey_controller.dart';

class AnswerKeyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnswerKeyController>(() => AnswerKeyController());
  }
}