// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/chapterlist_controller.dart';
// import '../../../theme/design_system.dart';
// import '../../../widgets/custom_appbar.dart';

// class DeleteResourceDialog extends StatelessWidget {
//   final String resourceName;
//   final VoidCallback onDelete;

//   const DeleteResourceDialog({
//     super.key,
//     required this.resourceName,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     return Dialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       insetPadding: EdgeInsets.symmetric(
//         horizontal: width < 600 ? 24 : width * 0.3,
//         vertical: 24,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(
//               Icons.warning_amber_rounded,
//               color: Colors.redAccent,
//               size: 48,
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Delete Resource?',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               'Are you sure you want to delete "$resourceName"?',
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 15,
//                 color: Colors.black54,
//                 height: 1.4,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Cancel Button
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.grey.shade100,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 22,
//                       vertical: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 // Delete Button
//                 ElevatedButton(
//                   onPressed: () {
//                     onDelete();
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red.shade600,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 22,
//                       vertical: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Delete Resource',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EditResourceDialog extends StatelessWidget {
//   final TextEditingController titleController;
//   final TextEditingController descriptionController;
//   final TextEditingController categoryController;
//   final VoidCallback onSave;

//   const EditResourceDialog({
//     super.key,
//     required this.titleController,
//     required this.descriptionController,
//     required this.categoryController,
//     required this.onSave,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     return Dialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       insetPadding: EdgeInsets.symmetric(
//         horizontal: width < 600 ? 24 : width * 0.25,
//         vertical: 24,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header Row
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.edit_rounded,
//                         color: AppColors.textcolor,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Edit Resource',
//                         style: Theme.of(context).textTheme.titleMedium
//                             ?.copyWith(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 24,
//                             ),
//                       ),
//                     ],
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close_rounded),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // Resource Title
//               const Text('Resource Title', style: AppTextStyles.labelfield),
//               const SizedBox(height: 6),
//               TextField(
//                 controller: titleController,
//                 decoration: InputDecoration(
//                   hintText: 'Enter resource title',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: const BorderSide(
//                       color: AppColors.bluecolor,
//                       width: 1.5,
//                     ), // blue border on focus
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Description
//               const Text(
//                 'Description (Optional)',
//                 style: AppTextStyles.labelfield,
//               ),
//               const SizedBox(height: 6),
//               TextField(
//                 controller: descriptionController,
//                 maxLines: 3,
//                 decoration: InputDecoration(
//                   hintText: 'Enter description',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: const BorderSide(
//                       color: AppColors.bluecolor,
//                       width: 1.5,
//                     ), // blue border on focus
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Category
//               const Text('Category', style: AppTextStyles.labelfield),
//               const SizedBox(height: 6),
//               TextField(
//                 controller: categoryController,
//                 decoration: InputDecoration(
//                   hintText: 'Enter category',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: const BorderSide(
//                       color: AppColors.bluecolor,
//                       width: 1.5,
//                     ), // blue border on focus
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Action Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 12,
//                       ),
//                       foregroundColor: Colors.grey.shade100,
//                       backgroundColor: Colors.grey.shade100,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   ElevatedButton(
//                     onPressed: onSave,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.textcolor,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 22,
//                         vertical: 12,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       'Save Changes',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ChapterCard extends StatelessWidget {
//   final String title;
//   final String pages;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;
//   final VoidCallback onChat;
//   final VoidCallback onProcess;

//   const ChapterCard({
//     super.key,
//     required this.title,
//     required this.pages,
//     required this.onEdit,
//     required this.onDelete,
//     required this.onChat,
//     required this.onProcess,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     final double btnHeight = height * 0.042;
//     final double btnFontSize = width * 0.032;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: EdgeInsets.symmetric(
//         horizontal: width * 0.04,
//         vertical: width * 0.035,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.borderColor),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Top row: title + popup menu
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Title + pages expand to take available width
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         color: AppColors.textcolor,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       pages,
//                       style: const TextStyle(
//                         fontSize: 13.5,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Popup menu (Edit / Delete)
//               PopupMenuButton<String>(
//                 color: Colors.white,
//                 elevation: 6,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   side: BorderSide(color: Colors.grey.shade200),
//                 ),
//                 icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
//                 onSelected: (value) {
//                   if (value == 'edit') {
//                     onEdit();
//                   } else if (value == 'delete') {
//                     onDelete();
//                   }
//                 },
//                 itemBuilder: (context) => [
//                   PopupMenuItem(
//                     value: 'edit',
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.edit_rounded,
//                           color: AppColors.bluecolor,
//                           size: 20,
//                         ),
//                         const SizedBox(width: 8),
//                         const Text(
//                           'Edit',
//                           style: TextStyle(color: Colors.black87),
//                         ),
//                       ],
//                     ),
//                   ),
//                   PopupMenuItem(
//                     value: 'delete',
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.delete_rounded,
//                           color: Colors.red.shade600,
//                           size: 20,
//                         ),
//                         const SizedBox(width: 8),
//                         const Text(
//                           'Delete',
//                           style: TextStyle(color: Colors.black87),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           const SizedBox(height: 12),

//           // Divider (subtle)
//           Container(height: 1, color: Colors.grey.shade100),

//           const SizedBox(height: 12),

//           // Bottom row: two equal buttons (Chat, Process)
//           Row(
//             children: [
//               // Button 1 - Chat (filled blue)
//               Expanded(
//                 child: SizedBox(
//                   height: btnHeight,
//                   child: ElevatedButton.icon(
//                     onPressed: onChat,
//                     icon: Icon(
//                       Icons.chat_bubble_rounded,
//                       size: btnHeight * 0.5,
//                       color: Colors.white,
//                     ),
//                     label: Text(
//                       'Chat',
//                       style: TextStyle(
//                         fontSize: btnFontSize,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.bluecolor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       elevation: 0,
//                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     ),
//                   ),
//                 ),
//               ),

//               SizedBox(width: width * 0.03),

//               // Button 2 - Process (filled green)
//               Expanded(
//                 child: SizedBox(
//                   height: btnHeight,
//                   child: ElevatedButton.icon(
//                     onPressed: onProcess,
//                     icon: Icon(
//                       Icons.autorenew_rounded,
//                       size: btnHeight * 0.5,
//                       color: Colors.white,
//                     ),
//                     label: Text(
//                       'Process',
//                       style: TextStyle(
//                         fontSize: btnFontSize,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green.shade600,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       elevation: 0,
//                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PrimaryButton extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final Color bgColor;
//   final Color textColor;
//   final VoidCallback onTap;

//   const PrimaryButton({
//     super.key,
//     required this.label,
//     required this.icon,
//     required this.bgColor,
//     required this.textColor,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return ElevatedButton.icon(
//       onPressed: onTap,
//       icon: Icon(icon, size: 20, color: textColor),
//       label: Text(
//         label,
//         style: TextStyle(
//           fontSize: width * 0.038,
//           fontWeight: FontWeight.w600,
//           color: textColor,
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: bgColor,
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         elevation: 0,
//       ),
//     );
//   }
// }

// class ChapterListView extends StatelessWidget {
//   const ChapterListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ctrl = Get.put(ChapterListController());
//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9FAFB),
//       appBar: CustomAppBar(title: 'Mathematics Textbook', showSearch: false),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: width * 0.045, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Book Info Card
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: AppColors.borderColor, width: 1),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.03),
//                     blurRadius: 6,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 56,
//                     width: 56,
//                     decoration: BoxDecoration(
//                       color: AppColors.lightGreen,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Icon(
//                       Icons.menu_book_rounded,
//                       color: AppColors.greenColor,
//                       size: 30,
//                     ),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Mathematics Textbook',
//                           style: TextStyle(
//                             color: AppColors.textcolor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         const Text(
//                           'Class 12 NCERT',
//                           style: TextStyle(color: Colors.black54, fontSize: 13),
//                         ),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: const [
//                             Icon(
//                               Icons.insert_drive_file_rounded,
//                               color: Colors.grey,
//                               size: 14,
//                             ),
//                             SizedBox(width: 4),
//                             Text(
//                               '324 pages',
//                               style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             SizedBox(width: 8),
//                             Icon(Icons.circle, color: Colors.green, size: 6),
//                             SizedBox(width: 4),
//                             Text(
//                               'Processed',
//                               style: TextStyle(
//                                 color: Colors.green,
//                                 fontSize: 12.5,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 18),

//             // Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: PrimaryButton(
//                     label: 'Add New Chapter',
//                     icon: Icons.add_rounded,
//                     bgColor: AppColors.lightGreen,
//                     textColor: AppColors.textcolor,
//                     onTap: () => Get.toNamed('add-chapter'),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: PrimaryButton(
//                     label: 'Preview',
//                     icon: Icons.remove_red_eye_rounded,
//                     bgColor: Colors.white,
//                     textColor: AppColors.bluecolor,
//                     onTap: () => debugPrint('Preview'),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // Header Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Chapters (4)',
//                   style: TextStyle(
//                     fontSize: 15.5,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: ctrl.sortChapters,
//                   icon: const Icon(
//                     Icons.sort_rounded,
//                     color: Colors.black87,
//                     size: 22,
//                   ),
//                 ),
//               ],
//             ),

//             // Search Bar
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search books, authors, subjects...',
//                 prefixIcon: const Icon(
//                   Icons.search_rounded,
//                   color: Colors.grey,
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 0,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(
//                     color: AppColors.borderColor,
//                     width: 1,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(
//                     color: AppColors.borderColor,
//                     width: 1,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 18),

//             // Chapter List
//             // Replace the Expanded -> Obx -> ListView.builder block with this:
//             // --- replace the existing Expanded( child: Obx( () => ListView.builder(... ) ) ) block with this:
//             Expanded(
//               child: Obx(
//                 () => ListView.builder(
//                   itemCount: ctrl.chapters.length,
//                   padding: EdgeInsets.zero,
//                   itemBuilder: (context, index) {
//                     final ch = ctrl.chapters[index];

//                     return ChapterCard(
//                       title: ch['title'],
//                       pages: ch['pages'],
//                       // when user chooses "Edit" from popup menu
//                       onEdit: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return EditResourceDialog(
//                               titleController: TextEditingController(
//                                 text: ch['title'],
//                               ),
//                               descriptionController: TextEditingController(
//                                 text: ch['subtitle'] ?? '',
//                               ),
//                               categoryController: TextEditingController(
//                                 text: ch['category'] ?? '',
//                               ),
//                               onSave: () {
//                                 // TODO: call controller update method or modify the observable list
//                                 // Example: ctrl.updateChapter(index, updatedMap);
//                                 debugPrint('Saved changes for ${ch['title']}');
//                                 Navigator.pop(context);
//                               },
//                             );
//                           },
//                         );
//                       },
//                       // when user chooses "Delete" from popup menu
//                       onDelete: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return DeleteResourceDialog(
//                               resourceName: ch['title'],
//                               onDelete: () {
//                                 // safe remove from observable list
//                                 if (index >= 0 &&
//                                     index < ctrl.chapters.length) {
//                                   ctrl.chapters.removeAt(index);
//                                 }
//                                 debugPrint('Deleted ${ch['title']}');
//                               },
//                             );
//                           },
//                         );
//                       },
//                       // Chat button -> open chat screen
//                       onChat: () {
//                         Get.toNamed(
//                           '/chatscreen',
//                           arguments: {'contextFor': ch},
//                         );
//                       },
//                       // Process button -> trigger processing
//                       onProcess: () {
//                         // call controller/process function (implement in controller)
//                         // e.g. ctrl.processChapter(index);
//                         debugPrint('Process tapped for ${ch['title']}');
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/chapterlist_controller.dart';
import '../../../theme/design_system.dart';
import '../../../widgets/custom_appbar.dart';

class DeleteResourceDialog extends StatelessWidget {
  final String resourceName;
  final VoidCallback onDelete;

  const DeleteResourceDialog({
    super.key,
    required this.resourceName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.symmetric(
        horizontal: width < 600 ? 24 : width * 0.3,
        vertical: 24,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.redAccent,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Delete Resource?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Are you sure you want to delete "$resourceName"?',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cancel Button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Delete Button
                ElevatedButton(
                  onPressed: () {
                    onDelete();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Delete Resource',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// UPDATED DIALOG: now has only Title, Start Page, End Page
class EditResourceDialog extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController startPageController;
  final TextEditingController endPageController;
  final VoidCallback onSave;

  const EditResourceDialog({
    super.key,
    required this.titleController,
    required this.startPageController,
    required this.endPageController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 720;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.symmetric(
        horizontal: isWide ? width * 0.22 : 24,
        vertical: 24,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.edit_rounded,
                        color: AppColors.textcolor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Edit Resource',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Title
              const Text('Resource Title', style: AppTextStyles.labelfield),
              const SizedBox(height: 6),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter resource title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppColors.bluecolor,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Start & End page row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Start page',
                          style: AppTextStyles.labelfield,
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: startPageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'e.g. 1',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.bluecolor,
                                width: 1.5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('End page', style: AppTextStyles.labelfield),
                        const SizedBox(height: 6),
                        TextField(
                          controller: endPageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'e.g. 12',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.bluecolor,
                                width: 1.5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      foregroundColor: Colors.grey.shade100,
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      // basic validation: title non-empty and start/end numeric (optional)
                      final title = titleController.text.trim();
                      final start = startPageController.text.trim();
                      final end = endPageController.text.trim();

                      if (title.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Title cannot be empty'),
                          ),
                        );
                        return;
                      }

                      if (start.isNotEmpty && int.tryParse(start) == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Start page must be a number'),
                          ),
                        );
                        return;
                      }

                      if (end.isNotEmpty && int.tryParse(end) == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('End page must be a number'),
                          ),
                        );
                        return;
                      }

                      onSave();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textcolor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChapterCard extends StatelessWidget {
  final String title;
  final String pages;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onChat;
  final VoidCallback onProcess;

  const ChapterCard({
    super.key,
    required this.title,
    required this.pages,
    required this.onEdit,
    required this.onDelete,
    required this.onChat,
    required this.onProcess,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final double btnHeight = height * 0.042;
    final double btnFontSize = width * 0.032;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: width * 0.035,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: title + popup menu
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + pages expand to take available width
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textcolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      pages,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              // Popup menu (Edit / Delete)
              PopupMenuButton<String>(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
                onSelected: (value) {
                  if (value == 'edit') {
                    onEdit();
                  } else if (value == 'delete') {
                    onDelete();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_rounded,
                          color: AppColors.bluecolor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Edit',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_rounded,
                          color: Colors.red.shade600,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Delete',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Divider (subtle)
          Container(height: 1, color: Colors.grey.shade100),

          const SizedBox(height: 12),

          // Bottom row: two equal buttons (Chat, Process)
          Row(
            children: [
              // Button 1 - Chat (filled blue)
              Expanded(
                child: SizedBox(
                  height: btnHeight,
                  child: ElevatedButton.icon(
                    onPressed: onChat,
                    icon: Icon(
                      Icons.chat_bubble_rounded,
                      size: btnHeight * 0.5,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: btnFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bluecolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ),

              SizedBox(width: width * 0.03),

              // Button 2 - Process (filled green)
              Expanded(
                child: SizedBox(
                  height: btnHeight,
                  child: ElevatedButton.icon(
                    onPressed: onProcess,
                    icon: Icon(
                      Icons.autorenew_rounded,
                      size: btnHeight * 0.5,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Process',
                      style: TextStyle(
                        fontSize: btnFontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class PrimaryButton extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final Color bgColor;
//   final Color textColor;
//   final VoidCallback onTap;

//   const PrimaryButton({
//     super.key,
//     required this.label,
//     required this.icon,
//     required this.bgColor,
//     required this.textColor,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return ElevatedButton.icon(
//       onPressed: onTap,
//       icon: Icon(icon, size: 20, color: textColor),
//       label: Text(
//         label,
//         style: TextStyle(
//           fontSize: width * 0.038,
//           fontWeight: FontWeight.w600,
//           color: textColor,
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: bgColor,
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         elevation: 0,
//       ),
//     );
//   }
// }

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(
        icon,
        size: width * 0.045,
        color: textColor,
      ), // slightly smaller
      label: Text(
        label,
        style: TextStyle(
          fontSize: width < 600 ? 13 : 15, // ✅ smaller and responsive
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
    );
  }
}

class ChapterListView extends StatelessWidget {
  const ChapterListView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ChapterListController());
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Mathematics Textbook', showSearch: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.045, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: AppColors.greenColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mathematics Textbook',
                          style: TextStyle(
                            color: AppColors.textcolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Class 12 NCERT',
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: const [
                            Icon(
                              Icons.insert_drive_file_rounded,
                              color: Colors.grey,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '324 pages',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.circle, color: Colors.green, size: 6),
                            SizedBox(width: 4),
                            Text(
                              'Processed',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: 'New Chapter',
                    icon: Icons.add_rounded,
                    bgColor: AppColors.lightGreen,
                    textColor: AppColors.textcolor,
                    onTap: () => Get.toNamed('add-chapter'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    label: 'Preview',
                    icon: Icons.remove_red_eye_rounded,
                    bgColor: Colors.white,
                    textColor: AppColors.bluecolor,
                    onTap: () => debugPrint('Preview'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Chapters (4)',
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  onPressed: ctrl.sortChapters,
                  icon: const Icon(
                    Icons.sort_rounded,
                    color: Colors.black87,
                    size: 22,
                  ),
                ),
              ],
            ),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search books, authors, subjects...',
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Chapter List
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: ctrl.chapters.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final ch = ctrl.chapters[index];

                    // Prefill start/end from ch if provided, else empty
                    final startCtrl = TextEditingController(
                      text: ch['startPage']?.toString() ?? '',
                    );
                    final endCtrl = TextEditingController(
                      text: ch['endPage']?.toString() ?? '',
                    );

                    return ChapterCard(
                      title: ch['title'],
                      pages: ch['pages'],
                      // when user chooses "Edit" from popup menu
                      onEdit: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return EditResourceDialog(
                              titleController: TextEditingController(
                                text: ch['title'],
                              ),
                              startPageController: startCtrl,
                              endPageController: endCtrl,
                              onSave: () {
                                // Example: update observable list safely
                                final updated = Map<String, dynamic>.from(ch);
                                updated['title'] =
                                    titleControllerFromDialog(
                                      titleController: TextEditingController(
                                        text: ch['title'],
                                      ),
                                    ) ??
                                    ch['title'];
                                // parse pages if provided
                                final s = startCtrl.text.trim();
                                final e = endCtrl.text.trim();
                                if (s.isNotEmpty)
                                  updated['startPage'] = int.tryParse(s);
                                if (e.isNotEmpty)
                                  updated['endPage'] = int.tryParse(e);

                                // update controller list entry
                                if (index >= 0 &&
                                    index < ctrl.chapters.length) {
                                  ctrl.chapters[index] = updated;
                                }
                                debugPrint('Saved changes for ${ch['title']}');
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                      // when user chooses "Delete" from popup menu
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteResourceDialog(
                              resourceName: ch['title'],
                              onDelete: () {
                                if (index >= 0 &&
                                    index < ctrl.chapters.length) {
                                  ctrl.chapters.removeAt(index);
                                }
                                debugPrint('Deleted ${ch['title']}');
                              },
                            );
                          },
                        );
                      },
                      // Chat button -> open chat screen
                      onChat: () {
                        Get.toNamed(
                          '/chatscreen',
                          arguments: {'contextFor': ch},
                        );
                      },
                      // Process button -> trigger processing
                      onProcess: () {
                        debugPrint('Process tapped for ${ch['title']}');
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // small helper to get text from a controller (defensive)
  String? titleControllerFromDialog({
    required TextEditingController titleController,
  }) {
    final v = titleController.text.trim();
    return v.isEmpty ? null : v;
  }
}
