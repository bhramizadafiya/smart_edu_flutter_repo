// views/chatscreen_view.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:get/get.dart';
import '../controller/chatscreen_controller.dart';
import '../../../theme/design_system.dart';

class ChatScreenView extends StatelessWidget {
  const ChatScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ChatScreenController>();
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF3AAE86),
              child: Icon(Icons.smart_toy_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ctrl.resourceTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.textcolor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "AI Tutor • Online",
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: ctrl.messages.length + (ctrl.isTyping.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == ctrl.messages.length && ctrl.isTyping.value) {
                      return _buildTypingIndicator();
                    }

                    final msg = ctrl.messages[index];
                    final isUser = msg['isUser'] as bool;

                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: width * 0.85),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: isUser ? const Color(0xFF3AAE86) : const Color(0xFFF2F5F4),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20),
                            bottomLeft: Radius.circular(isUser ? 20 : 6),
                            bottomRight: Radius.circular(isUser ? 6 : 20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // AI rich response (headings, bullets, code blocks)
                            if (msg['widgets'] != null)
                              ...msg['widgets'] as List<Widget>,

                            // User/welcome messages
                            if (msg['widgets'] == null && msg['text']?.isNotEmpty == true)
                              ctrl.buildInlineRichText(msg['text']),

                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (msg['source'] != null)
                                  Text(
                                    msg['source'],
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      color: isUser ? Colors.white70 : Colors.black45,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                if (msg['source'] != null) const SizedBox(width: 8),
                                Text(
                                  msg['time'] ?? '',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isUser ? Colors.white70 : Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ),

          // Input Bar
          Container(
            padding: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
              bottom: MediaQuery.of(context).viewInsets.bottom + 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file_rounded, color: Colors.grey),
                  onPressed: () => ctrl.showAttachmentMenu(context),
                ),
                Expanded(
                  child: TextField(
                    controller: ctrl.chatController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => ctrl.sendMessage(),
                    minLines: 1,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Ask about this resource...",
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15.5),
                      filled: true,
                      fillColor: const Color(0xFFF5F6F7),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF3AAE86),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white, size: 24),
                    onPressed: ctrl.sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F5F4),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _Dot(),
            SizedBox(width: 8),
            _Dot(),
            SizedBox(width: 8),
            _Dot(),
          ],
        ),
      ),
    );
  }
}

// Black Code Block with Copy Button (Full Copy on Tap)
class CodeBlockWithCopy extends StatefulWidget {
  final String code;
  const CodeBlockWithCopy({super.key, required this.code});

  @override
  State<CodeBlockWithCopy> createState() => _CodeBlockWithCopyState();
}

class _CodeBlockWithCopyState extends State<CodeBlockWithCopy> {
  bool _copied = false;

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: widget.code.trim()));
    setState(() => _copied = true);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code copied to clipboard!', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          // Code content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText(
                widget.code.trim(),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.5,
                  color: Colors.white,
                  height: 1.6,
                ),
              ),
            ),
          ),
          // Top bar with copy button
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: _copyCode,
                  child: Row(
                    children: [
                      Icon(
                        _copied ? Icons.check_rounded : Icons.copy_rounded,
                        color: _copied ? Colors.green : Colors.white70,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _copied ? 'Copied!' : 'Copy',
                        style: TextStyle(
                          color: _copied ? Colors.green : Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  const _Dot();
  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this)..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}