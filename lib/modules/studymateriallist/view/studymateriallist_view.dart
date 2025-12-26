// views/studymateriallist_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/studymateriallist_controller.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../theme/design_system.dart';

class DeleteResourceDialog extends StatefulWidget {
  final String resourceName;
  final String resourceId;
  final StudyMaterialListController controller;

  const DeleteResourceDialog({
    super.key,
    required this.resourceName,
    required this.resourceId,
    required this.controller,
  });

  @override
  State<DeleteResourceDialog> createState() => _DeleteResourceDialogState();
}

class _DeleteResourceDialogState extends State<DeleteResourceDialog> {
  var isDeleting = false.obs;

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
            const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 48),
            const SizedBox(height: 16),
            const Text('Delete Resource?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87)),
            const SizedBox(height: 12),
            Text(
              'Are you sure you want to delete "${widget.resourceName}"?\nThis action cannot be undone.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.4),
            ),
            const SizedBox(height: 24),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: isDeleting.value ? null : () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Cancel', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: isDeleting.value
                          ? null
                          : () async {
                              isDeleting.value = true;
                              await widget.controller.deleteResource(widget.resourceId);
                              isDeleting.value = false;
                              if (mounted) Navigator.pop(context);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: isDeleting.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : const Text('Delete Resource', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class EditResourceDialog extends StatefulWidget {
  final Map<String, dynamic> resourceData;
  final StudyMaterialListController controller;

  const EditResourceDialog({
    super.key,
    required this.resourceData,
    required this.controller,
  });

  @override
  State<EditResourceDialog> createState() => _EditResourceDialogState();
}

class _EditResourceDialogState extends State<EditResourceDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String selectedCategory;

  final List<String> categories = [
    'Textbook',
    'Notes',
    'Reference Material',
    'Question Bank',
  ];

  var isSaving = false.obs;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.resourceData['title']);
    descriptionController = TextEditingController(text: widget.resourceData['subtitle']);
    selectedCategory = widget.resourceData['subtitle'] == 'No category'
        ? categories.first
        : (categories.contains(widget.resourceData['subtitle'])
            ? widget.resourceData['subtitle']
            : categories.first);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.symmetric(
        horizontal: width < 600 ? 24 : width * 0.25,
        vertical: 24,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.edit_rounded, color: AppColors.textcolor),
                      const SizedBox(width: 8),
                      Text(
                        'Edit Resource',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
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
              const SizedBox(height: 20),

              const Text('Resource Title', style: AppTextStyles.labelfield),
              const SizedBox(height: 6),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter resource title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.bluecolor, width: 1.5)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              const SizedBox(height: 16),

              const Text('Description (Optional)', style: AppTextStyles.labelfield),
              const SizedBox(height: 6),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.bluecolor, width: 1.5)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              const SizedBox(height: 16),

              const Text('Category', style: AppTextStyles.labelfield),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: categories.contains(selectedCategory) ? selectedCategory : categories.first,
                items: categories.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => selectedCategory = val!),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.bluecolor, width: 1.5)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(width: 12),
                  Obx(() => ElevatedButton(
                        onPressed: isSaving.value
                            ? null
                            : () async {
                                if (titleController.text.trim().isEmpty) {
                                  Get.snackbar('Error', 'Please enter a resource title');
                                  return;
                                }

                                isSaving.value = true;
                                await widget.controller.updateResource(
                                  resourceId: widget.resourceData['id'],
                                  title: titleController.text.trim(),
                                  description: descriptionController.text.trim(),
                                  category: selectedCategory,
                                );
                                isSaving.value = false;
                                if (mounted) Navigator.pop(context);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.textcolor,
                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: isSaving.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : const Text('Save Changes', style: TextStyle(color: Colors.white)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudyMaterialListBlending {
  static Widget uploadCard({required BuildContext context, required VoidCallback onTap}) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: height * 0.028),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height * 0.065,
              width: height * 0.065,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [AppColors.gradientStart, AppColors.gradientMiddle, AppColors.gradientEnd], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: const Icon(Icons.cloud_upload_rounded, color: Colors.white, size: 26),
            ),
            SizedBox(height: height * 0.014),
            Text("Click to Add New Material", style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.w600, color: Colors.black87)),
            SizedBox(height: height * 0.006),
            Text("PDF, DOC, DOCX, TXT files\nMax size: 50MB", textAlign: TextAlign.center, style: TextStyle(fontSize: width * 0.031, color: Colors.black54, height: 1.3)),
          ],
        ),
      ),
    );
  }

  static Widget studyMaterialCard({
    required BuildContext context,
    required Map<String, dynamic> data,
    required StudyMaterialListController controller,
  }) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final double btnHeight = height * 0.038;
    final double btnFontSize = width * 0.028;

    final ButtonStyle outlineOrange = OutlinedButton.styleFrom(
      minimumSize: Size(0, btnHeight),
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide(color: AppColors.orangecolor, width: 1.2),
    );

    final ButtonStyle filledBlue = ElevatedButton.styleFrom(
      minimumSize: Size(0, btnHeight),
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide(color: AppColors.bluecolor, width: 1.2),
    );

    final ButtonStyle filledGreen = ElevatedButton.styleFrom(
      minimumSize: Size(0, btnHeight),
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      side: BorderSide(color: AppColors.textcolor, width: 1.2),
    );

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.018),
      padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.045),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 0.055,
                width: height * 0.055,
                decoration: BoxDecoration(color: const Color(0xFFE8F0FE), borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Text(data['icon'], style: TextStyle(fontSize: height * 0.028)),
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['title'], style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.w600, color: Colors.black)),
                    SizedBox(height: height * 0.004),
                    Text(data['subtitle'], style: TextStyle(fontSize: width * 0.033, color: Colors.black54)),
                    SizedBox(height: height * 0.008),
                    Row(
                      children: [
                        Icon(Icons.insert_drive_file_rounded, size: width * 0.035, color: Colors.grey.shade600),
                        SizedBox(width: 5),
                        Text(data['type'], style: TextStyle(fontSize: width * 0.032, color: Colors.black87)),
                      ],
                    ),
                    SizedBox(height: height * 0.008),
                    Row(
                      children: [
                        Container(height: 8, width: 8, decoration: BoxDecoration(color: Color(data['statusColor']), shape: BoxShape.circle)),
                        SizedBox(width: 5),
                        Text(data['status'], style: TextStyle(fontSize: width * 0.032, color: Color(data['statusColor']), fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Icon(Icons.access_time_rounded, size: width * 0.035, color: Colors.grey.shade600),
                        SizedBox(width: 3),
                        Text(data['time'], style: TextStyle(fontSize: width * 0.032, color: Colors.black45)),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
                icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
                onSelected: (value) {
                  if (value == 'edit') {
                    showDialog(
                      context: context,
                      builder: (_) => EditResourceDialog(
                        resourceData: data,
                        controller: controller,
                      ),
                    );
                  } else if (value == 'delete') {
                    showDialog(
                      context: context,
                      builder: (_) => DeleteResourceDialog(
                        resourceName: data['title'],
                        resourceId: data['id'],
                        controller: controller,
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit_rounded, color: AppColors.bluecolor, size: 20), SizedBox(width: 8), Text('Edit', style: TextStyle(color: Colors.black87))])),
                  const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete_rounded, color: Colors.redAccent, size: 20), SizedBox(width: 8), Text('Delete', style: TextStyle(color: Colors.black87))])),
                ],
              ),
            ],
          ),
          SizedBox(height: height * 0.012),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: btnHeight,
                  child: OutlinedButton.icon(
                    onPressed: () => Get.toNamed('/chapters-list'),
                    icon: Icon(Icons.add_rounded, size: btnHeight * 0.5, color: Colors.orange.shade700),
                    label: Text('Chapters', style: TextStyle(fontSize: btnFontSize, color: Colors.orange.shade700, fontWeight: FontWeight.w600)),
                    style: outlineOrange,
                  ),
                ),
              ),
              SizedBox(width: width * 0.03),
              Expanded(
                child: SizedBox(
                  height: btnHeight,
                  child: OutlinedButton.icon(
                    onPressed: () => Get.toNamed('/chatscreen'),
                    icon: Icon(Icons.chat_bubble_rounded, size: btnHeight * 0.5, color: AppColors.bluecolor),
                    label: Text('Chat', style: TextStyle(fontSize: btnFontSize, color: AppColors.bluecolor, fontWeight: FontWeight.w600)),
                    style: filledBlue,
                  ),
                ),
              ),
              SizedBox(width: width * 0.03),
              Expanded(
                child: SizedBox(
                  height: btnHeight,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.autorenew_rounded, size: btnHeight * 0.5, color: AppColors.textcolor),
                    label: Text('Process', style: TextStyle(fontSize: btnFontSize, color: AppColors.textcolor, fontWeight: FontWeight.w600)),
                    style: filledGreen,
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

class StudyMaterialListView extends GetView<StudyMaterialListController> {
  const StudyMaterialListView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "My Study Materials", showSearch: false),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload New Material", style: TextStyle(fontSize: width * 0.045, fontWeight: FontWeight.w600, color: AppColors.textcolor)),
              SizedBox(height: height * 0.012),
              StudyMaterialListBlending.uploadCard(context: context, onTap: controller.onUploadPressed),
              SizedBox(height: height * 0.022),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.onPreviewPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2979FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: height * 0.014),
                  ),
                  child: Text("Preview Book", style: TextStyle(fontSize: width * 0.038, color: Colors.white, fontWeight: FontWeight.w500)),
                ),
              ),
              SizedBox(height: height * 0.035),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Obx(() => Text(
      "Study Resources (${controller.filteredMaterials.length})",
      style: TextStyle(
        fontSize: width * 0.045,
        fontWeight: FontWeight.w600,
        color: AppColors.textcolor,
      ),
    )), SizedBox(
                    width: 100,
                    child: TextButton.icon(
                      onPressed: controller.onSortPressed,
                      icon: Icon(
                        controller.sortOrder.value == 'asc' ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                        size: 18,
                        color: Colors.black87,
                      ),
                      label: const Text("Sort", style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.015),

              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: TextField(
                        controller: controller.searchController,
                        onChanged: controller.onSearchChanged,
                        decoration: const InputDecoration(hintText: "Search books, authors, subjects...", border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    controller.searchQuery.value.isNotEmpty
                        ? GestureDetector(onTap: controller.clearSearch, child: const Icon(Icons.clear, color: Colors.grey))
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),

              Obx(() => controller.filteredMaterials.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.1),
                      child: Center(
                        child: Text(
                          controller.searchQuery.value.isEmpty ? "No study materials available." : "No results found for '${controller.searchQuery.value}'",
                          style: TextStyle(fontSize: width * 0.04, color: Colors.grey.shade600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Column(
                      children: controller.filteredMaterials
                          .map((item) => StudyMaterialListBlending.studyMaterialCard(
                                context: context,
                                data: item,
                                controller: controller,
                              ))
                          .toList(),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/studymateriallist_controller.dart';
// import '../../../widgets/custom_appbar.dart';
// import '../../../theme/design_system.dart';

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

// class EditResourceDialog extends StatefulWidget {
//   final Map<String, dynamic> resourceData;
//   final VoidCallback onSave;

//   const EditResourceDialog({
//     super.key,
//     required this.resourceData,
//     required this.onSave,
//   });

//   @override
//   State<EditResourceDialog> createState() => _EditResourceDialogState();
// }

// class _EditResourceDialogState extends State<EditResourceDialog> {
//   late TextEditingController titleController;
//   late TextEditingController descriptionController;
//   late String selectedCategory;

//   final categories = [
//     'Lecture Notes',
//     'Assignments',
//     'Reference',
//     'Syllabus',
//     'Other',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     titleController = TextEditingController(text: widget.resourceData['title']);
//     descriptionController = TextEditingController(text: widget.resourceData['subtitle']);
//     selectedCategory = widget.resourceData['type'].split(' • ').first;
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }

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
//                         style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 22,
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
//                     ),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

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
//                     ),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               const Text('Category', style: AppTextStyles.labelfield),
//               const SizedBox(height: 6),
//               DropdownButtonFormField<String>(
//                 value: categories.contains(selectedCategory) ? selectedCategory : categories.first,
//                 items: categories
//                     .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
//                     .toList(),
//                 onChanged: (val) {
//                   setState(() {
//                     selectedCategory = val!;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Select category',
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
//                     ),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 6,
//                     vertical: 4,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

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
//                       backgroundColor: Colors.grey.shade100,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   ElevatedButton(
//                     onPressed: () {
//                       widget.resourceData['title'] = titleController.text.trim();
//                       widget.resourceData['subtitle'] = descriptionController.text.trim();
//                       widget.resourceData['type'] = '$selectedCategory • ${widget.resourceData['type'].split(' • ').last}';

//                       widget.onSave();
//                       Navigator.pop(context);
//                     },
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

// class StudyMaterialListBlending {
//   static Widget uploadCard({
//     required BuildContext context,
//     required VoidCallback onTap,
//   }) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(vertical: height * 0.028),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.grey.shade300, width: 1),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.08),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: height * 0.065,
//               width: height * 0.065,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.gradientStart,
//                     AppColors.gradientMiddle,
//                     AppColors.gradientEnd,
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: const Icon(
//                 Icons.cloud_upload_rounded,
//                 color: Colors.white,
//                 size: 26,
//               ),
//             ),
//             SizedBox(height: height * 0.014),
//             Text(
//               "Click to Add New Material",
//               style: TextStyle(
//                 fontSize: width * 0.04,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: height * 0.006),
//             Text(
//               "PDF, DOC, DOCX, TXT files\nMax size: 50MB",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: width * 0.031,
//                 color: Colors.black54,
//                 height: 1.3,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   static Widget studyMaterialCard({
//     required BuildContext context,
//     required Map<String, dynamic> data,
//     required StudyMaterialListController controller,
//   }) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     final double btnHeight = height * 0.038;
//     final double btnFontSize = width * 0.028;

//     final ButtonStyle outlineOrange = OutlinedButton.styleFrom(
//       minimumSize: Size(0, btnHeight),
//       padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       side: BorderSide(color: AppColors.orangecolor, width: 1.2),
//       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//     );

//     final ButtonStyle filledBlue = ElevatedButton.styleFrom(
//       minimumSize: Size(0, btnHeight),
//       padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       side: BorderSide(color: AppColors.bluecolor, width: 1.2),
//       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//     );

//     final ButtonStyle filledGreen = ElevatedButton.styleFrom(
//       minimumSize: Size(0, btnHeight),
//       padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       side: BorderSide(color: AppColors.textcolor, width: 1.2),
//       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//     );

//     return Container(
//       margin: EdgeInsets.only(bottom: height * 0.018),
//       padding: EdgeInsets.symmetric(
//         vertical: height * 0.02,
//         horizontal: width * 0.045,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//         border: Border.all(color: Colors.grey.shade300, width: 1.0),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: height * 0.055,
//                 width: height * 0.055,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE8F0FE),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   data['icon'],
//                   style: TextStyle(fontSize: height * 0.028),
//                 ),
//               ),
//               SizedBox(width: width * 0.04),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       data['title'],
//                       style: TextStyle(
//                         fontSize: width * 0.04,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: height * 0.004),
//                     Text(
//                       data['subtitle'],
//                       style: TextStyle(
//                         fontSize: width * 0.033,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     SizedBox(height: height * 0.008),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.insert_drive_file_rounded,
//                           size: width * 0.035,
//                           color: Colors.grey.shade600,
//                         ),
//                         SizedBox(width: 5),
//                         Text(
//                           data['type'],
//                           style: TextStyle(
//                             fontSize: width * 0.032,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: height * 0.008),
//                     Row(
//                       children: [
//                         Container(
//                           height: 8,
//                           width: 8,
//                           decoration: BoxDecoration(
//                             color: Color(data['statusColor']),
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         SizedBox(width: 5),
//                         Text(
//                           data['status'],
//                           style: TextStyle(
//                             fontSize: width * 0.032,
//                             color: Color(data['statusColor']),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const Spacer(),
//                         Icon(
//                           Icons.access_time_rounded,
//                           size: width * 0.035,
//                           color: Colors.grey.shade600,
//                         ),
//                         SizedBox(width: 3),
//                         Text(
//                           data['time'],
//                           style: TextStyle(
//                             fontSize: width * 0.032,
//                             color: Colors.black45,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               PopupMenuButton<String>(
//                 color: Colors.white,
//                 elevation: 6,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   side: BorderSide(color: Colors.grey.shade200),
//                 ),
//                 icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
//                 onSelected: (value) {
//                   if (value == 'edit') {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return EditResourceDialog(
//                           resourceData: data,
//                           onSave: () {
//                             controller.applyFilterAndSort();
//                           },
//                         );
//                       },
//                     );
//                   } else if (value == 'delete') {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return DeleteResourceDialog(
//                           resourceName: data['title'],
//                           onDelete: () {
//                             controller.studyMaterials.remove(data);
//                             controller.applyFilterAndSort();
//                           },
//                         );
//                       },
//                     );
//                   }
//                 },
//                 itemBuilder: (context) => [
//                   const PopupMenuItem(
//                     value: 'edit',
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.edit_rounded,
//                           color: AppColors.bluecolor,
//                           size: 20,
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           'Edit',
//                           style: TextStyle(color: Colors.black87),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const PopupMenuItem(
//                     value: 'delete',
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.delete_rounded,
//                           color: Colors.redAccent,
//                           size: 20,
//                         ),
//                         SizedBox(width: 8),
//                         Text(
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
//           SizedBox(height: height * 0.012),
//           Row(
//             children: [
//               Expanded(
//                 child: SizedBox(
//                   height: btnHeight,
//                   child: OutlinedButton.icon(
//                     onPressed: () => Get.toNamed('/chapters-list'),
//                     icon: Icon(
//                       Icons.add_rounded,
//                       size: btnHeight * 0.5,
//                       color: Colors.orange.shade700,
//                     ),
//                     label: Text(
//                       'Chapters',
//                       style: TextStyle(
//                         fontSize: btnFontSize,
//                         color: Colors.orange.shade700,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     style: outlineOrange,
//                   ),
//                 ),
//               ),
//               SizedBox(width: width * 0.03),
//               Expanded(
//                 child: SizedBox(
//                   height: btnHeight,
//                   child: OutlinedButton.icon(
//                     onPressed: () => Get.toNamed('/chatscreen'),
//                     icon: Icon(
//                       Icons.chat_bubble_rounded,
//                       size: btnHeight * 0.5,
//                       color: AppColors.bluecolor,
//                     ),
//                     label: Text(
//                       'Chat',
//                       style: TextStyle(
//                         fontSize: btnFontSize,
//                         color: AppColors.bluecolor,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     style: filledBlue,
//                   ),
//                 ),
//               ),
//               SizedBox(width: width * 0.03),
//               Expanded(
//                 child: SizedBox(
//                   height: btnHeight,
//                   child: OutlinedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.autorenew_rounded,
//                       size: btnHeight * 0.5,
//                       color: AppColors.textcolor,
//                     ),
//                     label: Text(
//                       'Process',
//                       style: TextStyle(
//                         fontSize: btnFontSize,
//                         color: AppColors.textcolor,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     style: filledGreen,
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

// class StudyMaterialListView extends GetView<StudyMaterialListController> {
//   const StudyMaterialListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(title: "My Study Materials", showSearch: false),
//       body: GestureDetector(
//         onTap: () {
//           // This dismisses the keyboard when tapping anywhere outside
//           FocusScope.of(context).unfocus();
//         },
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//             horizontal: width * 0.06,
//             vertical: height * 0.02,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Upload New Material",
//                 style: TextStyle(
//                   fontSize: width * 0.045,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textcolor,
//                 ),
//               ),
//               SizedBox(height: height * 0.012),

//               StudyMaterialListBlending.uploadCard(
//                 context: context,
//                 onTap: controller.onUploadPressed,
//               ),

//               SizedBox(height: height * 0.022),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: controller.onPreviewPressed,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF2979FF),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     elevation: 0,
//                     padding: EdgeInsets.symmetric(vertical: height * 0.014),
//                   ),
//                   child: Text(
//                     "Preview Book",
//                     style: TextStyle(
//                       fontSize: width * 0.038,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),

//               SizedBox(height: height * 0.035),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Study Resources (${controller.filteredMaterials.length})",
//                     style: TextStyle(
//                       fontSize: width * 0.045,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textcolor,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 100, // Prevents overflow
//                     child: Obx(() => TextButton.icon(
//                           onPressed: controller.onSortPressed,
//                           icon: Icon(
//                             controller.sortAscending.value == true
//                                 ? Icons.arrow_upward_rounded
//                                 : Icons.arrow_downward_rounded,
//                             size: 18,
//                             color: Colors.black87,
//                           ),
//                           label: const Text(
//                             "Sort",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.black87,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           style: TextButton.styleFrom(
//                             foregroundColor: Colors.black87,
//                             padding: EdgeInsets.zero,
//                             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                           ),
//                         )),
//                   ),
//                 ],
//               ),
//               SizedBox(height: height * 0.015),

//               // Search Bar
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: width * 0.04),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.search, color: Colors.grey),
//                     SizedBox(width: width * 0.03),
//                     Expanded(
//                       child: TextField(
//                         controller: controller.searchController,
//                         onChanged: controller.onSearchChanged,
//                         decoration: const InputDecoration(
//                           hintText: "Search books, authors, subjects...",
//                           border: InputBorder.none,
//                           hintStyle: TextStyle(color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                     Obx(() => controller.searchQuery.value.isNotEmpty
//                         ? GestureDetector(
//                             onTap: () {
//                               controller.clearSearch();
//                               FocusScope.of(context).unfocus();
//                             },
//                             child: const Icon(Icons.clear, color: Colors.grey),
//                           )
//                         : const SizedBox.shrink()),
//                   ],
//                 ),
//               ),
//               SizedBox(height: height * 0.02),

//               // Resource list
//               Obx(() => controller.filteredMaterials.isEmpty
//                   ? Padding(
//                       padding: EdgeInsets.symmetric(vertical: height * 0.1),
//                       child: Center(
//                         child: Text(
//                           controller.searchQuery.value.isEmpty
//                               ? "No study materials available."
//                               : "No results found for '${controller.searchQuery.value}'",
//                           style: TextStyle(fontSize: width * 0.04, color: Colors.grey.shade600),
//                         ),
//                       ),
//                     )
//                   : Column(
//                       children: controller.filteredMaterials
//                           .map((item) => StudyMaterialListBlending.studyMaterialCard(
//                                 context: context,
//                                 data: item,
//                                 controller: controller,
//                               ))
//                           .toList(),
//                     )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }