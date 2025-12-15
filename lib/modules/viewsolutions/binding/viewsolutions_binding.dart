// lib/modules/viewsolutions/binding/viewsolutions_binding.dart
import 'package:get/get.dart';
import '../controller/viewsolutions_controller.dart';

class ViewSolutionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewSolutionsController());
  }
}