// lib/modules/onlinetest/view/onlinetest_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/onlinetest/controller/onlinetest_controller.dart';

class OnlineTestView extends GetView<OnlineTestController> {
  const OnlineTestView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Scaling factor
    final double baseWidth = 360.0;
    final scale = (screenWidth / baseWidth).clamp(0.8, 1.4);

    // Auto scroll palette to current question
    ever(controller.currentIndex, (int index) {
      if (controller.paletteScrollController.hasClients) {
        final double itemWidth = 34.0 * scale + 6 * scale; // Include margin
        final double screenCenter = MediaQuery.of(context).size.width / 2;
        final double targetOffset = (index * itemWidth) - screenCenter + (itemWidth / 2);
        final double maxScroll = controller.paletteScrollController.position.maxScrollExtent;
        final double finalOffset = targetOffset.clamp(0.0, maxScroll);

        controller.paletteScrollController.animateTo(
          finalOffset,
          duration: const Duration(milliseconds: 400),
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
              padding: EdgeInsets.all(6 * scale),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Icon(Icons.laptop_mac, color: const Color.fromARGB(255, 5, 34, 7), size: 26 * scale),
            ),
            SizedBox(width: 12 * scale),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Mathematics Mock Test',
                    style: TextStyle(fontSize: 17 * scale, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 2 * scale),
                  Obx(() => Text(
                        'Question ${controller.currentIndex.value + 1} of ${controller.totalQuestions}',
                        style: TextStyle(fontSize: 13 * scale, color: Colors.white70),
                      )),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8 * scale),
            padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 6 * scale),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 2, 39, 3),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white54, width: 0.8),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time_filled, size: 14 * scale, color: Colors.white),
                SizedBox(width: 8 * scale),
                Obx(() => Text(
                      controller.formattedTime,
                      style: TextStyle(fontSize: 12 * scale, fontWeight: FontWeight.bold, color: Colors.white),
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
            icon: Icon(Icons.help_outline_rounded, color: Colors.white, size: 25 * scale),
          ),
        ],
      ),
      body: Column(
        children: [
          // Question Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20 * scale, 16 * scale, 20 * scale, 0),
            color: Colors.grey[50],
            child: Obx(() {
              final q = controller.allQuestions[controller.currentIndex.value];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Question ${controller.currentIndex.value + 1}",
                    style: TextStyle(
                        fontSize: 18 * scale,
                        fontWeight: FontWeight.w900,
                        color: const Color.fromARGB(221, 7, 71, 53)),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 5 * scale),
                        decoration: BoxDecoration(
                          color: q.type == "fib"
                              ? const Color(0xFFFFF8F0)
                              : q.type == "mcq"
                                  ? const Color(0xFFFDFDFF)
                                  : const Color(0xFFF3FFF9),
                          borderRadius: BorderRadius.circular(20 * scale),
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
                              size: 16 * scale,
                              color: q.type == "fib"
                                  ? const Color(0xFFFF9800)
                                  : q.type == "mcq"
                                      ? const Color(0xFF04190C)
                                      : const Color(0xFF1AC9A3),
                            ),
                            SizedBox(width: 6 * scale),
                            Text(
                              q.type == "fib" ? "FILL" : q.type == "mcq" ? "MCQ" : "T/F",
                              style: TextStyle(
                                fontSize: 12 * scale,
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
                      SizedBox(width: 12 * scale),
                      Text(
                        "${q.marks} marks",
                        style: TextStyle(
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 17, 170, 137),
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
                      padding: EdgeInsets.fromLTRB(20 * scale, 24 * scale, 20 * scale, 24 * scale),
                      child: q.type == "fib"
                          ? _buildFibQuestion(q.text, scale)
                          : Text(q.text,
                              style: TextStyle(
                                  fontSize: 18 * scale, height: 1.6, fontWeight: FontWeight.w500, color: Colors.black87)),
                    ),
                    Container(height: 1, color: Colors.grey[350]),
                    Padding(
                      padding: EdgeInsets.all(20 * scale),
                      child: q.type == "fib"
                          ? _buildFibInput(userAnswer?.toString() ?? "", scale)
                          : q.type == "true_false"
                              ? _buildTrueFalseOptions(userAnswer, scale)
                              : _buildMcqOptions(q.options, userAnswer, scale),
                    ),
                  ],
                );
              }),
            ),
          ),

          // Bottom Panel
          Container(
            padding: EdgeInsets.all(12 * scale),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Questions',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15 * scale,
                            color: const Color.fromARGB(255, 10, 119, 106))),
                    Obx(() => Text('${controller.answeredCount}/${controller.totalQuestions} answered',
                        style: TextStyle(fontSize: 13 * scale))),
                  ],
                ),
                SizedBox(height: 8 * scale),

                // Question Palette
                SizedBox(
                  height: 50 * scale,
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
                                margin: EdgeInsets.only(right: 6 * scale),
                                width: 34 * scale,
                                height: 34 * scale,
                                decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(8 * scale),
                                  border: isCurrent ? Border.all(color: Colors.white, width: 3) : null,
                                ),
                                child: Center(
                                  child: Text('${i + 1}',
                                      style: TextStyle(color: txt, fontWeight: FontWeight.bold, fontSize: 14 * scale)),
                                ),
                              ),
                            );
                          }),
                        ),
                      )),
                ),
                SizedBox(height: 8 * scale),

                Row(
                  children: [
                    _legendItem(Icons.square, Colors.green.shade700, "Answered", scale),
                    SizedBox(width: 16 * scale),
                    _legendItem(Icons.square, Colors.black, "Current", scale),
                    SizedBox(width: 16 * scale),
                    _legendItem(Icons.square, Colors.orange.shade600, "Review", scale),
                  ],
                ),
                SizedBox(height: 40 * scale),

                // Buttons
                Obx(() {
                  final isLast = controller.isLastQuestion;

                  return Row(
                    children: [
                      // Previous
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.isFirstQuestion ? null : controller.goToPrevious,
                          icon: Icon(Icons.arrow_back_ios_new, size: 15 * scale),
                          label: Text("Previous", style: TextStyle(fontSize: 13 * scale)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.grey[800],
                            padding: EdgeInsets.symmetric(vertical: 11 * scale),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5 * scale)),
                          ),
                        ),
                      ),
                      SizedBox(width: 8 * scale),

                      // Review (always label "Review")
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.toggleReview,
                          icon: Icon(Icons.bookmark_border,
                              size: 20 * scale,
                              color: controller.reviewList.contains(controller.currentIndex.value)
                                  ? Colors.orange.shade700
                                  : Colors.orange[700]),
                          label: Text("Review", style: TextStyle(fontSize: 12 * scale)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.reviewList.contains(controller.currentIndex.value)
                                ? Colors.orange.shade100
                                : const Color.fromARGB(255, 255, 241, 219),
                            foregroundColor: Colors.orange[800],
                            side: BorderSide(color: Colors.orange[700]!, width: 1.8 * scale),
                            padding: EdgeInsets.symmetric(vertical: 11 * scale),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5 * scale)),
                          ),
                        ),
                      ),
                      SizedBox(width: 8 * scale),

                      // Next
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLast ? null : controller.goToNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 5, 35, 9),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 11 * scale),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5 * scale)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Next", style: TextStyle(fontSize: 14 * scale)),
                              SizedBox(width: 8 * scale),
                              Icon(Icons.arrow_forward_ios, size: 16 * scale),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8 * scale),

                      // Submit
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => controller.submitTest(),
                          icon: Icon(Icons.send, size: 16 * scale, color: Colors.white),
                          label: Text("Submit",
                              style: TextStyle(fontSize: 14 * scale, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF17A8A3),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 11 * scale),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5 * scale)),
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
  Widget _buildFibQuestion(String text, double scale) {
    final parts = text.split('______');
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 18 * scale, height: 1.6, color: Colors.black87),
        children: [
          TextSpan(text: parts[0]),
          if (parts.length > 1)
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10 * scale),
                child: Text('______',
                    style: TextStyle(fontSize: 24 * scale, fontWeight: FontWeight.bold, color: Colors.black87)),
              ),
            ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }

  // FIB Input
  Widget _buildFibInput(String currentText, double scale) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20 * scale),
      child: TextField(
        controller: TextEditingController(text: currentText)
          ..selection = TextSelection.fromPosition(TextPosition(offset: currentText.length)),
        onChanged: controller.answerFib,
        decoration: InputDecoration(
          hintText: "Type your answer here...",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: BorderSide(color: const Color(0xFFFF9800), width: 2 * scale)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: BorderSide(color: const Color(0xFFFF9800), width: 2 * scale)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12 * scale),
              borderSide: BorderSide(color: const Color(0xFFFF9800), width: 3 * scale)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 18 * scale),
        ),
        style: TextStyle(fontSize: 17 * scale),
      ),
    );
  }

  // True/False Options
  Widget _buildTrueFalseOptions(dynamic selected, double scale) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20 * scale),
      child: Row(
        children: List.generate(2, (i) {
          final isSel = selected == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.selectOption(i),
              child: Container(
                margin: EdgeInsets.only(right: i == 0 ? 12 * scale : 0),
                height: 60 * scale,
                decoration: BoxDecoration(
                  color: isSel ? const Color(0xFFE8F5E8) : Colors.white,
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(
                      color: isSel ? const Color(0xFF4CAF50) : Colors.grey.shade300,
                      width: isSel ? 2 * scale : 1.5 * scale),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        value: i,
                        groupValue: selected,
                        onChanged: (_) => controller.selectOption(i),
                        activeColor: const Color(0xFF4CAF50)),
                    Text(
                      ["True", "False"][i],
                      style: TextStyle(
                          fontSize: 18 * scale,
                          fontWeight: FontWeight.bold,
                          color: isSel ? const Color(0xFF2E7D32) : Colors.black87),
                    ),
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
  Widget _buildMcqOptions(List<String> options, dynamic selected, double scale) {
    return Column(
      children: List.generate(options.length, (i) {
        final isSel = selected == i;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 7 * scale),
          child: InkWell(
            onTap: () => controller.selectOption(i),
            borderRadius: BorderRadius.circular(12 * scale),
            child: Container(
              padding: EdgeInsets.all(10 * scale),
              decoration: BoxDecoration(
                color: isSel ? const Color.fromARGB(255, 244, 255, 244) : Colors.white,
                borderRadius: BorderRadius.circular(9 * scale),
                border: Border.all(
                    color: isSel ? const Color.fromARGB(255, 6, 57, 8) : Colors.grey.shade300,
                    width: isSel ? 2.5 * scale : 1.5 * scale),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30 * scale,
                    height: 30 * scale,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSel ? const Color.fromARGB(255, 6, 57, 8) : Colors.transparent,
                      border: Border.all(
                          color: isSel ? const Color.fromARGB(255, 6, 57, 8) : Colors.grey.shade500,
                          width: 2 * scale),
                    ),
                    child: Center(
                      child: Text(String.fromCharCode(65 + i),
                          style: TextStyle(color: isSel ? Colors.white : Colors.black87, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(width: 16 * scale),
                  Expanded(child: Text(options[i], style: TextStyle(fontSize: 16.5 * scale))),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _legendItem(IconData icon, Color color, String label, double scale) {
    return Row(
      children: [
        Icon(icon, color: color, size: 12 * scale),
        SizedBox(width: 6 * scale),
        Text(label, style: TextStyle(fontSize: 12 * scale, color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
