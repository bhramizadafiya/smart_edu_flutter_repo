import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  RxBool isTyping = false.obs;
  TextEditingController chatController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    messages.add({
      'isUser': false,
      'text':
          "Hello! I'm your AI tutor for Mathematics. How can I help you study today?",
      'time': '9:30 AM',
    });
  }

  void sendMessage() {
    final text = chatController.text.trim();
    if (text.isEmpty) return;

    messages.add({'isUser': true, 'text': text, 'time': '9:32 AM'});
    chatController.clear();

    // Simulate AI typing
    isTyping.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isTyping.value = false;
      messages.add({
        'isUser': false,
        'text':
            "Sure! Derivatives are a fundamental concept in calculus. They measure how a function changes as its input changes. Think of it as the 'rate of change' or slope at any point on a curve.",
        'time': '9:33 AM',
      });
    });
  }

  void showAttachmentMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAttachmentItem(Icons.camera_alt_rounded, 'Take Photo'),
                _buildAttachmentItem(
                  Icons.photo_library_rounded,
                  'Choose from Gallery',
                ),
                _buildAttachmentItem(
                  Icons.file_present_rounded,
                  'Upload Document',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttachmentItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3AAE86)),
      title: Text(label, style: const TextStyle(fontSize: 15)),
      onTap: () => Get.back(),
    );
  }
}
