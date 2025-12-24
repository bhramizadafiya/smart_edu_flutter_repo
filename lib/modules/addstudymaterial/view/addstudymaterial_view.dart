// addstudymaterial_view.dart
import 'dart:io';
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
    final isMobile = width < 480;

    final horizontalPadding = isWide ? width * 0.14 : (isMobile ? 16.0 : 20.0);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Add Study Material', showSearch: false),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Upload Files', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
            const SizedBox(height: 12),

            // File Upload Zone
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: ctrl.pickFile,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: isMobile ? 20 : 28, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFEFF7F2)),
                        child: const Icon(Icons.cloud_upload_rounded, color: Color(0xFF2EA673), size: 34),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tap to upload file',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: isMobile ? 15.5 : 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Supported: PDF, DOC, DOCX, TXT • Max 50MB',
                              style: TextStyle(color: Colors.black54, fontSize: isMobile ? 13.5 : 14),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Uploaded Files List
            Obx(() {
              if (ctrl.files.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('No file selected', style: TextStyle(color: Colors.red, fontSize: 14)),
                );
              }
              return Column(
                children: ctrl.files.asMap().entries.map((entry) {
                  final index = entry.key;
                  final fileModel = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Container(
                      padding: const EdgeInsets.all(16),
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
                            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.insert_drive_file_rounded, color: AppColors.gradientMiddle, size: 30),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(fileModel.name,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text('${fileModel.type} • ${fileModel.sizeMB.toStringAsFixed(1)} MB',
                                        style: TextStyle(color: Colors.black54, fontSize: 13)),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Obx(() => Text(
                                            fileModel.uploaded.value ? 'Ready' : '${(fileModel.progress.value * 100).toInt()}% uploading',
                                            style: TextStyle(
                                                color: fileModel.uploaded.value ? Colors.green.shade700 : Colors.black54,
                                                fontSize: 13),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Obx(() => LinearProgressIndicator(
                                      value: fileModel.progress.value,
                                      minHeight: 7,
                                      backgroundColor: Colors.green.shade50,
                                      color: Colors.green.shade500,
                                    )),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded, color: Colors.redAccent),
                            onPressed: () => ctrl.removeFile(index),
                          ),
                        ],
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
                Expanded(child: _CoverAction(icon: Icons.camera_alt_rounded, label: 'Take Photo', onTap: () => ctrl.openCoverPicker(context))),
                const SizedBox(width: 12),
                Expanded(child: _CoverAction(icon: Icons.photo_library_rounded, label: 'From Gallery', onTap: () => ctrl.openCoverPicker(context))),
                const SizedBox(width: 12),
                Expanded(child: _CoverAction(icon: Icons.crop_square_rounded, label: 'Default', onTap: () => ctrl.openCoverPicker(context))),
              ],
            ),

            const SizedBox(height: 20),

            // Cover Image Preview
            Center(
              child: Obx(() => Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300, width: 1.8),
                      image: ctrl.coverImageFile.value != null
                          ? DecorationImage(
                              image: FileImage(ctrl.coverImageFile.value!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: ctrl.coverImageFile.value == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined, size: 48, color: Colors.grey),
                              SizedBox(height: 12),
                              Text('No image\nselected', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 14)),
                            ],
                          )
                        : null,
                  )),
            ),

            const SizedBox(height: 32),

            // Basic Information
            const Text('Basic Information', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
            const SizedBox(height: 12),

            TextFormField(
              controller: ctrl.titleCtrl,
              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              decoration: const InputDecoration(
                hintText: 'Enter Resource title',
                contentPadding: EdgeInsets.all(18),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: ctrl.descCtrl,
              maxLines: 5,
              onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              decoration: const InputDecoration(
                hintText: 'Brief description (optional)',
                contentPadding: EdgeInsets.all(18),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            ),

            const SizedBox(height: 28),

            // Public Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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

            // Benefits Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.blue.shade50),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Benefits of making public:', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  SizedBox(height: 12),
                  Text('• Help other students learn\n• Build your reputation in the community\n• Get feedback and discussions',
                      style: TextStyle(color: Colors.black54, fontSize: 14)),
                ],
              ),
            ),

            const SizedBox(height: 36),

            // Upload Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: ctrl.saving.value ? null : ctrl.saveResource,
                    style: AppTextStyles.button.copyWith(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                    ),
                    child: ctrl.saving.value
                        ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                        : const Text('Upload Resource', style: AppTextStyles.userbuttontext),
                  ),
                )),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _CoverAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CoverAction({required this.icon, required this.label, required this.onTap});

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
              Icon(icon, color: AppColors.gradientMiddle, size: 32),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
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