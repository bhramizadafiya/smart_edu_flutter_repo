import 'package:get/get.dart';
import '../controller/featureselection_controller.dart';

class FeatureSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeatureSelectionController>(() => FeatureSelectionController());
  }
}
