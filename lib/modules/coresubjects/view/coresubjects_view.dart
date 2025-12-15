// lib/modules/coresubjects/view/coresubjects_view.dart

import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../controller/coresubjects_controller.dart';

class CoreSubjectsView extends GetView<CoreSubjectsController> {
  const CoreSubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;
    final double horizontalPadding = isTablet ? 40 : 20;
    final double cardPadding = isTablet ? 24 : 20;
    final double iconSize = isTablet ? 80 : 72;
    final double titleFontSize = isTablet ? 25 : 23;
    final double subtitleFontSize = isTablet ? 15 : 14;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Class 11 - Subjects",
          style: TextStyle(
            color: const Color(0xFF0A4D3D),
            fontSize: isTablet ? 21 : 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.offAllNamed('/dashboard'),
        ),
      ),

      body: Column(
        children: [
          // Top Header - Responsive
          Container(
            width: double.infinity,
            color: const Color(0xFFF1FDF6),
            padding: EdgeInsets.only(top: 20, bottom: isTablet ? 40 : 30),
            child: Column(
              children: [
                Container(
                  width: isTablet ? 80 : 64,
                  height: isTablet ? 80 : 64,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF66D1B2), Color(0xFF3BAA8F), Color(0xFF1C524A)],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "11",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isTablet ? 32 : 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Class 11 Science",
                  style: TextStyle(
                    fontSize: isTablet ? 26 : 23,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0A3D33),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    "Select a subject to access study materials,\npractice tests, and AI assistance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 14.5,
                      color: const Color(0xFF0A7860),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(horizontalPadding),
              children: [
                Text(
                  "Core Subjects",
                  style: TextStyle(
                    fontSize: isTablet ? 24 : 22,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF0A4D3D),
                  ),
                ),
                const SizedBox(height: 20),

                // Core Subjects - Responsive Cards
                ...controller.coreSubjects.map((s) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildSubjectCard(
                        s,
                        iconSize: iconSize,
                        cardPadding: cardPadding,
                        titleFontSize: titleFontSize,
                        subtitleFontSize: subtitleFontSize,
                      ),
                    )),

                const SizedBox(height: 12),

                // View More / View Less Button - Full Width & Responsive
                GestureDetector(
                  onTap: controller.toggleViewMore,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: isTablet ? 20 : 16,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Row(
                      children: [
                        Obx(() => Icon(
                              controller.showAllSubjects.value
                                  ? Icons.remove
                                  : Icons.add,
                              color: const Color(0xFF7A8A99),
                              size: isTablet ? 28 : 26,
                            )),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                    controller.showAllSubjects.value
                                        ? "View Less Subjects"
                                        : "View More Subjects",
                                    style: TextStyle(
                                      fontSize: isTablet ? 17 : 16,
                                      fontWeight: FontWeight.w900,
                                      color: const Color(0xFF2D3748),
                                    ),
                                  )),
                              Text(
                                "Hindi, Sanskrit, Social Science, IT & more",
                                style: TextStyle(
                                  fontSize: isTablet ? 14 : 13,
                                  color: const Color(0xFF718096),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Color(0xFF718096),
                        ),
                      ],
                    ),
                  ),
                ),

                // More Subjects - Appear on toggle
                Obx(() => controller.showAllSubjects.value
                    ? Column(
                        children: controller.moreSubjects
                            .map((s) => Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: _buildSubjectCard(
                                    s,
                                    iconSize: iconSize,
                                    cardPadding: cardPadding,
                                    titleFontSize: titleFontSize,
                                    subtitleFontSize: subtitleFontSize,
                                  ),
                                ))
                            .toList(),
                      )
                    : const SizedBox()),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Responsive Subject Card
  Widget _buildSubjectCard(
    Map<String, dynamic> s, {
    required double iconSize,
    required double cardPadding,
    required double titleFontSize,
    required double subtitleFontSize,
  }) {
    final String title = s["title"];
    final String subtitle = s["subtitle"];
    final Color mainColor = s["color"];

    final List<Color> iconGradient = (s["gradientColors"] as List<Color>?) ??
        [mainColor.withOpacity(0.9), mainColor, mainColor.withOpacity(0.7)];

    final Widget centerWidget = (title == "Physics")
        ? Text(
            "En",
            style: TextStyle(
              color: Colors.white,
              fontSize: iconSize * 0.45,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          )
        : Icon(
            {
              "Mathematics": Icons.calculate_rounded,
              "Science": Icons.science_rounded,
              "Chemistry": Icons.biotech_rounded,
              "Biology": Icons.local_florist_rounded,
              "English": Icons.menu_book_rounded,
              "Hindi": Icons.record_voice_over_rounded,
              "Sanskrit": Icons.auto_stories_rounded,
              "Social Science": Icons.public_rounded,
              "IT": Icons.computer_rounded,
            }[title] ?? Icons.book_rounded,
            size: iconSize * 0.55,
            color: Colors.white,
          );

    return GestureDetector(
      onTap: () => controller.onSubjectTap(title),
      child: Container(
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Gradient Icon Circle
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: iconGradient,
                ),
              ),
              child: Center(child: centerWidget),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF0A3D33),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: const Color(0xFF3BAA8F),
            ),
          ],
        ),
      ),
    );
  }
}