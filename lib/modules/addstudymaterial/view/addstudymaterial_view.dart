// addstudymaterial_view.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
    final isMobile = width < 480;

    // Responsive values
    final horizontalPadding = isWide ? width * 0.14 : (isMobile ? 16.0 : 20.0);
    final dropZoneVerticalPadding = isMobile ? 16.0 : 22.0;
    final coverButtonIconSize = isMobile ? 28.0 : 34.0;
    final coverButtonFontSize = isMobile ? 13.5 : 14.5;

    // Open cover image picker bottom sheet
    void openCoverPicker(BuildContext context) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (_) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_rounded, color: Colors.green, size: 28),
                  title: const Text('Take Photo', style: TextStyle(fontSize: 16)),
                  onTap: () async {
                    await ctrl.pickCoverImage(ImageSource.camera);
                    Get.back();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_rounded, color: Colors.green, size: 28),
                  title: const Text('From Gallery', style: TextStyle(fontSize: 16)),
                  onTap: () async {
                    await ctrl.pickCoverImage(ImageSource.gallery);
                    Get.back();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.crop_square_rounded, color: Colors.grey, size: 28),
                  title: const Text('Default (No Image)', style: TextStyle(fontSize: 16)),
                  onTap: () {
                    ctrl.clearCoverImage();
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: CustomAppBar(title: 'Add Study Material', showSearch: false),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upload Files',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    const SizedBox(height: 12),

                    // Real File Picker Drop Zone
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: ctrl.pickFiles, // Real file picker
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: dropZoneVerticalPadding,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: isMobile ? 56 : 64,
                                width: isMobile ? 56 : 64,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFEFF7F2),
                                ),
                                child: Icon(
                                  Icons.cloud_upload_rounded,
                                  color: const Color(0xFF2EA673),
                                  size: isMobile ? 32 : 36,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tap to select files',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: isMobile ? 15 : 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Supported: PDF, DOC, DOCX, TXT',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: isMobile ? 13.5 : 14.5,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Maximum size: 50MB per file',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: isMobile ? 13.5 : 14.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey.shade400,
                                size: isMobile ? 20 : 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Uploaded Files List (Real Progress)
                    Obx(() {
                      if (ctrl.files.isEmpty) return const SizedBox.shrink();
                      return Column(
                        children: ctrl.files.asMap().entries.map((e) {
                          final idx = e.key;
                          final f = e.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 16 : 18,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.green.shade100),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        f.type == 'PDF'
                                            ? Icons.picture_as_pdf_rounded
                                            : Icons.description_rounded,
                                        color: AppColors.gradientMiddle,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            f.name,
                                            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
  children: [
    Text(
      '${f.type} • ${f.sizeMB.toStringAsFixed(1)} MB',
      style: TextStyle(color: Colors.black54, fontSize: isMobile ? 13 : 13.5),
    ),
    const SizedBox(width: 16),
    Expanded(
  child: Obx(() => Text(
        f.uploaded.value
            ? '100% uploaded'                          // When fully uploaded
            : '${(f.progress.value * 100).toInt()}% uploading', // During upload
        style: TextStyle(
          color: f.uploaded.value 
              ? Colors.green.shade700 
              : Colors.black54,
          fontSize: isMobile ? 13 : 13.5,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
      )),
),
  ],
),SizedBox(height: 12),
                                          Obx(() => LinearProgressIndicator(
                                                value: f.progress.value,
                                                minHeight: 7,
                                                borderRadius: BorderRadius.circular(4),
                                                backgroundColor: Colors.green.shade50,
                                                valueColor: AlwaysStoppedAnimation<Color>(
                                                  f.uploaded.value ? Colors.green.shade600 : Colors.green.shade400,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 28,
                                      padding: const EdgeInsets.all(8),
                                      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                                      icon: const Icon(Icons.close_rounded, color: Colors.redAccent),
                                      onPressed: () => ctrl.removeFile(idx),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),

                    const SizedBox(height: 32),

                    // Cover Image Section
                    const Text('Cover Image (Optional)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _CoverAction(
                            icon: Icons.camera_alt_rounded,
                            label: 'Take Photo',
                            onTap: () => openCoverPicker(context),
                            iconSize: coverButtonIconSize,
                            fontSize: coverButtonFontSize,
                          ),
                        ),
                        SizedBox(width: isMobile ? 10 : 14),
                        Expanded(
                          child: _CoverAction(
                            icon: Icons.photo_library_rounded,
                            label: 'From Gallery',
                            onTap: () => openCoverPicker(context),
                            iconSize: coverButtonIconSize,
                            fontSize: coverButtonFontSize,
                          ),
                        ),
                        SizedBox(width: isMobile ? 10 : 14),
                        Expanded(
                          child: _CoverAction(
                            icon: Icons.crop_square_rounded,
                            label: 'Default',
                            onTap: () => openCoverPicker(context),
                            iconSize: coverButtonIconSize,
                            fontSize: coverButtonFontSize,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Real Cover Image Preview
                    Obx(() {
                      final file = ctrl.coverImage.value;
                      return Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300, width: 1.5),
                          image: file != null
                              ? DecorationImage(
                                  image: FileImage(file),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: file == null
                            ? const Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.image_outlined, size: 36, color: Colors.grey),
                                    SizedBox(height: 8),
                                    Text(
                                      'No image\nselected',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black54, fontSize: 13),
                                    ),
                                  ],
                                ),
                              )
                            : null,
                      );
                    }),

                    const SizedBox(height: 32),

                    const Text('Basic Information', style: AppTextStyles.labelfield),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: ctrl.titleCtrl,
                      decoration: InputDecoration(
                        hintText: 'Enter Resource title',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.textcolor, width: 1.8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey, width: 0.8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    TextFormField(
                      controller: ctrl.descCtrl,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Brief description of the resource',
                        hintStyle: const TextStyle(color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.textcolor, width: 1.8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey, width: 0.8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => DropdownButtonFormField<String>(
                                value: ctrl.language.value,
                                isExpanded: true,
                                items: ctrl.languages.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                                onChanged: (v) => ctrl.language.value = v ?? 'English',
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: AppColors.textcolor, width: 1.8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey, width: 0.8),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Obx(() => DropdownButtonFormField<String>(
                                value: ctrl.category.value,
                                isExpanded: true,
                                items: ctrl.categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                                onChanged: (v) => ctrl.category.value = v ?? 'Textbook',
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: AppColors.textcolor, width: 1.8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.grey, width: 0.8),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Make your resource public', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5)),
                              SizedBox(height: 8),
                              Text('Allow other students to discover and access your resource', style: AppTextStyles.mainsubtitle),
                            ],
                          ),
                        ),
                        Obx(() => Switch(
                              value: ctrl.isPublic.value,
                              onChanged: (v) => ctrl.isPublic.value = v,
                              activeTrackColor: AppColors.gradientStart,
                              inactiveThumbColor: Colors.grey.shade300,
                              inactiveTrackColor: Colors.grey.shade200,
                            )),
                      ],
                    ),

                    const SizedBox(height: 28),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.blue.shade50),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Benefits of making public:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                          SizedBox(height: 12),
                          Text('• Help other students learn\n• Build your reputation in the community\n• Get feedback and discussions', style: TextStyle(color: Colors.black54, fontSize: 14)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 36),

                    Obx(() => SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed: (ctrl.saving.value || ctrl.uploading.value) ? null : ctrl.saveResource,
                            style: AppTextStyles.button.copyWith(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                            ),
                            child: ctrl.saving.value || ctrl.uploading.value
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                  )
                                : const Text('Upload Resource', style: AppTextStyles.userbuttontext),
                          ),
                        )),

                    const SizedBox(height: 50),
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

// Responsive Cover Action Button
class _CoverAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final double iconSize;
  final double fontSize;

  const _CoverAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconSize = 32.0,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300, width: 1.2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.gradientMiddle, size: iconSize),
              const SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: Colors.black87),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}