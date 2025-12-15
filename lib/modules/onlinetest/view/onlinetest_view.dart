// lib/modules/onlinetest/view/onlinetest_view.dart

import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:smarted/modules/onlinetest/controller/onlinetest_controller.dart';

class OnlineTestView extends GetView<OnlineTestController> {
  const OnlineTestView({super.key});

  @override
  Widget build(BuildContext context) {
    // Auto scroll palette to current question
    ever(controller.currentIndex, (int index) {
      if (controller.paletteScrollController.hasClients) {
        final double itemWidth = 34.0;
        final double targetOffset = (index * itemWidth) - (Get.width / 2) + (itemWidth / 2);
        final double maxScroll = controller.paletteScrollController.position.maxScrollExtent;
        final double finalOffset = targetOffset.clamp(0.0, maxScroll);

        controller.paletteScrollController.animateTo(
          finalOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

 

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 34, 7),
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.laptop_mac, color: Color.fromARGB(255, 5, 34, 7), size: 26),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Mathematics Mock Test',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 2),
                  Obx(() => Text('Question ${controller.currentIndex.value + 1} of ${controller.totalQuestions}',
                      style: const TextStyle(fontSize: 13, color: Colors.white70))),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 2, 39, 3),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white54, width: 0.8),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time_filled, size: 14, color: Colors.white),
                const SizedBox(width: 8),
                Obx(() => Text(
                  controller.formattedTime,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                )),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Get.dialog(
              AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                title: const Text("Instructions", style: TextStyle(fontWeight: FontWeight.bold)),
                content: const Text("• Answer all questions\n• Use Review button\n• Submit when ready\n• Good luck!"),
                actions: [TextButton(onPressed: () => Get.back(), child: const Text("OK"))],
              ),
            ),
            icon: const Icon(Icons.help_outline_rounded, color: Colors.white, size: 25),
          ),
        ],
      ),

      body: Column(
        children: [
          // Question Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            color: Colors.grey[50],
            child: Obx(() {
              final q = controller.allQuestions[controller.currentIndex.value];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Question ${controller.currentIndex.value + 1}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color.fromARGB(221, 7, 71, 53))),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: q.type == "fib"
                              ? const Color(0xFFFFF8F0)
                              : q.type == "mcq"
                                  ? const Color(0xFFFDFDFF)
                                  : const Color(0xFFF3FFF9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: q.type == "fib"
                                ? const Color(0xFFFF9800)
                                : q.type == "mcq"
                                    ? const Color(0xFF04190C)
                                    : const Color(0xFF1AC9A3),
                            width: 1.8,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              q.type == "fib"
                                  ? Icons.note_alt_outlined
                                  : q.type == "mcq"
                                      ? Icons.radio_button_unchecked
                                      : Icons.check_circle_outline,
                              size: 16,
                              color: q.type == "fib"
                                  ? const Color(0xFFFF9800)
                                  : q.type == "mcq"
                                      ? const Color(0xFF04190C)
                                      : const Color(0xFF1AC9A3),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              q.type == "fib" ? "FILL" : q.type == "mcq" ? "MCQ" : "T/F",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: q.type == "fib"
                                    ? const Color(0xFFFF9800)
                                    : q.type == "mcq"
                                        ? const Color(0xFF04190C)
                                        : const Color(0xFF1AC9A3),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // DYNAMIC MARKS FROM QUESTION
                      Text(
                        "${q.marks} marks",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 17, 170, 137),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),

          // Question Body
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                final q = controller.allQuestions[controller.currentIndex.value];
                final userAnswer = controller.userAnswers[controller.currentIndex.value];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: const Color.fromARGB(255, 252, 252, 252),
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                      child: q.type == "fib"
                          ? _buildFibQuestion(q.text)
                          : Text(q.text,
                              style: const TextStyle(fontSize: 18, height: 1.6, fontWeight: FontWeight.w500, color: Colors.black87)),
                    ),

                    Container(height: 1, color: Colors.grey[350]),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: q.type == "fib"
                          ? _buildFibInput(userAnswer?.toString() ?? "")
                          : q.type == "true_false"
                              ? _buildTrueFalseOptions(userAnswer)
                              : _buildMcqOptions(q.options, userAnswer),
                    ),
                  ],
                );
              }),
            ),
          ),

          // Bottom Panel
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Questions',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color.fromARGB(255, 10, 119, 106))),
                    Obx(() => Text('${controller.answeredCount}/${controller.totalQuestions} answered',
                        style: const TextStyle(fontSize: 13))),
                  ],
                ),
                const SizedBox(height: 8),

                // Question Palette
                SizedBox(
                  height: 50,
                  child: Obx(() => SingleChildScrollView(
                    controller: controller.paletteScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(controller.totalQuestions.value, (i) {
                        final answer = controller.userAnswers[i];
                        final isAnswered = answer != null &&
                            (controller.allQuestions[i].type == "fib"
                                ? (answer as String).trim().isNotEmpty
                                : true);
                        final isCurrent = i == controller.currentIndex.value;
                        final isReviewed = controller.reviewList.contains(i);

                        Color bg = Colors.grey[300]!;
                        Color txt = Colors.grey[700]!;

                        if (isCurrent) {
                          bg = Colors.black;
                          txt = Colors.white;
                        } else if (isReviewed) {
                          bg = Colors.orange.shade600;
                          txt = Colors.white;
                        } else if (isAnswered) {
                          bg = const Color.fromARGB(255, 31, 126, 83);
                          txt = Colors.white;
                        }

                        return GestureDetector(
                          onTap: () => controller.goToQuestion(i),
                          child: Container(
                            margin: const EdgeInsets.only(right: 6),
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(8),
                              border: isCurrent ? Border.all(color: Colors.white, width: 3) : null,
                            ),
                            child: Center(
                              child: Text('${i + 1}',
                                  style: TextStyle(color: txt, fontWeight: FontWeight.bold, fontSize: 14)),
                            ),
                          ),
                        );
                      }),
                    ),
                  )),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    _legendItem(Icons.square, Colors.green.shade700, "Answered"),
                    const SizedBox(width: 16),
                    _legendItem(Icons.square, Colors.black, "Current"),
                    const SizedBox(width: 16),
                    _legendItem(Icons.square, Colors.orange.shade600, "Review"),
                  ],
                ),

                const SizedBox(height: 40),

                // Buttons
                Obx(() {
                  final isLast = controller.isLastQuestion;

                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.isFirstQuestion ? null : controller.goToPrevious,
                          icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                          label: const Text("Previous"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.grey[800],
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.toggleReview,
                          icon: Icon(Icons.bookmark_border,
                              size: 20,
                              color: controller.reviewList.contains(controller.currentIndex.value)
                                  ? Colors.orange.shade700
                                  : Colors.orange[700]),
                          label: Text(
                            controller.reviewList.contains(controller.currentIndex.value) ? "Reviewed" : "Review",
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.reviewList.contains(controller.currentIndex.value)
                                ? Colors.orange.shade100
                                : const Color.fromARGB(255, 255, 241, 219),
                            foregroundColor: Colors.orange[800],
                            side: BorderSide(color: Colors.orange[700]!, width: 1.8),
                            padding: const EdgeInsets.symmetric(vertical:11),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLast ? null : controller.goToNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 5, 35, 9),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical:11),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Next"),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_ios, size: 16),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => controller.submitTest(),
                          icon: const Icon(Icons.send, size: 18, color: Colors.white),
                          label: const Text("Submit",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF17A8A3),
                            foregroundColor: Colors.white,
                            elevation: 6,
                            padding: const EdgeInsets.symmetric(vertical:11),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // FIB Question
  Widget _buildFibQuestion(String text) {
    final parts = text.split('______');
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 18, height: 1.6, color: Colors.black87),
        children: [
          TextSpan(text: parts[0]),
          if (parts.length > 1)
            const WidgetSpan(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('______',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
              ),
            ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }

  // FIB Input
  Widget _buildFibInput(String currentText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: TextEditingController(text: currentText)
          ..selection = TextSelection.fromPosition(TextPosition(offset: currentText.length)),
        onChanged: controller.answerFib,
        decoration: InputDecoration(
          hintText: "Type your answer here...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFFF9800), width: 2)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFFF9800), width: 2)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFFF9800), width: 3)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
        style: const TextStyle(fontSize: 17),
      ),
    );
  }

  // True/False Options
  Widget _buildTrueFalseOptions(dynamic selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: List.generate(2, (i) {
          final isSel = selected == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.selectOption(i),
              child: Container(
                margin: EdgeInsets.only(right: i == 0 ? 12 : 0),
                height: 60,
                decoration: BoxDecoration(
                  color: isSel ? const Color(0xFFE8F5E8) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSel ? const Color(0xFF4CAF50) : Colors.grey.shade300, width: isSel ? 2 : 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(value: i, groupValue: selected, onChanged: (_) => controller.selectOption(i), activeColor: const Color(0xFF4CAF50)),
                    Text(["True", "False"][i],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isSel ? const Color(0xFF2E7D32) : Colors.black87)),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // MCQ Options
  Widget _buildMcqOptions(List<String> options, dynamic selected) {
    return Column(
      children: List.generate(options.length, (i) {
        final isSel = selected == i;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: InkWell(
            onTap: () => controller.selectOption(i),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSel ? const Color.fromARGB(255, 244, 255, 244) : Colors.white,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: isSel ? const Color.fromARGB(255, 6, 57, 8) : Colors.grey.shade300, width: isSel ? 2.5 : 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSel ? const Color.fromARGB(255, 6, 57, 8) : Colors.transparent,
                      border: Border.all(color: isSel ? const Color.fromARGB(255, 6, 57, 8) : Colors.grey.shade500, width: 2),
                    ),
                    child: Center(
                      child: Text(String.fromCharCode(65 + i),
                          style: TextStyle(color: isSel ? Colors.white : Colors.black87, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Text(options[i], style: const TextStyle(fontSize: 16.5))),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _legendItem(IconData icon, Color color, String label) {
    return Row(
      children: [
        Icon(icon, color: color, size: 12),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}