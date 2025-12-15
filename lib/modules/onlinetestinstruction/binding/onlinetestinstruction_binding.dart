import 'package:get/get.dart';
import 'package:smarted/modules/onlinetestinstruction/controller/onlinetestinstruction_controller.dart';


class OnlineTestInstructionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlineTestInstructionController>(() => OnlineTestInstructionController());
  }
}