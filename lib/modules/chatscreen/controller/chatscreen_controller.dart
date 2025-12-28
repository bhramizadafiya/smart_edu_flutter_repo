// controllers/chatscreen_controller.dart
// (or your exact path: lib/modules/chatscreen/controller/chatscreen_controller.dart)

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/chatscreen/view/chatscreen_view.dart';
import 'package:smarted/utils/api_endpoints.dart';

class ChatScreenController extends GetxController {
  final dio.Dio _dio = dio.Dio();

  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  RxBool isTyping = false.obs;
  TextEditingController chatController = TextEditingController();

  late String resourceId;
  late String resourceTitle;

  final String userId = 'ybai_users_sav3bsx1m7';
  final String authToken = '19jnUAD7PlsPXatEukd5tEnCjsfCc3tvpBnejsqc';

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    resourceId = args?['resource_id'] ?? '';
    resourceTitle = args?['resource_title'] ?? 'Study Material';

    if (resourceId.isEmpty) {
      Get.snackbar('Error', 'Invalid resource. Cannot start chat.');
      Get.back();
      return;
    }

    messages.add({
      'isUser': false,
      'text': "Hello! I'm your AI tutor for **$resourceTitle**.\n\nHow can I help you study today?",
      'time': _getCurrentTime(),
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  /// Parse response - supports Markdown + HTML <img> tags for figures/diagrams/tables
  List<Widget> parseApiResponse(String markdownText) {
    final List<Widget> widgets = [];
    final lines = markdownText.split('\n');
    bool inCodeBlock = false;
    List<String> codeLines = [];

    for (var line in lines) {
      final trimmed = line.trim();
      final rawLine = line;

      // Handle code blocks ```
      if (trimmed.startsWith('```')) {
        if (inCodeBlock) {
          widgets.add(CodeBlockWithCopy(code: codeLines.join('\n')));
          codeLines.clear();
          inCodeBlock = false;
        } else {
          inCodeBlock = true;
        }
        continue;
      }

      if (inCodeBlock) {
        codeLines.add(line);
        continue;
      }

      // HTML <img> tag - this catches all your figures, tables, diagrams
      final htmlImgRegex = RegExp(
        r"""<img[^>]*src=["']([^"']+)["'][^>]*>""",
        caseSensitive: false,
      );
      final htmlMatch = htmlImgRegex.firstMatch(line);
      if (htmlMatch != null) {
        final url = htmlMatch.group(1)!;
        widgets.add(_buildNetworkImage(url));
        continue;
      }

      // Markdown image as backup
      final mdImgRegex = RegExp(r'!\[([^\]]*)\]\((https?://[^\s)]+)\)');
      final mdMatch = mdImgRegex.firstMatch(trimmed);
      if (mdMatch != null) {
        final url = mdMatch.group(2)!;
        widgets.add(_buildNetworkImage(url));
        continue;
      }

      if (trimmed.isEmpty) {
        widgets.add(const SizedBox(height: 14));
        continue;
      }

      // Headings
      if (trimmed.startsWith('# ')) {
        widgets.add(Text(trimmed.substring(2),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.3)));
      } else if (trimmed.startsWith('## ')) {
        widgets.add(Text(trimmed.substring(3),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.4)));
      } else if (trimmed.startsWith('### ')) {
        widgets.add(Text(trimmed.substring(4),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)));
      }
      // Bullet points
      else if (trimmed.startsWith('- ') || trimmed.startsWith('• ')) {
        final text = trimmed.substring(trimmed.startsWith('- ') ? 2 : 2);
        final indentLevel = (rawLine.length - rawLine.trimLeft().length) ~/ 2;
        final leftPadding = 20.0 + indentLevel * 20.0;

        widgets.add(
          Padding(
            padding: EdgeInsets.only(left: leftPadding, top: 6, bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontSize: 16)),
                Expanded(child: buildInlineRichText(text)),
              ],
            ),
          ),
        );
      }
      // Normal text
      else {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: buildInlineRichText(trimmed),
        ));
      }

      widgets.add(const SizedBox(height: 8));
    }

    while (widgets.isNotEmpty && widgets.last is SizedBox) {
      widgets.removeLast();
    }

    return widgets;
  }

  // Image widget - beautiful display for figures & diagrams
  Widget _buildNetworkImage(String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          url,
          width: double.infinity,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Color(0xFF3AAE86),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Failed to load image', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Inline text formatting (**bold**, *italic*, `code`)
  Widget buildInlineRichText(String text) {
    final RegExp exp = RegExp(r'(\*\*(.+?)\*\*)|(__(.+?)__)|(\*(.+?)\*)|(_(.+?)_)|(`(.+?)`)');
    final List<InlineSpan> spans = [];
    int lastEnd = 0;

    for (final match in exp.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }

      final content = match.group(2) ?? match.group(4) ?? match.group(6) ?? match.group(8) ?? match.group(10) ?? '';

      if (match.group(1) != null || match.group(3) != null) {
        spans.add(TextSpan(text: content, style: const TextStyle(fontWeight: FontWeight.bold)));
      } else if (match.group(5) != null || match.group(7) != null) {
        spans.add(TextSpan(text: content, style: const TextStyle(fontStyle: FontStyle.italic)));
      } else if (match.group(9) != null) {
        spans.add(WidgetSpan(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
            child: Text(content, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
          ),
        ));
      }

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: const TextStyle(fontSize: 15.5, height: 1.5, color: Colors.black87),
      ),
    );
  }

  // Rest of your methods (sendMessage, etc.) remain unchanged...
  Future<void> sendMessage({String? imagePath}) async {
    final text = chatController.text.trim();
    if (text.isEmpty && imagePath == null) return;

    messages.add({'isUser': true, 'text': text, 'image': imagePath, 'time': _getCurrentTime()});
    chatController.clear();

    isTyping.value = true;

    try {
      final formData = dio.FormData.fromMap({
        "resource_id": resourceId,
        "user_id": userId,
        "user_request": text,
      });

      if (imagePath != null && imagePath.isNotEmpty) {
        formData.files.add(MapEntry('image', await dio.MultipartFile.fromFile(imagePath)));
      }

      final response = await _dio.post(
        ApiConfig.chatResource,
        data: formData,
        options: dio.Options(headers: {'Authorization': 'Bearer $authToken'}),
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final rawResponse = response.data['data']['response'] ?? '';
        final source = response.data['data']['source'] ?? '';

        final parsedWidgets = parseApiResponse(rawResponse);

        messages.add({
          'isUser': false,
          'widgets': parsedWidgets,
          'source': source,
          'time': _getCurrentTime(),
        });
      } else {
        throw Exception('API Error');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get response. Please try again.',
          backgroundColor: Colors.red.shade100, colorText: Colors.red.shade900);

      messages.add({
        'isUser': false,
        'text': "Sorry, I'm having trouble right now. Try again later.",
        'time': _getCurrentTime(),
      });
    } finally {
      isTyping.value = false;
    }
  }

  void pickAndSendImage() {
    Get.snackbar('Coming Soon', 'Image upload will be available soon!',
        backgroundColor: Colors.blue.shade100, colorText: Colors.blue.shade900);
  }

  void showAttachmentMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: Color(0xFF3AAE86)),
                title: const Text('Take Photo'),
                onTap: () => Get.back(),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: Color(0xFF3AAE86)),
                title: const Text('Choose from Gallery'),
                onTap: () => Get.back(),
              ),
              ListTile(
                leading: const Icon(Icons.file_present_rounded, color: Color(0xFF3AAE86)),
                title: const Text('Upload Document'),
                onTap: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    chatController.dispose();
    super.onClose();
  }
}