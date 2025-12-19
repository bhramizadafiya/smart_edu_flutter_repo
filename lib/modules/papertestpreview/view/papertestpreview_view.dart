// papertestpreview_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/papertestpreview/controller/papertestpreview_controller.dart';
import 'package:smarted/modules/onpapertest/controller/onpapertest_controller.dart';
import 'package:smarted/theme/design_system.dart';

class PaperTestPreviewView extends GetView<PaperTestPreviewController> {
  const PaperTestPreviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onPaperTestController = Get.find<OnTestPaperController>();

    // Detect screen size for responsive adjustments
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 380; // Common small phones

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenbutton,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Test Paper Preview',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        centerTitle: onPaperTestController.includeAnswerKey.value ? false : true,
        titleSpacing: onPaperTestController.includeAnswerKey.value ? 0 : 16,
        actions: [
         // In papertestpreview_view.dart - inside actions
Obx(() {
  if (!onPaperTestController.includeAnswerKey.value) {
    return const SizedBox(width: 48);
  }

  return Padding(
    padding: const EdgeInsets.only(right: 0),
    child: TextButton.icon(
      onPressed: controller.toggleAnswerKey, // Now opens AnswerKeyView
      icon: const Icon(
        Icons.key,
        size: 16,
        color: AppColors.greenbutton,
      ),
      label: const Text(
        'Answer Key',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.greenbutton,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 222, 233, 229),
        foregroundColor: AppColors.greenbutton,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        minimumSize: const Size(80, 32),
      ),
    ),
  );
}),
          IconButton(
            icon: const Icon(Icons.download, size: 24),
            tooltip: 'Download',
            onPressed: controller.downloadTest,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 6),
        ],
      ),

      body: Column(
        children: [
          // Main Mock Test Section - Fixed Overflow
         Container(
  width: double.infinity,
  padding: EdgeInsets.fromLTRB(
    isSmallScreen ? 12 : 16,
    20,
    isSmallScreen ? 12 : 16,
    20,
  ),
  decoration: const BoxDecoration(
    color: Color.fromARGB(255, 246, 255, 252), // ← Background color moved here
    border: Border(
      bottom: BorderSide(
        color: AppColors.greenbutton, // Your dark green
        width: 1.5,
      ),
    ),
  ),
  child: Column(
    children: [
      // === Your existing content (unchanged) ===
      Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(
                  Icons.description,
                  color: AppColors.greenbutton,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Obx(() => Text(
                        controller.subjectName.value.isEmpty
                            ? 'Mock Test'
                            : '${controller.subjectName.value} Mock Test',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greenbutton,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )),
                ),
              ],
            ),
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: controller.decreaseProgress,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color.fromARGB(255, 216, 216, 216), width: 1.5),
                  ),
                  child: const Icon(Icons.zoom_out, color: Colors.grey, size: 25),
                ),
              ),
              SizedBox(width: isSmallScreen ? 4 : 8),
              Obx(() => Text(
                    '${controller.progress.value.toInt()}%',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greenbutton,
                    ),
                  )),
              SizedBox(width: isSmallScreen ? 4 : 8),
              GestureDetector(
                onTap: controller.increaseProgress,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color.fromARGB(255, 216, 216, 216), width: 1.5),
                  ),
                  child: const Icon(Icons.zoom_in, color: Colors.grey, size:25),
                ),
              ),
            ],
          ),
        ],
      ),

      const SizedBox(height: 24),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            onPressed: controller.previousPage,
            icon: const Icon(Icons.chevron_left, color: Colors.black54, size: 20),
            label: const Text(
              'Previous',
              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
            ),
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 246, 255, 252),
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 20,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: Color.fromARGB(255, 208, 208, 208), width: 1.3),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Obx(() => Text(
                'Page ${controller.currentPage.value} of 6',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greenbutton,
                ),
              )),

          const SizedBox(width: 12),

          TextButton(
            onPressed: controller.nextPage,
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 246, 255, 252),
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 20,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: Color.fromARGB(255, 208, 208, 208), width: 1.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Next',
                  style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 6),
                Icon(Icons.chevron_right, color: Colors.black54, size: 20),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
),

          // Preview Area
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: const Center(
                child: Text(
                  'Preview will appear here after generation',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}