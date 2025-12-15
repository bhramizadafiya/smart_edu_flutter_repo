// addchapter_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/addstudymaterial_controller.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../theme/design_system.dart';

class AddStudyMaterialView extends StatelessWidget {
  const AddStudyMaterialView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AddStudyMaterialController());
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 720;
    final horizontalPadding = isWide ? width * 0.14 : 16.0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: CustomAppBar(title: 'Add Study Material', showSearch: false),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 14,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    const Text(
                      'Upload Files',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Drop area (mock) + Add file buttons
                    GestureDetector(
                      onTap: () => ctrl.addMockFile(
                        name: 'calculus_textbook.pdf',
                        type: 'PDF',
                        sizeMB: 15.2,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFEFF7F2),
                              ),
                              child: const Icon(
                                Icons.cloud_upload_rounded,
                                color: Color(0xFF2EA673),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Drop your file here or browse',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Supported: PDF, DOC, DOCX, TXT',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Maximum size: 50MB',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Files list (if any)
                    Obx(() {
                      if (ctrl.files.isEmpty) return const SizedBox.shrink();
                      return Column(
                        children: ctrl.files.asMap().entries.map((e) {
                          final idx = e.key;
                          final f = e.value;
                          return Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.green.shade100),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 44,
                                  width: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.insert_drive_file_rounded,
                                    color: AppColors.gradientMiddle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        f.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            '${f.type} • ${f.sizeMB.toStringAsFixed(1)} MB',
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Obx(
                                            () => Text(
                                              f.uploaded.value
                                                  ? '100% uploaded'
                                                  : '${(f.progress.value * 100).toInt()}% uploading',
                                              style: TextStyle(
                                                color: f.uploaded.value
                                                    ? Colors.green
                                                    : Colors.black54,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Obx(() {
                                        return LinearProgressIndicator(
                                          value: f.progress.value,
                                          backgroundColor: Colors.green.shade50,
                                          color: f.uploaded.value
                                              ? Colors.green
                                              : Colors.green.shade400,
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                IconButton(
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () => ctrl.removeFile(idx),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }),

                    const SizedBox(height: 18),

                    // Cover Image
                    const Text(
                      'Cover Image (Optional)',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _CoverAction(
                          icon: Icons.camera_alt_rounded,
                          label: 'Take Photo',
                          onTap: () => ctrl.openCoverPicker(context),
                        ),
                        const SizedBox(width: 10),
                        _CoverAction(
                          icon: Icons.photo_library_rounded,
                          label: 'From Gallery',
                          onTap: () => ctrl.openCoverPicker(context),
                        ),
                        const SizedBox(width: 10),
                        _CoverAction(
                          icon: Icons.crop_square_rounded,
                          label: 'Default',
                          onTap: () => ctrl.openCoverPicker(context),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Obx(() {
                      final path = ctrl.coverImagePath.value;
                      return Container(
                        height: 84,
                        width: 84,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: path == null
                            ? const Center(
                                child: Text(
                                  'No image\nselected',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black54),
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Image',
                                  style: TextStyle(
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ),
                      );
                    }),

                    const SizedBox(height: 18),

                    // Basic Information heading
                    const Text(
                      'Basic Information',
                      style: AppTextStyles.labelfield,
                    ),
                    const SizedBox(height: 10),

                    // Title field
                    TextFormField(
                      controller: ctrl.titleCtrl,

                      decoration: InputDecoration(
                        hintText: 'Enter Resource title',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.textcolor,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Description field
                    TextFormField(
                      controller: ctrl.descCtrl,
                      maxLines: 3,

                      decoration: InputDecoration(
                        hintText: 'Brief description of the book content',
                        hintStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.textcolor,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Language & Category row
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() {
                            return DropdownButtonFormField<String>(
                              value: ctrl.language.value,
                              isExpanded: true,
                              isDense: true,
                              items: ctrl.languages
                                  .map(
                                    (l) => DropdownMenuItem(
                                      value: l,
                                      child: Text(l),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) => ctrl.language.value =
                                  v ?? ctrl.language.value,

                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.textcolor,
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Obx(() {
                            return DropdownButtonFormField<String>(
                              value: ctrl.category.value,
                              isExpanded: true,
                              isDense: true,
                              items: ctrl.categories
                                  .map(
                                    (c) => DropdownMenuItem(
                                      value: c,
                                      child: Text(c),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) => ctrl.category.value =
                                  v ?? ctrl.category.value,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.textcolor,
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Privacy settings
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Make your resource public',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Allow other students to discover and access your resource',
                                style: AppTextStyles.mainsubtitle,
                              ),
                            ],
                          ),
                        ),

                        // Obx(
                        //   () => Switch(
                        //     value: ctrl.isPublic.value,
                        //     onChanged: (v) => ctrl.isPublic.value = v,
                        //   ),
                        // ),
                        Obx(
                          () => Switch(
                            value: ctrl.isPublic.value,
                            onChanged: (v) => ctrl.isPublic.value = v,
                            activeTrackColor:
                                AppColors.gradientStart, // track color when ON
                            inactiveThumbColor:
                                Colors.grey.shade300, // thumb color when OFF
                            inactiveTrackColor:
                                Colors.grey.shade200, // track color when OFF
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Bottom note card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue.shade50),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Benefits of making public:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '• Help other students learn\n• Build your reputation in the community\n• Get feedback and discussions',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // -------------------------------
                    // Upload Resource button (last item - submit)
                    // -------------------------------
                    Obx(() {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: ctrl.saving.value
                              ? null
                              : ctrl.saveResource,
                          style: AppTextStyles.button,
                          child: ctrl.saving.value
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Upload Resource',
                                  style: AppTextStyles.userbuttontext,
                                ),
                        ),
                      );
                    }),

                    const SizedBox(
                      height: 32,
                    ), // bottom spacing so last element isn't glued to bottom
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CoverAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _CoverAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 96,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.gradientMiddle, size: 26),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
