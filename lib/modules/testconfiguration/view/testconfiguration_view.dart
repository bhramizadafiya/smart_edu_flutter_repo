// lib/modules/testconfiguration/views/test_configuration_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/testconfiguration/controller/testconfiguration_controller.dart';

class TestConfigurationView extends GetView<TestConfigurationController> {
  const TestConfigurationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Horizontal padding for responsiveness
    final horizontalPadding = screenWidth < 360
        ? 12.0
        : screenWidth < 600
            ? 16.0
            : 24.0;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Configure Your Test",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 14, 49, 34)),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
      ),
      body: Stack(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            // Max width for larger screens
            final maxWidth = constraints.maxWidth > 900 ? 900.0 : constraints.maxWidth;

            return Center(
              child: SizedBox(
                width: maxWidth,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header - Light Green
                      Container(
                        width: double.infinity,
                        color: const Color.fromARGB(255, 241, 255, 250),
                        padding: EdgeInsets.only(
                          top: 32,
                          bottom: 24,
                          left: horizontalPadding,
                          right: horizontalPadding,
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.settings_outlined,
                                color: Color.fromARGB(255, 14, 49, 34),
                                size: 42),
                            const SizedBox(height: 16),
                            const Text(
                              "Customize Your Test",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(255, 14, 49, 34)),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Configure question types, duration, and difficulty to match your preparation needs.",
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black87, height: 1.5),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Question Types
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: const Text(
                          "Question Types",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 14, 49, 34)),
                        ),
                      ),
                      const SizedBox(height: 9),

                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Column(
                          children: [
                            _buildQuestionTypeCard(
                              title: "Multiple Choice Questions",
                              subtitle: "Single correct answer from 4 options",
                              value: controller.multipleChoice,
                              checkboxColor: Colors.blue.shade600,
                            ),
                            _buildQuestionTypeCard(
                              title: "True/False Questions",
                              subtitle: "Choose between True or False",
                              value: controller.trueFalse,
                              checkboxColor: Colors.green.shade600,
                            ),
                            _buildQuestionTypeCard(
                              title: "Fill in the Blanks",
                              subtitle: "Type the correct answer",
                              value: controller.fillInTheBlanks,
                              checkboxColor: Colors.red.shade600,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Test Duration
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: double.infinity, height: 1, color: Colors.grey.shade300),
                          Container(
                            color: const Color(0xFFF8FBFF),
                            padding: EdgeInsets.fromLTRB(
                                horizontalPadding, 16, horizontalPadding, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Test Duration",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Color.fromARGB(255, 17, 61, 42),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Obx(() => Column(
                                      children: controller.durationOptions
                                          .map((option) {
                                        final String key = option['key'];
                                        final String title = option['title'];
                                        final String? duration = option['duration'];
                                        final String? subtitle = option['subtitle'];
                                        final bool isCustom = option['isCustom'] == true;
                                        final bool isSelected =
                                            controller.selectedDuration.value == key;

                                        return _buildDurationCard(
                                          key: key,
                                          title: title,
                                          durationText: duration,
                                          subtitle: subtitle,
                                          isCustom: isCustom,
                                          isSelected: isSelected,
                                        );
                                      }).toList(),
                                    )),
                              ],
                            ),
                          ),
                          Container(width: double.infinity, height: 1, color: Colors.grey.shade300),
                          const SizedBox(height: 16),
                        ],
                      ),

                      // Difficulty Level
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: const Text(
                          "Difficulty Level",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 14, 49, 34)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Obx(() => Row(
                              children: [
                                _difficultyChip(
                                  label: "Easy",
                                  icon: Icons.sentiment_very_satisfied,
                                  isSelected: controller.selectedDifficulties.contains("Easy"),
                                  bgColor: const Color.fromARGB(255, 238, 255, 248),
                                  borderColor: const Color.fromARGB(255, 36, 203, 131),
                                  textColor: Colors.green.shade700,
                                ),
                                const SizedBox(width: 10),
                                _difficultyChip(
                                  label: "Medium",
                                  icon: Icons.sentiment_neutral,
                                  isSelected: controller.selectedDifficulties.contains("Medium"),
                                  bgColor: const Color.fromARGB(255, 240, 249, 255),
                                  borderColor: Colors.blue,
                                  textColor: Colors.blue.shade700,
                                ),
                                const SizedBox(width: 10),
                                _difficultyChip(
                                  label: "Hard",
                                  icon: Icons.sentiment_very_dissatisfied,
                                  isSelected: controller.selectedDifficulties.contains("Hard"),
                                  bgColor: const Color.fromARGB(255, 255, 245, 247),
                                  borderColor: Colors.red,
                                  textColor: Colors.red.shade700,
                                ),
                              ],
                            )),
                      ),

                      const SizedBox(height: 25),

                      // AI Customization
                      Obx(() => Column(
                            children: [
                              Container(width: double.infinity, height: 1, color: Colors.grey.shade300),
                              GestureDetector(
                                onTap: () => controller.aiCustomization.value = !controller.aiCustomization.value,
                                child: Container(
                                  width: double.infinity,
                                  color: const Color.fromARGB(255, 239, 255, 248),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.auto_awesome,
                                              color: Color.fromARGB(255, 36, 203, 131),
                                              size: 30),
                                          const SizedBox(width: 12),
                                          const Text("AI Customization (Optional)",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w900,
                                                  color: Color.fromARGB(255, 32, 185, 119))),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Add specific instructions for AI to customize your test content",
                                        style: TextStyle(
                                            fontSize: 14.5,
                                            color: Color.fromARGB(255, 29, 166, 106),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      const SizedBox(height: 18),

                                      // Custom Prompt Box
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: controller.aiCustomization.value
                                                ? const Color.fromARGB(255, 31, 176, 113)
                                                : Colors.grey.shade300,
                                            width: 1.8,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Custom Prompt",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w900,
                                                    color: controller.aiCustomization.value
                                                        ? const Color.fromARGB(255, 28, 153, 99)
                                                        : Colors.grey.shade700)),
                                            const SizedBox(height: 8),
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(18),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade50,
                                                borderRadius: BorderRadius.circular(7),
                                                border: Border.all(color: Colors.grey.shade300, width: 1.8),
                                              ),
                                              child: const Text(
                                                "Focus on calculus problems involving derivatives and integration, include real-world applications and step-by-step solutions.",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black87,
                                                    height: 1.6,
                                                    fontWeight: FontWeight.w600),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),

                                      // Pro Tips
                                      Container(
                                        padding: const EdgeInsets.all(18),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            borderRadius: BorderRadius.circular(16)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(children: [
                                              Icon(Icons.tips_and_updates,
                                                  color: Colors.orange.shade700, size: 16),
                                              const SizedBox(width: 10),
                                              const Text("Pro Tips",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.orange))
                                            ]),
                                            const SizedBox(height: 14),
                                            const Text("• Be specific about topics you want to focus on",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w500)),
                                            const SizedBox(height: 8),
                                            const Text("• Mention difficulty level preferences for specific areas",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w500)),
                                            const SizedBox(height: 8),
                                            const Text("• Request particular question formats or styles",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w500)),
                                            const SizedBox(height: 8),
                                            const Text("• Ask for explanations or step-by-step solutions",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 1.5,
                                  color: const Color.fromARGB(255, 32, 188, 110)),
                            ],
                          )),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }),

          // Fixed "Next" Button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                onPressed: controller.goToNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 5, 35, 9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 10,
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Question Type Card
  Widget _buildQuestionTypeCard({
    required String title,
    required String subtitle,
    required RxBool value,
    required Color checkboxColor,
  }) {
    return Obx(() => Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
            side: BorderSide(
              color: Colors.grey.shade300,
              width: 1.8,
            ),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => value.value = !value.value,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: value.value ? checkboxColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        color:
                            value.value ? checkboxColor : Colors.grey.shade400,
                        width: 1.8,
                      ),
                    ),
                    child: value.value
                        ? const Icon(Icons.check, color: Colors.white, size: 15)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: value.value
                                ? const Color.fromARGB(255, 14, 49, 34)
                                : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style:
                              TextStyle(fontSize: 13.5, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // Duration Card
  Widget _buildDurationCard({
    required String key,
    required String title,
    String? durationText,
    String? subtitle,
    required bool isCustom,
    required bool isSelected,
  }) {
    final Color cardBgColor =
        isSelected ? const Color.fromARGB(255, 245, 255, 245) : Colors.white;
    final Color primaryTextColor = isSelected ? Colors.black87 : Colors.grey.shade600;
    final Color subtitleColor =
        isSelected ? const Color.fromARGB(255, 78, 175, 255) : Colors.grey.shade600;

    return Card(
      elevation: 0,
      color: cardBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11),
        side: BorderSide(
          color: isSelected ? const Color.fromARGB(255, 55, 155, 255) : Colors.grey.shade300,
          width: isSelected ? 2.4 : 1.3,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => controller.selectDuration(key),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<String>(
                value: key,
                groupValue: controller.selectedDuration.value,
                activeColor: const Color.fromARGB(255, 55, 155, 255),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (_) => controller.selectDuration(key),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: primaryTextColor,
                      ),
                    ),
                    SizedBox(height: isCustom ? 10 : 4),
                    if (!isCustom)
                      Text(
                        durationText ?? "",
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: primaryTextColor,
                        ),
                      )
                    else
                      Row(
                        children: [
                          SizedBox(
                            width: 56,
                            height: 38,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  value: controller.customHours.value,
                                  isExpanded: true,
                                  isDense: true,
                                  icon: const SizedBox.shrink(),
                                  alignment: Alignment.center,
                                  selectedItemBuilder: (_) => controller.hoursList
                                      .map((h) => Center(
                                            child: Text(
                                              h.toString().padLeft(2, '0'),
                                              style: TextStyle(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w700,
                                                color: primaryTextColor,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  items: controller.hoursList
                                      .map((h) => DropdownMenuItem(
                                            value: h,
                                            child: Center(
                                                child: Text(h.toString().padLeft(2, '0'))),
                                          ))
                                      .toList(),
                                  onChanged:
                                      isSelected ? (v) => controller.customHours.value = v! : null,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Text("hours",
                                style: TextStyle(fontSize: 11.5, color: Colors.grey)),
                          ),
                          SizedBox(
                            width: 56,
                            height: 38,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  value: controller.customMinutes.value,
                                  isExpanded: true,
                                  isDense: true,
                                  icon: const SizedBox.shrink(),
                                  alignment: Alignment.center,
                                  selectedItemBuilder: (_) => controller.minutesList
                                      .map((m) => Center(
                                            child: Text(
                                              m.toString().padLeft(2, '0'),
                                              style: TextStyle(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w700,
                                                color: primaryTextColor,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  items: controller.minutesList
                                      .map((m) => DropdownMenuItem(
                                            value: m,
                                            child: Center(
                                                child: Text(m.toString().padLeft(2, '0'))),
                                          ))
                                      .toList(),
                                  onChanged:
                                      isSelected ? (v) => controller.customMinutes.value = v! : null,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Text("minutes",
                                style: TextStyle(fontSize: 11.5, color: Colors.grey)),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              if (subtitle != null && !isCustom)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SizedBox(
                    width: 150,
                    child: Center(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 11.8,
                          fontWeight: FontWeight.w600,
                          color: subtitleColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Difficulty Chip
  Widget _difficultyChip({
    required String label,
    required IconData icon,
    required bool isSelected,
    required Color bgColor,
    required Color borderColor,
    required Color textColor,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.toggleDifficulty(label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ? bgColor : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: isSelected ? borderColor : Colors.grey.shade300,
                width: isSelected ? 1.9 : 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: isSelected ? textColor : Colors.grey.shade600, size: 22),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? textColor : Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }
}
