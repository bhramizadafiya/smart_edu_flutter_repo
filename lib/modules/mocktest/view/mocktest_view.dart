import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/testconfiguration/binding/testconfiguration_binding.dart';
import 'package:smarted/modules/testconfiguration/view/testconfiguration_view.dart';
import 'package:smarted/modules/testmode/binding/testmode_binding.dart';
import 'package:smarted/modules/testmode/view/testmode_view.dart';
import '../controller/mocktest_controller.dart';

class MockTestView extends GetView<MockTestController> {
  const MockTestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive horizontal padding
    final horizontalPadding = screenWidth < 360
        ? 12.0
        : screenWidth < 600
            ? 16.0
            : 24.0;

    // Responsive font scaling
    double scaleFont(double size) {
      if (screenWidth < 360) return size * 0.85;
      if (screenWidth < 600) return size * 0.95;
      return size;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Select Test Resources",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: scaleFont(18),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: ColoredBox(
            color: const Color(0xFFE3F2FD),
            child: Column(
              children: [
                const ColoredBox(
                  color: Colors.blue,
                  child: SizedBox(height: 1.5, width: double.infinity),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      horizontalPadding, 16, horizontalPadding, 16),
                  child: Row(
                    children: [
                      Icon(Icons.history, color: Colors.blue, size: scaleFont(26)),
                      SizedBox(width: horizontalPadding / 2),
                      Text(
                        "Recent Test",
                        style: TextStyle(
                          fontSize: scaleFont(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ================= BODY =================
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth =
                    constraints.maxWidth > 900 ? 900.0 : constraints.maxWidth;

                return Center(
                  child: SizedBox(
                    width: maxWidth,
                    child: Obx(() {
                      final bool recentSelected =
                          controller.selectedRecentTestIndex.value != -1;
                      final bool anyChapterSelected = controller.books
                          .any((b) => b.chapters.any((c) => c.isSelected));
                      final bool canProceed =
                          recentSelected || anyChapterSelected;

                      return ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          // ================= RECENT TESTS =================
                          Container(
                            color: const Color(0xFFE3F2FD),
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: horizontalPadding),
                              child: Column(
                                children: controller.recentTests
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  final index = e.key;
                                  final test = e.value;
                                  final isSelected = controller
                                          .selectedRecentTestIndex.value ==
                                      index;

                                  return GestureDetector(
                                    onTap: () => controller
                                            .selectedRecentTestIndex.value =
                                        isSelected ? -1 : index,
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: EdgeInsets.all(
                                          screenWidth < 360 ? 12 : 16),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFFE3F2FD)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.blue
                                              : Colors.grey.shade300,
                                          width: isSelected ? 2.2 : 1.5,
                                        ),
                                        boxShadow: [
                                          if (!isSelected)
                                            BoxShadow(
                                              color: Colors.grey.shade200,
                                              blurRadius: 3,
                                              offset: const Offset(0, 2),
                                            ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: scaleFont(18),
                                            backgroundColor: isSelected
                                                ? Colors.blue[700]
                                                : Colors.grey[700],
                                            child: Icon(
                                              Icons.chat_bubble_outline,
                                              color: Colors.white,
                                              size: scaleFont(18),
                                            ),
                                          ),
                                          SizedBox(width: horizontalPadding / 2),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  test.title,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: scaleFont(14),
                                                    color: isSelected
                                                        ? Colors.black87
                                                        : Colors.grey[800],
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  "${test.subtitle} • ${test.messageCount} messages",
                                                  style: TextStyle(
                                                    fontSize: scaleFont(13),
                                                    color: isSelected
                                                        ? Colors.black87
                                                        : Colors.black54,
                                                  ),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  test.timeAgo,
                                                  style: TextStyle(
                                                    fontSize: scaleFont(12),
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: isSelected
                                                    ? Colors.transparent
                                                    : Colors.grey.shade400,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: scaleFont(14),
                                                  color: isSelected
                                                      ? Colors.blue[700]
                                                      : Colors.grey[600],
                                                ),
                                                SizedBox(width: 6),
                                                Text(
                                                  "Continue",
                                                  style: TextStyle(
                                                    color: isSelected
                                                        ? Colors.blue[700]
                                                        : Colors.grey[600],
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: scaleFont(14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),

                          

                          // ================= AI MOCK TEST =================
                          GestureDetector(
                            onTap: () => controller.isAiMockTestSelected.toggle(),
                            child: Container(
                              color: const Color(0xFFE8F5E8),
                              padding: EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: horizontalPadding,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: controller.isAiMockTestSelected.value
                                            ? const Color(0xFF34BF8E)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: controller.isAiMockTestSelected.value
                                              ? const Color(0xFF34BF8E)
                                              : Colors.grey.shade400,
                                          width: 2.5,
                                        ),
                                      ),
                                      child: controller.isAiMockTestSelected.value
                                          ? const Icon(Icons.check,
                                              color: Colors.white, size: 18)
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.aiMockTestTitle.value,
                                          style: TextStyle(
                                            fontSize: scaleFont(17),
                                            fontWeight: FontWeight.w900,
                                            color: const Color(0xFF34BF8E),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          controller.aiMockTestSubtitle.value,
                                          style: TextStyle(
                                            fontSize: scaleFont(14),
                                            height: 1.4,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFFC36C15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(height: 2, color: const Color(0xFF34BF8E)),
                          const SizedBox(height: 24),

                          // ================= TESTS FROM YOUR MATERIALS =================
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Tests from Your Materials",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: scaleFont(18),
                                      color: const Color(0xFF0C4525),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "3 books available",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // ===== BOOKS & CHAPTERS (UNCHANGED LOGIC & DESIGN) =====
                          ...controller.books.map((book) => Column(
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        controller.toggleBookExpand(book),
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16,
                                          horizontal: horizontalPadding),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: book.chapters
                                                .every((c) => c.isSelected),
                                            activeColor: const Color(0xFF34BF8E),
                                            onChanged: (_) =>
                                                controller.toggleBookSelection(book),
                                          ),
                                          const SizedBox(width: 12),
                                          const Icon(Icons.book_outlined,
                                              color: Color(0xFF34BF8E),
                                              size: 28),
                                          const SizedBox(width: 14),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  book.title,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Color(0xFF0C4525),
                                                  ),
                                                ),
                                                Text(
                                                  book.subtitle,
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 13.5),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            book.isExpanded
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: Colors.grey[600],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  if (book.isExpanded)
                                    Container(
                                      color: const Color(0xFFE8F5E8),
                                      child: Column(
                                        children: book.chapters.map((chapter) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: horizontalPadding + 10),
                                            child: Container(
                                              padding: const EdgeInsets.fromLTRB(
                                                  40, 12, 20, 12),
                                              decoration: BoxDecoration(
                                                color: chapter.isSelected
                                                    ? const Color(0xFFE8F5E8)
                                                    : Colors.white,
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: chapter.isSelected
                                                        ? const Color(0xFF34BF8E)
                                                        : Colors.grey.shade300,
                                                    width: chapter.isSelected ? 2 : 1,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    value: chapter.isSelected,
                                                    activeColor:
                                                        const Color(0xFF34BF8E),
                                                    onChanged: (_) => controller
                                                        .toggleChapterSelection(
                                                            book, chapter),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          chapter.title,
                                                          style: const TextStyle(
                                                            fontSize: 14.5,
                                                            fontWeight: FontWeight.w500,
                                                            color: Color(0xFF0C4525),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          "Pages ${chapter.pages} • ${chapter.topics} topics",
                                                          style: TextStyle(
                                                              color: Colors.grey[600],
                                                              fontSize: 12.5),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),

                                  Container(height: 1, color: Colors.grey[300]),
                                ],
                              )),

                          const SizedBox(height: 100),
                        ],
                      );
                    }),
                  ),
                );
              },
            ),
          ),

          // ================= FIXED BUTTONS =================
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(
                horizontalPadding, 16, horizontalPadding, 30),
            child: Obx(() {
              final bool recentSelected =
                  controller.selectedRecentTestIndex.value != -1;
              final bool anyChapterSelected = controller.books
                  .any((b) => b.chapters.any((c) => c.isSelected));
              final bool canProceed =
                  recentSelected || anyChapterSelected;

              return Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: canProceed
                        ? () => Get.to(() => const TestModeView(),
                            binding: TestModeBinding())
                        : null,
                    icon: const Icon(Icons.settings,
                        size: 22, color: Colors.white),
                    label: const Text(
                      "Configure Test",
                      style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: canProceed
                          ? const Color(0xFF1BB173)
                          : Colors.grey[300],
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  const SizedBox(height: 13),
                  OutlinedButton.icon(
                    onPressed: canProceed
                        ? () => Get.to(
                              () => const TestConfigurationView(),
                              binding: TestConfigurationBinding(),
                            )
                        : null,
                    icon: Icon(Icons.play_arrow,
                        size: 26,
                        color: canProceed
                            ? const Color(0xFF1BB173)
                            : Colors.grey[400]),
                    label: Text(
                      "Quick Start (Default Settings)",
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600,
                        color: canProceed
                            ? const Color(0xFF1BB173)
                            : Colors.grey[400],
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: canProceed
                              ? const Color(0xFF1BB173)
                              : Colors.grey[400]!,
                          width: canProceed ? 2.8 : 2),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
