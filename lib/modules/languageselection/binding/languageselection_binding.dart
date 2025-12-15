// languageselection_binding.dart
import 'package:get/get.dart';
import '../controller/languageselection_controller.dart';

class LanguageSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageSelectionController>(
      () => LanguageSelectionController(),
    );
  }
}
