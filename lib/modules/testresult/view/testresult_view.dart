// lib/modules/testresult/view/testresult_view.dart
import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../controller/testresult_controller.dart';

class TestResultView extends GetView<TestResultController> {
  const TestResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 55,
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const Icon(Icons.emoji_events, color: Color(0xFF1B5E20), size: 28),
        ),
        title: const Column(
          children: [
            Text("Test Completed!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 3),
            Text("Mathematics Mock Test", style: TextStyle(fontSize: 15, color: Colors.white70, fontWeight: FontWeight.w600)),
          ],
        ),
        flexibleSpace: Container(color: const Color.fromARGB(255, 10, 47, 12)),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(32))),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Score Section
            // 1. Score Section
Container(
  width: double.infinity,
  color: const Color.fromARGB(255, 243, 255, 251),
 padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
  child: Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 140,
            height: 140,
            child: CircularProgressIndicator(
              value: controller.overallPercentage / 100,
              strokeWidth: 14,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation(Color.fromARGB(255, 29, 161, 117)),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${controller.overallPercentage}%",
                style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 29, 161, 117)),
              ),
              const Text("Score", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 38, 109, 77))),
            ],
          ),
        ],
      ),
      const SizedBox(height: 18),

      // Performance Rating Based on Percentage
      Builder(builder: (context) {
        final int percent = controller.overallPercentage;
        String rating;
        Color ratingColor;

        if (percent < 50) {
          rating = "Low Performance!";
          ratingColor = Colors.red.shade700;
        } else if (percent <= 64) {
          rating = "Below Average Performance!";
          ratingColor = Colors.orange.shade800;
        } else if (percent <= 74) {
          rating = "Average Performance!";
          ratingColor = Colors.amber.shade800;
        } else if (percent <= 84) {
          rating = "Good Performance!";
          ratingColor = Colors.lightGreen.shade700;
        } else if (percent <= 90) {
          rating = "Very Good Performance!";
          ratingColor = Colors.green.shade700;
        } else {
          rating = "Excellent Performance!";
          ratingColor = const Color.fromARGB(255, 21, 159, 113);
        }

        return Column(
          children: [
            Text(
              rating,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: ratingColor,
              ),
            ),
            const SizedBox(height: 9),
          ],
        );
      }),

      Text(
        "You scored ${controller.totalMarksEarned} out of ${controller.totalMarks} marks",
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: Color(0xFF1B5E20)),
      ),
    ],
  ),
),

            const SizedBox(height: 10),

            // 2. Performance Summary Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Performance Summary", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0D473A))),
            ),
            const SizedBox(height: 20),

            // 3. Performance Cards – Only show if questions exist
                     // 3. Performance Cards – Dynamic spacing between cards only
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // MCQ Card
                  if (controller.mcqTotal > 0)
                    _buildPerformanceCard(
                      icon: Icons.radio_button_off_outlined,
                      iconColor: const Color(0xFF1976D2),
                      borderColor: const Color.fromARGB(255, 178, 220, 255),
                      title: "Multiple Choice Questions",
                      stats: "${controller.mcqCorrect}/${controller.mcqTotal} Correct     ${controller.mcqEarnedMarks}/${controller.mcqTotalMarks} marks",
                      percentage: controller.mcqPercentage,
                    ),

                  // Add spacing only if another card comes after MCQ
                  if (controller.mcqTotal > 0 && (controller.tfTotal > 0 || controller.fibTotal > 0))
                    const SizedBox(height: 16),

                  // True/False Card
                  if (controller.tfTotal > 0)
                    _buildPerformanceCard(
                      icon: Icons.check_circle_outline,
                      iconColor: const Color(0xFF388E3C),
                      borderColor: const Color(0xFFC8E6C8),
                      title: "True/False Questions",
                      stats: "${controller.tfCorrect}/${controller.tfTotal} Correct     ${controller.tfEarnedMarks}/${controller.tfTotalMarks} marks",
                      percentage: controller.tfPercentage,
                    ),

                  // Add spacing only if FIB comes after T/F
                  if (controller.tfTotal > 0 && controller.fibTotal > 0)
                    const SizedBox(height: 16),

                  // Fill in the Blanks Card (always last if present)
                  if (controller.fibTotal > 0)
                    _buildPerformanceCard(
                      icon: Icons.edit_outlined,
                      iconColor: const Color(0xFFFF8A65),
                      borderColor: const Color(0xFFFFCCBC),
                      title: "Fill in the Blanks",
                      stats: "${controller.fibCorrect}/${controller.fibTotal} Correct     ${controller.fibEarnedMarks}/${controller.fibTotalMarks} marks",
                      percentage: controller.fibPercentage,
                    ),

                  // No extra SizedBox needed after last card
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 4. Time Analysis – Your Special Rule Applied
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 1.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Transform.translate(
                          offset: const Offset(-8, 0),
                          child: const Icon(Icons.access_time_filled, color: Color.fromARGB(255, 99, 104, 99), size: 30),
                        ),
                        const SizedBox(width: 4),
                        const Text("Time Analysis", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Color(0xFF0D473A))),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildTimeRow(
                      label: "Total Time Used:",
                      value: _formatMinutes(controller.timeUsed),
                      valueColor: Colors.black87,
                    ),
                    const SizedBox(height: 10),
                    _buildTimeRow(
                      label: "Time Remaining:",
                      value: "${_formatRemainingMinutes(controller.timeUsed, controller.timeRemaining)} saved",
                      valueColor: const Color(0xFF2E7D32),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 5. Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                 ElevatedButton.icon(
  onPressed: controller.viewSolutions,
  icon: const Icon(Icons.visibility, size: 23),
  label: const Text("View Solutions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1976D2),
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 60),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
), 
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: controller.retakeTest,
                          icon: const Icon(Icons.refresh, size: 20),
                          label: const Text("Retake Test", style: TextStyle(fontWeight: FontWeight.bold)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.teal, width: 2),
                            foregroundColor: Colors.teal,
                            minimumSize: const Size(0, 56),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.downloadResult,
                          icon: const Icon(Icons.download, size: 20),
                          label: const Text("Download", style: TextStyle(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            foregroundColor: Colors.grey.shade700,
                            elevation: 0,
                            minimumSize: const Size(0, 56),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            side: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // Performance Card
  Widget _buildPerformanceCard({
    required IconData icon,
    required Color iconColor,
    required Color borderColor,
    required String title,
    required String stats,
    required int percentage,
  }) {
    final Color lightBgColor = iconColor.withOpacity(0.1);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: lightBgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 2.5),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 68),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A473A))),
                        const SizedBox(height: 6),
                        Text(stats, style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: iconColor.withOpacity(0.95))),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  const SizedBox(width: 68),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: percentage / 100.0,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                        minHeight: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 6,
            child: Center(
              child: Text("$percentage%", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: iconColor)),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 6,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 34),
            ),
          ),
        ],
      ),
    );
  }

  // Time Formatting – Your Special Rules
  String _formatMinutes(int minutes) {
    if (minutes <= 0) return "1 minute";
    if (minutes == 1) return "1 minute";
    return "$minutes minutes";
  }

  String _formatRemainingMinutes(int timeUsed, int timeRemaining) {
    int displayMinutes = timeUsed >= 2 ? timeRemaining + 1 : timeRemaining;
    if (displayMinutes <= 0) return "0 minutes";
    if (displayMinutes == 1) return "1 minute";
    return "$displayMinutes minutes";
  }

  Widget _buildTimeRow({required String label, required String value, required Color valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16.5, color: Colors.black87, fontWeight: FontWeight.w500)),
        Text(value, style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold, color: valueColor)),
      ],
    );
  }
}