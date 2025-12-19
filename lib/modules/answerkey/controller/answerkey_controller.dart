// answerkey_controller.dart
import 'dart:async'; // ← Added this
import 'package:docx_file_viewer/docx_file_viewer.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/answerkey/view/answerkey_view.dart';

class AnswerKeyController extends GetxController {
  final RxDouble downloadProgress = 0.0.obs;
  final RxBool isDownloading = false.obs;

  void downloadAnswerKey() {
    if (isDownloading.value) return;

    isDownloading.value = true;
    downloadProgress.value = 0.0;

    // Show the bottom modal (DownloadModal is in the view file)
    Get.bottomSheet(
      DownloadModal(),
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.3),
      backgroundColor: Colors.transparent,
    );

    // Simulate download progress
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (downloadProgress.value < 1.0) {
        if (downloadProgress.value >= 0.75) {
          downloadProgress.value += 0.005;
        } else {
          downloadProgress.value += 0.01;
        }
      } else {
        timer.cancel();
        isDownloading.value = false;
        Future.delayed(const Duration(seconds: 1), () {
          Get.back(); // Close modal
          Get.snackbar(
            'Success',
            'test_paper_bundle.zip downloaded successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        });
      }
    });
  }

  void cancelDownload() {
    isDownloading.value = false;
    downloadProgress.value = 0.0;
    Get.back(); // Close modal
    Get.snackbar(
      'Cancelled',
      'Download has been cancelled',
      backgroundColor: Colors.red.shade400,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}