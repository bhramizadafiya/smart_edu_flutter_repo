// lib/modules/viewsolutions/view/viewsolutions_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final int incorrectCount = total - correctCount;
    final int skippedCount = controller.userAnswers.where((ans) => ans == null).length;

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

      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 254, 254, 254),
appBar: PreferredSize(
  preferredSize: const Size.fromHeight(50), // Just enough height
  child: Container(
    decoration: const BoxDecoration(
      color: Color(0xFFE8F5E8), // Light green background
      border: Border(
        bottom: BorderSide(color: Colors.teal, width: 1),
      ),
    ),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            // Back Button + Title (close together)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.arrow_back, color: Colors.teal, size: 22),
                  onPressed: () => Get.back(),
                ),
                const SizedBox(width: 30),
                const Text(
                  "Test Solutions",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(221, 10, 66, 54),
                  ),
                ),
              ],
            ),

            const Spacer(), // Pushes everything to edges

            // Question count on the right
            Text(
              "$total/$total questions",
              style: const TextStyle(
                fontSize: 15.5,
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 16), // Right padding
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
  color: Colors.grey[100], // Light grey background for the whole section (you can use Colors.grey[200] for a slightly darker shade)
  padding: const EdgeInsets.fromLTRB(16, 20, 70, 20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Filter Questions", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900,color: Color.fromARGB(255, 9, 54, 44))),
      const SizedBox(height: 14),
      Row(
        children: [
          Expanded(child: _buildFilterChip("All", total, Colors.blue, filter == "All")),
          const SizedBox(width: 12),
          Expanded(child: _buildFilterChip("Correct", correctCount, Colors.green, filter == "Correct")),
          const SizedBox(width: 12),
          Expanded(child: _buildFilterChip("Incorrect", incorrectCount, Colors.red, filter == "Incorrect")),
        ],
      ),
      const SizedBox(height: 12),
      _buildFilterChip("Skipped", skippedCount, Colors.grey, filter == "Skipped"),
    ],
  ),
),
            const SizedBox(height: 8),

            // QUESTIONS LIST
            Expanded(
              child: filteredIndices.isEmpty
                  ? const Center(child: Text("No questions found", style: TextStyle(fontSize: 18, color: Colors.grey)))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredIndices.length,
                      itemBuilder: (context, listIndex) {
                        final i = filteredIndices[listIndex];
                        final q = controller.allQuestions[i];
                        final userAns = i < controller.userAnswers.length ? controller.userAnswers[i] : null;
                        final isCorrect = controller.isCorrect(i);

                        // Convert answer to display text
                        // Replace this entire block in your itemBuilder
String userAnswerText = "(Not answered)";
String correctAnswerText = "";

// Helper to safely convert num → int
int safeInt(dynamic val) => val is num ? val.toInt() : (val as int? ?? 0);

if (q.type == "true_false") {
  // True / False
  final int correctIdx = safeInt(q.correctAnswer);
  final int? userIdx = userAns != null ? safeInt(userAns) : null;

  userAnswerText = userIdx == 0
      ? "True"
      : userIdx == 1
          ? "False"
          : "(Not answered)";
  correctAnswerText = correctIdx == 0 ? "True" : "False";

} else if (q.type == "mcq") {
  // MCQ – Show Letter + Full Text
  final int correctIdx = safeInt(q.correctAnswer);
  final int? userIdx = userAns != null ? safeInt(userAns) : null;

  final String correctLetter = String.fromCharCode(65 + correctIdx);
  final String correctFull = "$correctLetter. ${q.options[correctIdx]}";

  if (userIdx != null) {
    final String userLetter = String.fromCharCode(65 + userIdx);
    userAnswerText = "$userLetter. ${q.options[userIdx]}";
  } else {
    userAnswerText = "(Not answered)";
  }

  correctAnswerText = correctFull;

} else {
  // FIB
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
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // HEADER
                                Row(
  children: [
    Text(
      "Question ${i + 1}",
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900,color: Color.fromARGB(255, 12, 72, 58)),
    ),
    const SizedBox(width: 10),

    // NEW BEAUTIFUL TYPE BADGE WITH ICON
 Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                                    ? const Color.fromARGB(255, 38, 135, 214)
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
                                      ? const Color.fromARGB(255, 38, 135, 214)
                                      : const Color(0xFF1AC9A3),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              q.type == "fib" ? "FILL" : q.type == "mcq" ? "MCQ" : "T/F",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: q.type == "fib"
                                    ? const Color(0xFFFF9800)
                                    : q.type == "mcq"
                                        ? const Color.fromARGB(255, 38, 135, 214)
                                        : const Color(0xFF1AC9A3),
                              ),
                            ),
                          ],
                        ),
                      ),

    const Spacer(),

    // Correct/Incorrect Status
    Icon(
      isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
      color: isCorrect ? Colors.green : Colors.red,
      size: 22,
    ),
    const SizedBox(width: 6),
    Text(
      isCorrect ? "Correct ${q.marks} marks" : "Incorrect 0 marks",
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
      ),
    ),
  ],
),
                                const SizedBox(height: 16),
                                Text(q.text, style: const TextStyle(fontSize: 16.5, height: 1.5)),
                                const SizedBox(height: 20),

                                // OPTIONS
                               // OPTIONS
if (q.type == "mcq")
  ...q.options.asMap().entries.map((e) {
    int idx = e.key;
    String opt = e.value;
    bool selected = userAns == idx;
    bool correctAns = idx == q.correctAnswer;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: correctAns ? Colors.green.withOpacity(0.12) : selected ? Colors.red.withOpacity(0.12) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: correctAns ? Colors.green.shade400 : selected ? Colors.red.shade400 : Colors.grey.shade300, width: correctAns || selected ? 2 : 1.5),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: correctAns ? const Color.fromARGB(255, 17, 170, 111) : selected ? const Color.fromARGB(255, 255, 37, 59) : Colors.grey.shade100,
            child: Text(
              String.fromCharCode(65 + idx),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: correctAns ? const Color.fromARGB(255, 255, 255, 255) : selected ? const Color.fromARGB(255, 255, 255, 255) : Colors.grey.shade700),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              opt,
              style: TextStyle(fontSize: 16, fontWeight: correctAns || selected ? FontWeight.w600 : FontWeight.w500, color: correctAns ? Colors.green.shade800 : selected ? Colors.red.shade800 : null),
            ),
          ),
          if (correctAns) const Icon(Icons.check, color: Colors.green) else if (selected) const Icon(Icons.close, color: Colors.red),
        ],
      ),
    );
  }).toList(),

if (q.type == "true_false")
  Row(
    children: ["True", "False"].asMap().entries.map((e) {
      int idx = e.key;
      bool correctAns = idx == q.correctAnswer;
      bool selected = userAns == idx;
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(right: idx == 0 ? 10 : 0),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: correctAns ? Colors.green.withOpacity(0.12) : selected ? Colors.red.withOpacity(0.12) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: correctAns ? Colors.green.shade400 : selected ? Colors.red.shade400 : Colors.grey.shade300, width: correctAns || selected ? 2 : 1.5),
          ),
          child: Center(
            child: Text(
              e.value,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: correctAns ? Colors.green.shade800 : selected ? Colors.red.shade800 : Colors.black87),
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
      // Your FIB content will go here (e.g., _buildFibBox calls)
    ],
  ),

// Conditional spacing after options
if (q.type == "mcq" || q.type == "true_false")
  const SizedBox(height: 20)
else if (q.type == "fib")
  const SizedBox(height: 0),

                       
// YOUR ANSWER + CORRECT ANSWER – BOTH TEXT & LABEL COLORED PERFECTLY
Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    // Background color
    color: (q.type == "fib"
            ? (isCorrect ? Colors.orange.withOpacity(0.05) : Colors.red.withOpacity(0.05))
            : (isCorrect ? Colors.green.withOpacity(0.05) : Colors.red.withOpacity(0.05))),
    
    borderRadius: BorderRadius.circular(9),
    border: Border.all(
      // Border color
      color: q.type == "fib"
          ? (isCorrect ? const Color(0xFFFF9800) : Colors.red)
          : (isCorrect ? Colors.green : Colors.red),
      width: 2,
    ),
  ),
  child: Column(
    children: [
      // YOUR ANSWER
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.person,
            color: q.type == "fib"
                ? (isCorrect ? const Color(0xFFFF9800) : Colors.red)
                : (isCorrect ? Colors.green : Colors.red),
            size: 22,
          ),
          const SizedBox(width: 10),
          Text(
            "Your Answer:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: q.type == "fib"
                  ? (isCorrect ? const Color(0xFFFF9800) : Colors.red.shade700)
                  : (isCorrect ? Colors.green : Colors.red.shade700),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              userAnswerText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: q.type == "fib"
                    ? (isCorrect ? const Color(0xFFFF9800) : Colors.red.shade800)
                    : (isCorrect ? Colors.green : Colors.red.shade800),
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 10),

      // CORRECT ANSWER – ALWAYS GREEN
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 22),
          const SizedBox(width: 10),
          const Text(
            "Correct Answer:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              correctAnswerText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    ],
  ),
),               ],
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
  }

  Widget _buildFilterChip(String label, int count, Color color, bool isSelected) {
  return GestureDetector(
    onTap: () => controller.currentFilter.value = label,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.05) : Colors.white, // Unselected = solid white background
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? color : Colors.grey.shade300,
          width: isSelected ? 1.2 : 1.2,
        ),
      ),
      child: Text(
        "$label [$count]",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? color : Colors.grey[700],
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    ),
  );
}


}