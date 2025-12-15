import 'package:get/get.dart';

class ChapterListController extends GetxController {
  var chapters = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadChapters();
  }

  void loadChapters() {
    chapters.assignAll([
      {
        'title': 'Chapter 1: Sets and Functions',
        'pages': 'Pages 1–25 • 24 pages',
      },
      {
        'title': 'Chapter 2: Sets and Functions',
        'pages': 'Pages 26–50 • 24 pages',
      },
      {
        'title': 'Chapter 3: Sets and Functions',
        'pages': 'Pages 51–75 • 24 pages',
      },
      {
        'title': 'Chapter 4: Sets and Functions',
        'pages': 'Pages 76–100 • 24 pages',
      },
      {
        'title': 'Chapter 5: Sets and Functions',
        'pages': 'Pages 101–125 • 24 pages',
      },
      {
        'title': 'Chapter 6: Sets and Functions',
        'pages': 'Pages 126–150 • 24 pages',
      },
      {
        'title': 'Chapter 7: Sets and Functions',
        'pages': 'Pages 151–175 • 24 pages',
      },
    ]);
  }

  void sortChapters() {
    chapters.sort((a, b) => a['title'].compareTo(b['title']));
    chapters.refresh();
  }

  void addChapter(Map<String, dynamic> chapter) {
    // chapters.add(chapter);
    Get.toNamed("add-chapter");
  }

  void deleteChapter(int index) {
    chapters.removeAt(index);
  }
}
