import 'package:get/get.dart';
import '../controller/chapterlist_controller.dart';

class ChapterListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChapterListController>(() => ChapterListController());
  }
}
