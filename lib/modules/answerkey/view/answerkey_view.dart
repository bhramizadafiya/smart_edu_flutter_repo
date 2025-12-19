// answerkey_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/answerkey/controller/answerkey_controller.dart';
import 'package:smarted/theme/design_system.dart';


class AnswerKeyView extends GetView<AnswerKeyController> {
  const AnswerKeyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: const Color(0xFFE8F5E9), // Light green background
  foregroundColor: Colors.transparent, // To allow custom colors
  elevation: 0,
  leading: IconButton(
    icon: Icon(
      Icons.key,
      color: AppColors.greenbutton, // Your dark green
      size: 28,
    ),
    onPressed: () => Get.back(),
  ),
  title: const Text(
    'Answer Key',
    style: TextStyle(
      color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  centerTitle: false,
  actions: [
    // Download Button
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: OutlinedButton.icon(
        onPressed: controller.downloadAnswerKey,
        icon: Icon(
          Icons.download,
          color: AppColors.greenbutton,
          size: 20,
        ),
        label: Text(
          'Download',
          style: TextStyle(
            color: AppColors.greenbutton,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.greenbutton, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          backgroundColor: Colors.transparent,
        ),
      ),
    ),

    // Close Button
    IconButton(
      icon: Icon(
        Icons.close,
        color: Colors.grey.shade600,
        size: 28,
      ),
      onPressed: () => Get.back(),
    ),
    const SizedBox(width: 8),
  ],
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(1.0),
    child: Container(
      color: AppColors.greenbutton, // Dark green bottom line
      height: 1.5,
    ),
  ),
),
      body: Column(
        children: [
        


          // Main Content Area (You can load PDF, list of answers, etc.)
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'Answer key content will appear here.\n\nYou can display MCQ answers, explanations, or load a PDF.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/// ==================== Download Modal Widget (Compact Version) ====================
// ==================== Download Modal Widget (File Name Close to Left Edge) ====================
class DownloadModal extends GetView<AnswerKeyController> {
  const DownloadModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Compact White Card
        Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Smaller Download Icon
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.download,
                  color: AppColors.greenbutton,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                'Downloading...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greenbutton,
                ),
              ),
              const SizedBox(height: 16),

              // Progress Bar
              Obx(() => LinearProgressIndicator(
                    value: controller.downloadProgress.value,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(AppColors.greenbutton),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(4),
                  )),
              const SizedBox(height: 12),

              // File Name - Very close to left edge
              const Padding(
                padding: EdgeInsets.only(left: 4), // Minimal left padding - close to card edge
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'test_paper_bundle.zip',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 8), // Keeps spacing as before

              // Progress Percentage (centered)
              Obx(() => Text(
                    '${(controller.downloadProgress.value * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.greenbutton,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              const SizedBox(height: 4),

              // Size Info (centered)
              Obx(() => Text(
                    '${(8.9 * controller.downloadProgress.value).toStringAsFixed(1)} MB of 8.9 MB',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  )),
              
            ],
          ),
        ),

        // Cancel Button - Outside the card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.cancelDownload,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}