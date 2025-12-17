import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/widgets/custom_appbar.dart';
import '../controller/addchapter_controller.dart';
import '../../../theme/design_system.dart';

class AddChapterView extends StatelessWidget {
  const AddChapterView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AddChapterController());
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 700;
    final horizontalPadding = isWide ? width * 0.12 : width * 0.045;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: CustomAppBar(title: 'Add Chapter', showSearch: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Info Card (unchanged)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor, width: 1),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 3)),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(color: AppColors.lightGreen, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.menu_book_rounded, color: AppColors.greenColor, size: 30),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Mathematics Textbook',
                              style: TextStyle(color: AppColors.textcolor, fontWeight: FontWeight.w600, fontSize: 16)),
                          SizedBox(height: 4),
                          Text('Class 12 NCERT', style: TextStyle(color: Colors.black54, fontSize: 13)),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.insert_drive_file_rounded, color: Colors.grey, size: 14),
                              SizedBox(width: 6),
                              Text('324 pages', style: TextStyle(color: Colors.black54, fontSize: 12)),
                              SizedBox(width: 12),
                              Icon(Icons.circle, color: Colors.green, size: 6),
                              SizedBox(width: 6),
                              Text('Processed', style: TextStyle(color: Colors.green, fontSize: 12.5)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.remove_red_eye_rounded),
                label: const Text('Preview Resource'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.borderColor),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  foregroundColor: AppColors.bluecolor,
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),

              const SizedBox(height: 22),

              Text('Create New Chapter',
                  style: TextStyle(fontSize: isWide ? 18 : 16, fontWeight: FontWeight.w600, color: AppColors.textcolor)),

              const SizedBox(height: 12),

              Form(
                key: ctrl.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: ctrl.chapterNameCtrl,
                      validator: ctrl.validateName,
                      decoration: InputDecoration(
                        hintText: 'Enter chapter name',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.borderColor)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.borderColor)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.greenColor, width: 2)),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Page fields with HINTS only
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ctrl.startPageCtrl,
                            keyboardType: TextInputType.number,
                            validator: ctrl.validatePage,
                            decoration: InputDecoration(
                              labelText: 'Start Page',
                              hintText: 'e.g. 1',  // ← Hint visible when empty
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.borderColor)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.borderColor)),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.greenColor, width: 2)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: ctrl.endPageCtrl,
                            keyboardType: TextInputType.number,
                            validator: ctrl.validatePage,
                            decoration: InputDecoration(
                              labelText: 'End Page',
                              hintText: 'e.g. 25',  // ← Hint visible when empty
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.borderColor)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.borderColor)),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.greenColor, width: 2)),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey.shade100,
                              foregroundColor: Colors.black87,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Obx(() => ElevatedButton(
                                onPressed: ctrl.saving.value ? null : ctrl.saveChapter,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.greenColor,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                child: ctrl.saving.value
                                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                    : const Text('Save Chapter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}