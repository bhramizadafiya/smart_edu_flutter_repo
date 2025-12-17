import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/testresult_controller.dart';

class TestResultView extends GetView<TestResultController> {
  const TestResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = (screenWidth / 360).clamp(0.85, 1.25);

    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 55 * scale,
        leading: Container(
          margin: EdgeInsets.all(10 * scale),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.emoji_events,
            color: const Color(0xFF1B5E20),
            size: 28 * scale,
          ),
        ),
        title: Column(
          children: [
            Text(
              "Test Completed!",
              style: TextStyle(
                fontSize: 20 * scale,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3 * scale),
            Text(
              "Mathematics Mock Test",
              style: TextStyle(
                fontSize: 15 * scale,
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          color: const Color.fromARGB(255, 10, 47, 12),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32 * scale),
          ),
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= SCORE SECTION =================
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 243, 255, 251),
              padding: EdgeInsets.fromLTRB(
                0,
                30 * scale,
                0,
                10 * scale,
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 140 * scale,
                        height: 140 * scale,
                        child: CircularProgressIndicator(
                          value: controller.overallPercentage / 100,
                          strokeWidth: 14 * scale,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: const AlwaysStoppedAnimation(
                            Color.fromARGB(255, 29, 161, 117),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${controller.overallPercentage}%",
                            style: TextStyle(
                              fontSize: 35 * scale,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 29, 161, 117),
                            ),
                          ),
                          Text(
                            "Score",
                            style: TextStyle(
                              fontSize: 20 * scale,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 38, 109, 77),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 18 * scale),

                  // ================= PERFORMANCE RATING =================
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
                      ratingColor =
                          const Color.fromARGB(255, 21, 159, 113);
                    }

                    return Column(
                      children: [
                        Text(
                          rating,
                          style: TextStyle(
                            fontSize: 23 * scale,
                            fontWeight: FontWeight.w800,
                            color: ratingColor,
                          ),
                        ),
                        SizedBox(height: 9 * scale),
                      ],
                    );
                  }),

                  Text(
                    "You scored ${controller.totalMarksEarned} out of ${controller.totalMarks} marks",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19 * scale,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1B5E20),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10 * scale),

            // ================= PERFORMANCE SUMMARY =================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * scale),
              child: Text(
                "Performance Summary",
                style: TextStyle(
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0D473A),
                ),
              ),
            ),

            SizedBox(height: 20 * scale),

            // ================= PERFORMANCE CARDS =================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: Column(
                children: [
                  if (controller.mcqTotal > 0)
                    _buildPerformanceCard(
                      icon: Icons.radio_button_off_outlined,
                      iconColor: const Color(0xFF1976D2),
                      borderColor:
                          const Color.fromARGB(255, 178, 220, 255),
                      title: "Multiple Choice Questions",
                      stats:
                          "${controller.mcqCorrect}/${controller.mcqTotal} Correct     ${controller.mcqEarnedMarks}/${controller.mcqTotalMarks} marks",
                      percentage: controller.mcqPercentage,
                      scale: scale,
                    ),

                  if (controller.tfTotal > 0)
                    Padding(
                      padding: EdgeInsets.only(top: 16 * scale),
                      child: _buildPerformanceCard(
                        icon: Icons.check_circle_outline,
                        iconColor: const Color(0xFF388E3C),
                        borderColor: const Color(0xFFC8E6C8),
                        title: "True/False Questions",
                        stats:
                            "${controller.tfCorrect}/${controller.tfTotal} Correct     ${controller.tfEarnedMarks}/${controller.tfTotalMarks} marks",
                        percentage: controller.tfPercentage,
                        scale: scale,
                      ),
                    ),

                  if (controller.fibTotal > 0)
                    Padding(
                      padding: EdgeInsets.only(top: 16 * scale),
                      child: _buildPerformanceCard(
                        icon: Icons.edit_outlined,
                        iconColor: const Color(0xFFFF8A65),
                        borderColor: const Color(0xFFFFCCBC),
                        title: "Fill in the Blanks",
                        stats:
                            "${controller.fibCorrect}/${controller.fibTotal} Correct     ${controller.fibEarnedMarks}/${controller.fibTotalMarks} marks",
                        percentage: controller.fibPercentage,
                        scale: scale,
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 30 * scale),

            // ================= TIME ANALYSIS =================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: Container(
                padding: EdgeInsets.all(18 * scale),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12 * scale),
                  border: Border.all(color: Colors.grey.shade300, width: 1.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time_filled,
                            size: 28 * scale,
                            color: Colors.grey.shade600),
                        SizedBox(width: 6 * scale),
                        Text(
                          "Time Analysis",
                          style: TextStyle(
                            fontSize: 21 * scale,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14 * scale),
                    _buildTimeRow(
                      label: "Total Time Used:",
                      value: _formatMinutes(controller.timeUsed),
                      valueColor: Colors.black87,
                      scale: scale,
                    ),
                    SizedBox(height: 10 * scale),
                    _buildTimeRow(
                      label: "Time Remaining:",
                      value:
                          "${_formatRemainingMinutes(controller.timeUsed, controller.timeRemaining)} saved",
                      valueColor: const Color(0xFF2E7D32),
                      scale: scale,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30 * scale),

            // ================= ACTION BUTTONS =================
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: Column(
                children: [

                  // View Solutions
                  ElevatedButton.icon(
                    onPressed: controller.viewSolutions,
                    icon: Icon(Icons.visibility, size: 22 * scale),
                    label: Text(
                      "View Solutions",
                      style: TextStyle(
                        fontSize: 18 * scale,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      foregroundColor: Colors.white,
                      minimumSize:
                          Size(double.infinity, 60 * scale),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14 * scale),
                      ),
                    ),
                  ),

                  SizedBox(height: 16 * scale),

                  // Retake + Download
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: controller.retakeTest,
                          icon: Icon(Icons.refresh, size: 20 * scale),
                          label: Text(
                            "Retake Test",
                            style: TextStyle(
                              fontSize: 15 * scale,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.teal,
                              width: 2,
                            ),
                            foregroundColor: Colors.teal,
                            minimumSize: Size(0, 56 * scale),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14 * scale),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16 * scale),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.downloadResult,
                          icon:
                              Icon(Icons.download, size: 20 * scale),
                          label: Text(
                            "Download",
                            style: TextStyle(
                              fontSize: 15 * scale,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.grey.shade100,
                            foregroundColor:
                                Colors.grey.shade700,
                            elevation: 0,
                            minimumSize: Size(0, 56 * scale),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14 * scale),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 40 * scale),
          ],
        ),
      ),
    );
  }

  // ================= PERFORMANCE CARD =================
  Widget _buildPerformanceCard({
    required IconData icon,
    required Color iconColor,
    required Color borderColor,
    required String title,
    required String stats,
    required int percentage,
    required double scale,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.all(8 * scale),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(18 * scale),
            border: Border.all(color: borderColor, width: 2.5),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28 * scale,
                backgroundColor: iconColor,
                child: Icon(icon,
                    color: Colors.white, size: 32 * scale),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 6 * scale),
                    Text(stats,
                        style: TextStyle(
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 8 * scale),
                    LinearProgressIndicator(
                      value: percentage / 100,
                      minHeight: 5 * scale,
                      backgroundColor: Colors.grey.shade300,
                      valueColor:
                          AlwaysStoppedAnimation(iconColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8 * scale),
              Text(
                "$percentage%",
                style: TextStyle(
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.bold,
                    color: iconColor),
              ),
            ],
          ),
        );
      },
    );
  }

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

  Widget _buildTimeRow({
    required String label,
    required String value,
    required Color valueColor,
    required double scale,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16 * scale)),
        Text(value,
            style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.bold,
                color: valueColor)),
      ],
    );
  }
}
