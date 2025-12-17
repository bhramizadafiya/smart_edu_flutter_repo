import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/theme/design_system.dart';
import '../controller/viewsolutions_controller.dart';

class ViewSolutionsView extends GetView<ViewSolutionsController> {
  const ViewSolutionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int total = controller.allQuestions.length;
    final int correctCount = controller.allQuestions
        .asMap()
        .entries
        .where((e) => controller.isCorrect(e.key))
        .length;
    final int skippedCount =
        controller.userAnswers.where((ans) => ans == null).length;
    final int incorrectCount = total - correctCount - skippedCount;

    return Obx(() {
      final filter = controller.currentFilter.value;
      List<int> filteredIndices = [];
      for (int i = 0; i < controller.allQuestions.length; i++) {
        final skipped = controller.userAnswers[i] == null;
        final correct = controller.isCorrect(i);
        if (filter == "All" ||
            (filter == "Correct" && correct) ||
            (filter == "Incorrect" && !correct && !skipped) ||
            (filter == "Skipped" && skipped)) {
          filteredIndices.add(i);
        }
      }

      return LayoutBuilder(builder: (context, constraints) {
        double width = constraints.maxWidth;
        double paddingHorizontal = width < 600
            ? 12
            : width < 900
                ? 16
                : 24;
        double fontSizeTitle = width < 600
            ? 18
            : width < 900
                ? 20
                : 22;
        double fontSizeText = width < 600
            ? 14
            : width < 900
                ? 16
                : 18;

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 254, 254, 254),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E8),
                border: Border(
                  bottom: BorderSide(color: Colors.teal, width: 1),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                  child: Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.teal, size: 22),
                            onPressed: () => Get.back(),
                          ),
                          SizedBox(width: width * 0.03),
                          Text(
                            "Test Solutions",
                            style: TextStyle(
                              fontSize: fontSizeTitle,
                              fontWeight: FontWeight.w800,
                              color: const Color.fromARGB(221, 10, 66, 54),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        "$total/$total questions",
                        style: TextStyle(
                          fontSize: fontSizeText - 2,
                          color: Colors.teal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              // FILTER CHIPS
              Container(
                width: double.infinity,
                color: Colors.grey[100],
                padding: EdgeInsets.fromLTRB(
                    paddingHorizontal, 16, paddingHorizontal, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Filter Questions",
                      style: TextStyle(
                        fontSize: fontSizeText,
                        fontWeight: FontWeight.w900,
                        color: const Color.fromARGB(255, 9, 54, 44),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // First line: All, Correct, Incorrect
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _buildFilterChip("All", total, Colors.blue, filter == "All"),
                        _buildFilterChip("Correct", correctCount, AppColors.gradientMiddle,
                            filter == "Correct"),
                        _buildFilterChip("Incorrect", incorrectCount, Colors.red,
                            filter == "Incorrect"),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Second line: Skipped
                    _buildFilterChip("Skipped", skippedCount, Colors.grey,
                        filter == "Skipped"),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // QUESTIONS LIST
              Expanded(
                child: filteredIndices.isEmpty
                    ? Center(
                        child: Text(
                          "No questions found",
                          style: TextStyle(
                              fontSize: fontSizeText, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: paddingHorizontal),
                        itemCount: filteredIndices.length,
                        itemBuilder: (context, listIndex) {
                          final i = filteredIndices[listIndex];
                          final q = controller.allQuestions[i];
                          final userAns = i < controller.userAnswers.length
                              ? controller.userAnswers[i]
                              : null;
                          final isCorrect = controller.isCorrect(i);

                          String userAnswerText = "(Not answered)";
                          String correctAnswerText = "";
                          int safeInt(dynamic val) =>
                              val is num ? val.toInt() : (val as int? ?? 0);

                          if (q.type == "true_false") {
                            final int correctIdx = safeInt(q.correctAnswer);
                            final int? userIdx =
                                userAns != null ? safeInt(userAns) : null;
                            userAnswerText = userIdx == 0
                                ? "True"
                                : userIdx == 1
                                    ? "False"
                                    : "(Not answered)";
                            correctAnswerText = correctIdx == 0 ? "True" : "False";
                          } else if (q.type == "mcq") {
                            final int correctIdx = safeInt(q.correctAnswer);
                            final int? userIdx =
                                userAns != null ? safeInt(userAns) : null;
                            final String correctLetter =
                                String.fromCharCode(65 + correctIdx);
                            final String correctFull =
                                "$correctLetter. ${q.options[correctIdx]}";
                            if (userIdx != null) {
                              final String userLetter =
                                  String.fromCharCode(65 + userIdx);
                              userAnswerText =
                                  "$userLetter. ${q.options[userIdx]}";
                            }
                            correctAnswerText = correctFull;
                          } else {
                            userAnswerText = userAns?.toString() ?? "(Not answered)";
                            correctAnswerText = q.correctAnswer.toString();
                          }

                          return Card(
                            elevation: 0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.grey.shade200),
                            ),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding:
                                  EdgeInsets.all(width < 600 ? 12 : 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // HEADER
                                  Row(
                                    children: [
                                      Text(
                                        "Question ${i + 1}",
                                        style: TextStyle(
                                            fontSize: fontSizeText,
                                            fontWeight: FontWeight.w900,
                                            color: const Color.fromARGB(
                                                255, 12, 72, 58)),
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
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
                                                    ? const Color.fromARGB(
                                                        255, 38, 135, 214)
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
                                                      ? const Color.fromARGB(
                                                          255, 38, 135, 214)
                                                      : const Color(0xFF1AC9A3),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              q.type == "fib"
                                                  ? "FILL"
                                                  : q.type == "mcq"
                                                      ? "MCQ"
                                                      : "T/F",
                                              style: TextStyle(
                                                fontSize: width < 600 ? 10 : 12,
                                                fontWeight: FontWeight.bold,
                                                color: q.type == "fib"
                                                    ? const Color(0xFFFF9800)
                                                    : q.type == "mcq"
                                                        ? const Color.fromARGB(
                                                            255, 38, 135, 214)
                                                        : const Color(0xFF1AC9A3),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        isCorrect
                                            ? Icons.check_circle_outline
                                            : (userAns == null
                                                ? Icons.remove_circle_outline
                                                : Icons.cancel_outlined),
                                        color: isCorrect
                                            ? AppColors.gradientMiddle
                                            : (userAns == null
                                                ? Colors.grey
                                                : Colors.red),
                                        size: 22,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        isCorrect
                                            ? "Correct ${q.marks} marks"
                                            : (userAns == null
                                                ? "Skipped"
                                                : "Incorrect 0 marks"),
                                        style: TextStyle(
                                          fontSize: width < 600 ? 12 : 14,
                                          fontWeight: FontWeight.w600,
                                          color: isCorrect
                                              ? AppColors.gradientMiddle
                                              : (userAns == null
                                                  ? Colors.grey
                                                  : Colors.red.shade700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(q.text,
                                      style: TextStyle(
                                          fontSize: fontSizeText,
                                          height: 1.5)),
                                  const SizedBox(height: 12),
                                  // MCQ OPTIONS
                                  if (q.type == "mcq")
                                    ...q.options.asMap().entries.map((e) {
                                      int idx = e.key;
                                      String opt = e.value;
                                      bool selected = userAns == idx;
                                      bool correctAns = idx == q.correctAnswer;
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: correctAns
                                              ? AppColors.gradientMiddle.withOpacity(0.12)
                                              : selected
                                                  ? Colors.red.withOpacity(0.12)
                                                  : Colors.grey.shade50,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                              color: correctAns
                                                  ? AppColors.gradientMiddle
                                                  : selected
                                                      ? Colors.red.shade400
                                                      : Colors.grey.shade300,
                                              width: correctAns || selected ? 2 : 1.5),
                                        ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 14,
                                              backgroundColor: correctAns
                                                  ? AppColors.gradientMiddle
                                                  : selected
                                                      ? const Color.fromARGB(
                                                          255, 255, 37, 59)
                                                      : Colors.grey.shade100,
                                              child: Text(
                                                String.fromCharCode(65 + idx),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: correctAns
                                                      ? Colors.white
                                                      : selected
                                                          ? Colors.white
                                                          : Colors.grey.shade700,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                opt,
                                                style: TextStyle(
                                                    fontSize: fontSizeText - 2,
                                                    fontWeight: correctAns ||
                                                            selected
                                                        ? FontWeight.w600
                                                        : FontWeight.w500,
                                                    color: correctAns
                                                        ? AppColors.gradientMiddle
                                                        : selected
                                                            ? Colors.red.shade800
                                                            : null),
                                              ),
                                            ),
                                            if (correctAns)
                                              const Icon(Icons.check,
                                                  color: AppColors.gradientMiddle, size: 18)
                                            else if (selected)
                                              const Icon(Icons.close,
                                                  color: Colors.red, size: 18),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  // TRUE/FALSE
                                  if (q.type == "true_false")
                                    Row(
                                      children: ["True", "False"]
                                          .asMap()
                                          .entries
                                          .map((e) {
                                        int idx = e.key;
                                        bool correctAns = idx == q.correctAnswer;
                                        bool selected = userAns == idx;
                                        return Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: idx == 0 ? 10 : 0),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            decoration: BoxDecoration(
                                              color: correctAns
                                                  ? AppColors.gradientMiddle.withOpacity(0.12)
                                                  : selected
                                                      ? Colors.red.withOpacity(0.12)
                                                      : Colors.grey.shade50,
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: correctAns
                                                      ? AppColors.gradientMiddle
                                                      : selected
                                                          ? Colors.red.shade400
                                                          : Colors.grey.shade300,
                                                  width: correctAns || selected
                                                      ? 2
                                                      : 1.5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                e.value,
                                                style: TextStyle(
                                                    fontSize: width < 600 ? 14 : 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: correctAns
                                                        ? AppColors.gradientMiddle
                                                        : selected
                                                            ? Colors.red.shade800
                                                            : const Color.fromARGB(255, 105, 105, 105)),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  if (q.type == "fib")
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  SizedBox(height: q.type == "fib" ? 0 : 12),
                                  // YOUR ANSWER + CORRECT ANSWER
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: (q.type == "fib"
                                          ? (isCorrect
                                              ? Colors.orange.withOpacity(0.05)
                                              : userAns == null
                                                  ? Colors.grey.withOpacity(0.05)
                                                  : Colors.red.withOpacity(0.05))
                                          : (isCorrect
                                              ? AppColors.gradientMiddle.withOpacity(0.05)
                                              : userAns == null
                                                  ? Colors.grey.withOpacity(0.05)
                                                  : Colors.red.withOpacity(0.05))),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: q.type == "fib"
                                            ? (isCorrect
                                                ? const Color(0xFFFF9800)
                                                : userAns == null
                                                    ? Colors.grey
                                                    : Colors.red)
                                            : (isCorrect
                                                ? AppColors.gradientMiddle
                                                : userAns == null
                                                    ? Colors.grey
                                                    : Colors.red),
                                        width: 1.8,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: q.type == "fib"
                                                  ? (isCorrect
                                                      ? const Color(0xFFFF9800)
                                                      : userAns == null
                                                          ? Colors.grey
                                                          : Colors.red)
                                                  : (isCorrect
                                                      ?AppColors.gradientMiddle
                                                      : userAns == null
                                                          ? Colors.grey
                                                          : Colors.red.shade700),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "Your Answer:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: q.type == "fib"
                                                    ? (isCorrect
                                                        ? const Color(0xFFFF9800)
                                                        : userAns == null
                                                            ? Colors.grey
                                                            : Colors.red.shade700)
                                                    : (isCorrect
                                                        ? AppColors.gradientMiddle
                                                        : userAns == null
                                                            ? Colors.grey
                                                            : Colors.red.shade700),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                userAnswerText,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: q.type == "fib"
                                                      ? (isCorrect
                                                          ? const Color(0xFFFF9800)
                                                          : userAns == null
                                                              ? Colors.grey
                                                              : Colors.red.shade800)
                                                      : (isCorrect
                                                          ? AppColors.gradientMiddle
                                                          : userAns == null
                                                              ? Colors.grey
                                                              : Colors.red.shade800),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.check_circle_outline,
                                                color: AppColors.gradientMiddle, size: 20),
                                            const SizedBox(width: 8),
                                            const Text(
                                              "Correct Answer:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: AppColors.gradientMiddle,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                correctAnswerText,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.gradientMiddle,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      });
    });
  }

  // Compact Filter Chip
  Widget _buildFilterChip(
      String label, int count, Color color, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.currentFilter.value = label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade400,
            width: 1.2,
          ),
        ),
        child: Text(
          "$label [$count]",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isSelected ? color : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
