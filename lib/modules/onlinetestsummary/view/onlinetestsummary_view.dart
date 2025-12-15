// lib/modules/onlinetestsummary/view/onlinetestsummary_view.dart
import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:smarted/modules/onlinetestsummary/controller/onlinetestsummary_controller.dart';

class OnlineTestSummaryView extends GetView<OnlineTestSummaryController> {
  const OnlineTestSummaryView({super.key});

  final Color fibColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 35, 9),
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Mathematics Mock Test',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.computer,
                color: Color.fromARGB(255, 5, 35, 9),
                size: 26,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Question Types',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 14, 56, 15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // MCQ - Always visible
                _buildQuestionTypeCard(
                  color: Colors.blue,
                  typeIcon: Icons.radio_button_unchecked,
                  title: 'Multiple Choice Questions',
                  subtitle: 'Single correct answer from 4 options',
                  questions: controller.mcqQuestions,
                  marks: controller.mcqMarksPerQ,
                  negative: RxInt(0),
                  totalObs: controller.mcqTotal,
                  totalText: 'Total MCQ Marks:',
                  isMcqNumberOfQuestions: true,
                  showObs: controller.showMcq,
                ),
                const SizedBox(height: 16),

                // True/False - Always visible
                _buildQuestionTypeCard(
                  color: const Color.fromARGB(255, 32, 166, 126),
                  typeIcon: Icons.check_circle_outline,
                  title: 'True/False Questions',
                  subtitle: 'Choose between True or False',
                  questions: controller.tfQuestions,
                  marks: controller.tfMarksPerQ,
                  negative: RxInt(0),
                  totalObs: controller.tfTotal,
                  totalText: 'Total T/F Marks:',
                  isMcqNumberOfQuestions: false,
                  showObs: controller.showTf,
                ),
                const SizedBox(height: 16),

                // Fill in the Blanks - Always visible
                _buildQuestionTypeCard(
                  color: fibColor,
                  typeIcon: Icons.space_bar,
                  title: 'Fill in the Blanks',
                  subtitle: 'Type the correct answer in the blank',
                  questions: controller.fibQuestions,
                  marks: controller.fibMarksPerQ,
                  negative: RxInt(0),
                  totalObs: controller.fibTotal,
                  totalText: 'Total FIB Marks:',
                  isMcqNumberOfQuestions: false,
                  showObs: controller.showFib,
                ),

                const SizedBox(height: 25),
                Container(height: 1.5, color: Colors.grey.shade300),
                const SizedBox(height: 5),

                // TEST SUMMARY
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 255, 242),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 1,
                        color: Color.fromARGB(255, 32, 166, 126),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Test Summary',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 26, 168, 126),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Obx(() => _summaryItem(
                                'Total Questions:',
                                '${controller.totalQuestions.value}',
                                isBoldValue: true)),
                            const SizedBox(height: 12),
                            Obx(() => _summaryItem(
                                'Total Marks:',
                                '${controller.totalMarks.value} marks',
                                isBoldValue: true)),
                            const SizedBox(height: 12),
                            Obx(() => _summaryItem(
                                'Duration:', controller.testDuration,
                                isBoldValue: true)),
                            const SizedBox(height: 12),
                            Obx(() => _summaryItem(
                                'Difficulty:', controller.difficulty.value,
                                isBoldValue: true)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),

          // Bottom Buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.goToPrevious,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 243, 243, 243),
                        foregroundColor: Colors.grey.shade700,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_ios_new,
                              size: 18,
                              color: Color.fromARGB(255, 117, 117, 117)),
                          SizedBox(width: 8),
                          Text('Previous',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.totalQuestions.value == 0
                          ? null
                          : controller.startTest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 5, 35, 9),
                        foregroundColor: Colors.white,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Next',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_ios, size: 22),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionTypeCard({
  required Color color,
  required IconData typeIcon,
  required String title,
  required String subtitle,
  required RxInt questions,
  required RxInt marks,
  required RxInt negative,
  required RxInt totalObs,
  required String totalText,
  required bool isMcqNumberOfQuestions,
  required RxBool showObs,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Perfect vertical centering
              children: [
                // Larger Checkbox with minimal padding
                Obx(() => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0), // Very tight left/right
                      child: Transform.scale(
                        scale: 1.2, // Increases checkbox size significantly (adjust as needed: 1.4, 1.6, etc.)
                        child: Checkbox(
                          value: showObs.value,
                          activeColor: color,
                          checkColor: Colors.white,
                          side: BorderSide(color: color, width: 2), // Thicker border for larger look
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onChanged: (bool? value) {
                            showObs.value = value ?? false;
                          },
                        ),
                      ),
                    )),

              // Slightly more space after larger checkbox

                // Icon circle
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(typeIcon, color: color, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 19, 60, 21),
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _counterRow('Number of Questions:', questions,
                lightBorder: isMcqNumberOfQuestions),
            const SizedBox(height: 12),
            _counterRow('Marks per Question:', marks),
            const SizedBox(height: 12),
            _counterRow('Negative Marks per Question:', negative),
            const SizedBox(height: 16),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(totalText, style: const TextStyle(fontSize: 16)),
                    Text(
                      '${totalObs.value} marks',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ),
  );
}

  Widget _counterRow(String label, RxInt value, {bool lightBorder = false}) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _btn(() => controller.updateValue(value, -1), Icons.remove),
            const SizedBox(width: 8),
            Container(
              width: 56,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: lightBorder ? Colors.blue.shade200 : Colors.green,
                    width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(() => Text(
                    '${value.value}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(width: 8),
            _btn(() => controller.updateValue(value, 1), Icons.add),
          ],
        ),
      ],
    );
  }

  Widget _btn(VoidCallback onTap, IconData icon) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }

  Widget _summaryItem(String label, String value,
      {bool isBoldValue = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 79, 78, 78),
              fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight:
                isBoldValue ? FontWeight.bold : FontWeight.normal,
            color: isBoldValue
                ? const Color.fromARGB(255, 26, 168, 126)
                : Colors.black,
          ),
        ),
      ],
    );
  }
}