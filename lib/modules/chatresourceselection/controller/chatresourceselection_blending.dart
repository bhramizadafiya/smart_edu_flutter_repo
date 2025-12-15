// chatresourceselection_blending.dart
import 'package:get/get.dart';

class ChapterItem {
  String title;
  String subtitle;
  RxBool selected;
  RxBool processed;
  RxBool hasPreviousChat;

  ChapterItem({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.processed,
    required this.hasPreviousChat,
  });
}

class BookItem {
  String title;
  String subtitle;
  RxBool selected;
  RxBool expanded;
  RxBool processed;
  RxList<ChapterItem> chapters;

  BookItem({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.expanded,
    required this.processed,
    required this.chapters,
  });

  get id => null;
}

class RecentSession {
  String title;
  String snippet;
  String time;

  RecentSession({
    required this.title,
    required this.snippet,
    required this.time,
  });
}
