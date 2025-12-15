// // chatresourceselection_view.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smarted/theme/design_system.dart';
// import 'package:smarted/widgets/custom_appbar.dart';
// import '../controller/chatresourceselection_controller.dart';
// import '../controller/chatresourceselection_blending.dart';

// class ChatResourceSelectionView extends StatelessWidget {
//   const ChatResourceSelectionView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ctrl = Get.put(ChatResourceSelectionController());
//     final width = MediaQuery.of(context).size.width;
//     final isWide = width > 720;
//     final horizontal = isWide ? width * 0.12 : 14.0;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: 'AI Chat Resource Selection',
//         showSearch: false,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _TopArea(),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   const Text(
//                     'Your Study Materials',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//                   ),
//                   const Spacer(),
//                   Obx(
//                     () => Text(
//                       '${ctrl.books.length} books available',
//                       style: const TextStyle(
//                         color: Colors.black54,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Obx(
//                 () => Column(
//                   children: ctrl.books
//                       .map(
//                         (book) => Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: _BookCard(
//                             book: book,
//                             onToggleBook: () => ctrl.toggleBookSelection(book),
//                             onToggleExpand: () => ctrl.toggleBookExpanded(book),
//                             onToggleChapter: (chap) =>
//                                 ctrl.toggleChapterSelection(book, chap),
//                             onChat: () => debugPrint('Chat for ${book.title}'),
//                             onProcess: (chap) =>
//                                 ctrl.processChapter(book, chap),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Obx(
//                 () => SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton.icon(
//                     onPressed: () => ctrl.startAiChat(),
//                     icon: const Icon(
//                       Icons.chat_bubble_outline,
//                       color: Colors.white,
//                     ),
//                     label: Text(
//                       'Start AI Chat',
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.textcolor,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _TopArea extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final ctrl = Get.find<ChatResourceSelectionController>();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: const [
//             Icon(Icons.history, color: Colors.blue),
//             SizedBox(width: 8),
//             Text(
//               'Recent Chat Sessions',
//               style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Obx(
//           () => Column(
//             children: ctrl.recent.map((s) {
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.blue.shade100),
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 child: ListTile(
//                   leading: Container(
//                     width: 44,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade50,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(
//                       Icons.chat_bubble_outline,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   title: Text(
//                     s.title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14.5,
//                     ),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         s.snippet,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           color: Colors.black54,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         s.time,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.black38,
//                         ),
//                       ),
//                     ],
//                   ),
//                   trailing: TextButton.icon(
//                     onPressed: () => ctrl.continueRecent(s),
//                     icon: const Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                     label: const Text(
//                       'Continue',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     style: TextButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//         const SizedBox(height: 10),
//         Obx(
//           () => GestureDetector(
//             onTap: () => ctrl.toggleGeneral(!ctrl.generalSelected.value),
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//               decoration: BoxDecoration(
//                 color: ctrl.generalSelected.value
//                     ? const Color(0xFFEFFCF3)
//                     : Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: ctrl.generalSelected.value
//                       ? AppColors.gradientMiddle
//                       : Colors.grey.shade300,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.green.shade50,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(
//                       Icons.smart_toy,
//                       color: AppColors.gradientMiddle,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'General AI Chat',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 15,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'General AI assistance for Mathematics',
//                           style: TextStyle(color: Colors.black54, fontSize: 13),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Container(
//                     height: 28,
//                     width: 28,
//                     decoration: BoxDecoration(
//                       color: ctrl.generalSelected.value
//                           ? AppColors.gradientMiddle
//                           : Colors.transparent,
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: ctrl.generalSelected.value
//                             ? AppColors.gradientMiddle
//                             : Colors.grey.shade400,
//                         width: ctrl.generalSelected.value ? 0 : 1.3,
//                       ),
//                     ),
//                     child: Center(
//                       child: ctrl.generalSelected.value
//                           ? const Icon(
//                               Icons.check,
//                               size: 16,
//                               color: Colors.white,
//                             )
//                           : const SizedBox.shrink(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _BookCard extends StatelessWidget {
//   final BookItem book;
//   final VoidCallback onToggleBook;
//   final VoidCallback onToggleExpand;
//   final void Function(ChapterItem) onToggleChapter;
//   final VoidCallback onChat;
//   final void Function(ChapterItem) onProcess;

//   const _BookCard({
//     required this.book,
//     required this.onToggleBook,
//     required this.onToggleExpand,
//     required this.onToggleChapter,
//     required this.onChat,
//     required this.onProcess,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(
//             color: book.selected.value
//                 ? AppColors.gradientMiddle
//                 : Colors.grey.shade300,
//             width: book.selected.value ? 2 : 1,
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             ListTile(
//               leading: GestureDetector(
//                 onTap: onToggleBook,
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade50,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Icon(
//                     Icons.menu_book_rounded,
//                     color: AppColors.gradientMiddle,
//                   ),
//                 ),
//               ),
//               title: Text(
//                 book.title,
//                 style: const TextStyle(fontWeight: FontWeight.w700),
//               ),
//               subtitle: Text(
//                 book.subtitle,
//                 style: const TextStyle(color: Colors.black54),
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Checkbox(
//                     value: book.selected.value,
//                     onChanged: (_) => onToggleBook(),
//                   ),
//                   GestureDetector(
//                     onTap: onToggleExpand,
//                     child: Icon(
//                       book.expanded.value
//                           ? Icons.keyboard_arrow_down
//                           : Icons.keyboard_arrow_right,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (book.expanded.value)
//               Column(
//                 children: book.chapters.map((c) {
//                   return Obx(() {
//                     final isProcessed = c.processed.value;
//                     return InkWell(
//                       onTap: () => onToggleChapter(c),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 10,
//                         ),
//                         decoration: const BoxDecoration(
//                           border: Border(
//                             top: BorderSide(color: Color(0xFFF2F2F2)),
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Checkbox(
//                               value: c.selected.value,
//                               onChanged: (_) =>
//                                   isProcessed ? onToggleChapter(c) : null,
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     c.title,
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 6),
//                                   Text(
//                                     c.subtitle,
//                                     style: const TextStyle(
//                                       color: Colors.black54,
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                   if (c.hasPreviousChat.value)
//                                     const Padding(
//                                       padding: EdgeInsets.only(top: 4),
//                                       child: Text(
//                                         'Continue previous chat (5 messages)',
//                                         style: TextStyle(
//                                           color: AppColors.gradientMiddle,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             if (!isProcessed)
//                               ElevatedButton(
//                                 onPressed: () => onProcess(c),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.orange,
//                                 ),
//                                 child: const Text(
//                                   'Process',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               )
//                             else
//                               IconButton(
//                                 onPressed: onChat,
//                                 icon: const Icon(
//                                   Icons.chat_bubble_outline,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     );
//                   });
//                 }).toList(),
//               ),
//           ],
//         ),
//       );
//     });
//   }
// }

// chatresourceselection_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/theme/design_system.dart';
import 'package:smarted/widgets/custom_appbar.dart';
import '../controller/chatresourceselection_controller.dart';
import '../controller/chatresourceselection_blending.dart';

class ChatResourceSelectionView extends StatelessWidget {
  const ChatResourceSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Get.put once here
    final ctrl = Get.put(ChatResourceSelectionController());
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 720;
    final horizontal = isWide ? width * 0.12 : 14.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'AI Chat Resource Selection',
        showSearch: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopArea(), // Top area contains its own Obx widgets
              const SizedBox(height: 16),

              // Header row: This row has a small reactive Text for count
              Row(
                children: [
                  const Text(
                    'Your Study Materials',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Obx(
                    // directly reads ctrl.books (RxList) -> valid Obx usage
                    () => Text(
                      '${ctrl.books.length} books available',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Books list: only wrap the dynamic list portion in Obx
              Obx(
                () => Column(
                  children: ctrl.books
                      .map(
                        (book) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _BookCard(
                            key: ValueKey(book.id),
                            book: book,
                            onToggleBook: () => ctrl.toggleBookSelection(book),
                            onToggleExpand: () => ctrl.toggleBookExpanded(book),
                            onToggleChapter: (chap) =>
                                ctrl.toggleChapterSelection(book, chap),
                            onChat: () => debugPrint('Chat for ${book.title}'),
                            onProcess: (chap) =>
                                ctrl.processChapter(book, chap),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),

              const SizedBox(height: 16),

              // Start AI Chat button (reads generalSelected for label)
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => ctrl.startAiChat(),
                    icon: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                    ),
                    label: Text(
                      ctrl.generalSelected.value
                          ? 'Start General AI Chat'
                          : 'Start AI Chat',
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textcolor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* Top area: recent sessions + general selection */
class _TopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ChatResourceSelectionController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.history, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              'Recent Chat Sessions',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // recent sessions: Obx -> reads ctrl.recent (RxList)
        Obx(
          () => Column(
            children: ctrl.recent.map((s) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade100),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.blue,
                    ),
                  ),
                  title: Text(
                    s.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.snippet,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        s.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                  trailing: TextButton.icon(
                    onPressed: () => ctrl.continueRecent(s),
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 10),

        // General AI card: Obx -> reads ctrl.generalSelected.value
        Obx(
          () => GestureDetector(
            onTap: () => ctrl.toggleGeneral(!ctrl.generalSelected.value),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                color: ctrl.generalSelected.value
                    ? const Color(0xFFEFFCF3)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ctrl.generalSelected.value
                      ? AppColors.gradientMiddle
                      : Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.smart_toy,
                      color: AppColors.gradientMiddle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'General AI Chat',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'General AI assistance for Mathematics',
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      color: ctrl.generalSelected.value
                          ? AppColors.gradientMiddle
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ctrl.generalSelected.value
                            ? AppColors.gradientMiddle
                            : Colors.grey.shade400,
                        width: ctrl.generalSelected.value ? 0 : 1.3,
                      ),
                    ),
                    child: Center(
                      child: ctrl.generalSelected.value
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/* Book card widget */

class _BookCard extends StatelessWidget {
  final BookItem book;
  final VoidCallback onToggleBook;
  final VoidCallback onToggleExpand;
  final void Function(ChapterItem) onToggleChapter;
  final VoidCallback onChat;
  final void Function(ChapterItem) onProcess;

  const _BookCard({
    super.key,
    required this.book,
    required this.onToggleBook,
    required this.onToggleExpand,
    required this.onToggleChapter,
    required this.onChat,
    required this.onProcess,
  });

  @override
  Widget build(BuildContext context) {
    // Each card listens to its own reactive fields (book.* Rx fields and chapter Rx fields)
    return Obx(() {
      // Use Material with shape & clipBehavior so everything inside is clipped to the rounded corners
      return Material(
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: book.selected.value
                ? AppColors.gradientMiddle
                : Colors.grey.shade300,
            width: book.selected.value ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            // ListTile is inside the Material so its ink will be clipped
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              leading: GestureDetector(
                onTap: onToggleBook,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: AppColors.gradientMiddle,
                  ),
                ),
              ),
              title: Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                book.subtitle,
                style: const TextStyle(color: Colors.black54),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: book.selected.value,
                    onChanged: (_) => onToggleBook(),
                    activeColor: AppColors.gradientMiddle,
                    checkColor: Colors.white,
                  ),
                  GestureDetector(
                    onTap: onToggleExpand,
                    child: Icon(
                      book.expanded.value
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                    ),
                  ),
                ],
              ),
            ),

            // Chapters (no internal scroll). Each chapter row uses Obx indirectly through the parent Obx
            if (book.expanded.value)
              Column(
                children: book.chapters.map((c) {
                  // fine-grained rebuild for each chapter row
                  return Obx(() {
                    final isProcessed = c.processed.value;
                    return InkWell(
                      onTap: () => isProcessed ? onToggleChapter(c) : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          // keep background colors but they will be clipped by the Material
                          color: isProcessed
                              ? Colors.white
                              : const Color(0xFFFFF4E6),
                          border: const Border(
                            top: BorderSide(color: Color(0xFFF2F2F2)),
                          ),
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: c.selected.value,
                              onChanged: (_) =>
                                  isProcessed ? onToggleChapter(c) : null,
                              activeColor: AppColors.gradientMiddle,
                              checkColor: Colors.white,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    c.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    c.subtitle,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                    ),
                                  ),
                                  if (c.hasPreviousChat.value)
                                    const Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text(
                                        'Continue previous chat (5 messages)',
                                        style: TextStyle(
                                          color: AppColors.gradientMiddle,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (!isProcessed)
                              ElevatedButton(
                                onPressed: () => onProcess(c),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: const Text(
                                  'Process',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            else
                              IconButton(
                                onPressed: onChat,
                                icon: const Icon(
                                  Icons.chat_bubble_outline,
                                  color: Colors.black54,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  });
                }).toList(),
              ),
          ],
        ),
      );
    });
  }
}

// class _BookCard extends StatelessWidget {
//   final BookItem book;
//   final VoidCallback onToggleBook;
//   final VoidCallback onToggleExpand;
//   final void Function(ChapterItem) onToggleChapter;
//   final VoidCallback onChat;
//   final void Function(ChapterItem) onProcess;

//   const _BookCard({
//     super.key,
//     required this.book,
//     required this.onToggleBook,
//     required this.onToggleExpand,
//     required this.onToggleChapter,
//     required this.onChat,
//     required this.onProcess,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Each card listens to its own reactive fields (book.* Rx fields and chapter Rx fields)
//     return Obx(() {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(
//               color: book.selected.value
//                   ? AppColors.gradientMiddle
//                   : Colors.grey.shade300,
//               width: book.selected.value ? 2 : 1,
//             ),
//           ),
//           child: Column(
//             children: [
//               ListTile(
//                 leading: GestureDetector(
//                   onTap: onToggleBook,
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.green.shade50,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(
//                       Icons.menu_book_rounded,
//                       color: AppColors.gradientMiddle,
//                     ),
//                   ),
//                 ),
//                 title: Text(
//                   book.title,
//                   style: const TextStyle(fontWeight: FontWeight.w700),
//                 ),
//                 subtitle: Text(
//                   book.subtitle,
//                   style: const TextStyle(color: Colors.black54),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Checkbox(
//                       value: book.selected.value,
//                       onChanged: (_) => onToggleBook(),
//                       activeColor:
//                           AppColors.gradientMiddle, // fill color when checked
//                       checkColor: Colors.white,
//                     ),
//                     GestureDetector(
//                       onTap: onToggleExpand,
//                       child: Icon(
//                         book.expanded.value
//                             ? Icons.keyboard_arrow_down
//                             : Icons.keyboard_arrow_right,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Chapters (no internal scroll). Each chapter row uses Obx indirectly through the parent Obx
//               if (book.expanded.value)
//                 Column(
//                   children: book.chapters.map((c) {
//                     // we still use Obx inside each chapter if you prefer fine-grained rebuilds:
//                     return Obx(() {
//                       final isProcessed = c.processed.value;
//                       return InkWell(
//                         onTap: () => isProcessed ? onToggleChapter(c) : null,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 10,
//                           ),
//                           decoration: BoxDecoration(
//                             color: isProcessed
//                                 ? Colors.white
//                                 : const Color(
//                                     0xFFFFF4E6,
//                                   ), // light orange if not processed
//                             border: const Border(
//                               top: BorderSide(color: Color(0xFFF2F2F2)),
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               Checkbox(
//                                 value: c.selected.value,
//                                 onChanged: (_) =>
//                                     isProcessed ? onToggleChapter(c) : null,
//                                 activeColor: AppColors
//                                     .gradientMiddle, // fill color when checked
//                                 checkColor: Colors.white,
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       c.title,
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 6),
//                                     Text(
//                                       c.subtitle,
//                                       style: const TextStyle(
//                                         color: Colors.black54,
//                                         fontSize: 13,
//                                       ),
//                                     ),
//                                     if (c.hasPreviousChat.value)
//                                       const Padding(
//                                         padding: EdgeInsets.only(top: 4),
//                                         child: Text(
//                                           'Continue previous chat (5 messages)',
//                                           style: TextStyle(
//                                             color: AppColors.gradientMiddle,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               if (!isProcessed)
//                                 ElevatedButton(
//                                   onPressed: () => onProcess(c),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.orange,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(6),
//                                     ),
//                                   ),
//                                   child: const Text(
//                                     'Process',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 )
//                               else
//                                 IconButton(
//                                   onPressed: onChat,
//                                   icon: const Icon(
//                                     Icons.chat_bubble_outline,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       );
//                     });
//                   }).toList(),
//                 ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
