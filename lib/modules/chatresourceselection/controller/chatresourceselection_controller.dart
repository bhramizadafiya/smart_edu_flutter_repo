// chatresourceselection_controller.dart
import 'package:get/get.dart';
import 'chatresourceselection_blending.dart';

class ChatResourceSelectionController extends GetxController {
  final RxList<BookItem> books = <BookItem>[].obs;
  final RxList<RecentSession> recent = <RecentSession>[].obs;
  final RxBool generalSelected = false.obs;
  final RxInt selectedChapterCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _seedExampleData();
    _recomputeSelectedCount();
  }

  void toggleBookSelection(BookItem book) {
    final newBookSelected = !book.selected.value;
    book.selected.value = newBookSelected;

    if (newBookSelected) {
      for (final chap in book.chapters) {
        if (chap.processed.value) {
          chap.selected.value = true;
        } else {
          chap.selected.value = false;
        }
      }
    } else {
      for (final chap in book.chapters) {
        chap.selected.value = false;
      }
    }

    _recomputeSelectedCount();
  }

  void toggleBookExpanded(BookItem book) {
    book.expanded.value = !book.expanded.value;
  }

  void toggleChapterSelection(BookItem book, ChapterItem chapter) {
    if (!chapter.processed.value) return;

    chapter.selected.value = !chapter.selected.value;

    final processedChaps = book.chapters
        .where((c) => c.processed.value)
        .toList();

    if (processedChaps.isEmpty) {
      book.selected.value = false;
    } else {
      final allProcessedSelected = processedChaps.every(
        (c) => c.selected.value,
      );
      book.selected.value = allProcessedSelected;
    }

    _recomputeSelectedCount();
  }

  void processChapter(BookItem book, ChapterItem chapter) {
    chapter.processed.value = true;
    if (book.selected.value) {
      chapter.selected.value = true;
    }

    final processedChaps = book.chapters
        .where((c) => c.processed.value)
        .toList();
    if (processedChaps.isNotEmpty &&
        processedChaps.every((c) => c.selected.value)) {
      book.selected.value = true;
    }

    _recomputeSelectedCount();
  }

  void toggleGeneral(bool value) {
    generalSelected.value = value;
  }

  void startAiChat({RecentSession? fromRecent}) {
    final selectedChapters = <ChapterItem>[];
    for (final b in books) {
      for (final c in b.chapters) {
        if (c.selected.value) selectedChapters.add(c);
      }
    }

    if (fromRecent != null) {
      Get.snackbar('Continue Chat', 'Continuing ${fromRecent.title}');
      return;
    }

    if (generalSelected.value && selectedChapters.isEmpty) {
      Get.snackbar('Chat', 'Starting General AI Chat');
    } else {
      Get.snackbar(
        'AI Chat',
        'Starting with ${selectedChapters.length} chapter(s) ${generalSelected.value ? " + General" : ""}',
      );
    }

    Get.toNamed("chatscreen");
  }

  void continueRecent(RecentSession session) {
    startAiChat(fromRecent: session);
  }

  void _recomputeSelectedCount() {
    int total = 0;
    for (final b in books) {
      for (final c in b.chapters) {
        if (c.selected.value) total++;
      }
    }
    selectedChapterCount.value = total;
  }

  void _seedExampleData() {
    final b1 = BookItem(
      title: 'Mathematics — Volume 1',
      subtitle: 'Class 12 NCERT',
      selected: false.obs,
      expanded: false.obs,
      processed: false.obs,
      chapters: <ChapterItem>[
        ChapterItem(
          title: 'Chapter 1',
          subtitle: 'Relations and Functions',
          selected: false.obs,
          processed: true.obs,
          hasPreviousChat: false.obs,
        ),
        ChapterItem(
          title: 'Chapter 2',
          subtitle: 'Inverse Trigonometric Functions',
          selected: false.obs,
          processed: true.obs,
          hasPreviousChat: true.obs,
        ),
        ChapterItem(
          title: 'Chapter 3',
          subtitle: 'Matrices',
          selected: false.obs,
          processed: false.obs,
          hasPreviousChat: false.obs,
        ),
      ].obs,
    );

    final b2 = BookItem(
      title: 'Mathematics — Volume 2',
      subtitle: 'Class 12 NCERT',
      selected: false.obs,
      expanded: false.obs,
      processed: false.obs,
      chapters: <ChapterItem>[
        ChapterItem(
          title: 'Chapter 4',
          subtitle: 'Determinants',
          selected: false.obs,
          processed: true.obs,
          hasPreviousChat: true.obs,
        ),
        ChapterItem(
          title: 'Chapter 5',
          subtitle: 'Continuity and Differentiability',
          selected: false.obs,
          processed: false.obs,
          hasPreviousChat: false.obs,
        ),
      ].obs,
    );

    final r1 = RecentSession(
      title: 'Limits and Continuity',
      snippet: 'Discussed continuity theorem',
      time: '2h ago',
    );
    final r2 = RecentSession(
      title: 'Trigonometric Graphs',
      snippet: 'Solved example 4.2',
      time: 'Yesterday',
    );

    books.assignAll([b1, b2]);
    recent.assignAll([r1, r2]);
  }
}
