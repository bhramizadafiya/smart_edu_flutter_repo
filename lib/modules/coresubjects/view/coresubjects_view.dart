// lib/modules/coresubjects/view/coresubjects_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/coresubjects_controller.dart';

class CoreSubjectsView extends GetView<CoreSubjectsController> {
  const CoreSubjectsView({super.key});

  double _responsiveTitle(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= 1024) return 22;
    if (w >= 700) return 21;
    return 18;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Class ${controller.classNumber} - Subjects", // Dynamic title
          style: TextStyle(
            color: const Color(0xFF0A4D3D),
            fontSize: _responsiveTitle(context),
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
      ),

      // ================= BODY =================
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final bool isMobile = width < 700;
          final bool isTablet = width >= 700 && width < 1024;
          final bool isDesktop = width >= 1024;

          final double horizontalPadding = isDesktop ? width * 0.08 : (isTablet ? 44 : 20);
          final double contentMaxWidth = isDesktop ? 1100 : (isTablet ? 900 : double.infinity);
          final double iconSize = isDesktop ? 92 : (isTablet ? 80 : 68);
          final double cardPadding = isDesktop ? 28 : (isTablet ? 24 : 18);
          final double headerBottomSpace = isDesktop ? 50 : (isTablet ? 40 : 50);

          return SingleChildScrollView(
            child: Column(
              children: [
                // ================= HEADER =================
                Container(
                  width: double.infinity,
                  color: const Color(0xFFF1FDF6),
                  padding: EdgeInsets.only(top: 24, bottom: headerBottomSpace),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentMaxWidth),
                      child: Column(
                        children: [
                          // FIXED GREEN GRADIENT CIRCLE (3 colors)
                          Container(
                            width: isDesktop ? 100 : (isTablet ? 84 : 66),
                            height: isDesktop ? 100 : (isTablet ? 84 : 66),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF66D1B2), // Light green
                                  Color(0xFF3BAA8F), // Medium green
                                  Color(0xFF1C524A), // Dark green
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${controller.classNumber}", // Dynamic number: 10, 11, 12
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isDesktop ? 32 : (isTablet ? 28 : 24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // DYNAMIC CLASS TITLE
                          Text(
                            controller.classTitle, // e.g., "Class 10th", "Class 11th Science"
                            style: TextStyle(
                              fontSize: isDesktop ? 30 : (isTablet ? 26 : 22),
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF0A3D33),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isDesktop ? 80 : (isTablet ? 60 : 28),
                            ),
                            child: const Text(
                              "Select a subject to access study materials,\npractice tests, and AI assistance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                color: Color(0xFF0A7860),
                                height: 1.55,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ================= MAIN CONTENT (UNCHANGED) =================
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentMaxWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),

                          const Text(
                            "Core Subjects",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0A4D3D),
                            ),
                          ),

                          const SizedBox(height: 24),

                          ...controller.coreSubjects.map((s) => Padding(
                                padding: const EdgeInsets.only(bottom: 18),
                                child: _buildSubjectCard(
                                  s,
                                  iconSize: iconSize,
                                  cardPadding: cardPadding,
                                  titleFontSize: isDesktop ? 26 : (isTablet ? 24 : 21),
                                  subtitleFontSize: isDesktop ? 16 : (isTablet ? 15 : 13.5),
                                ),
                              )),

                          const SizedBox(height: 16),

                          GestureDetector(
                            onTap: controller.toggleViewMore,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: isDesktop ? 26 : (isTablet ? 22 : 18),
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F7FA),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  Obx(() => Icon(
                                        controller.showAllSubjects.value ? Icons.remove : Icons.add,
                                        size: 26,
                                        color: const Color(0xFF7A8A99),
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
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xFF2D3748),
                                              ),
                                            )),
                                        const SizedBox(height: 4),
                                        const Text(
                                          "Hindi, Sanskrit, Social Science, IT & more",
                                          style: TextStyle(fontSize: 13, color: Color(0xFF718096)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF718096)),
                                ],
                              ),
                            ),
                          ),

                          Obx(() => controller.showAllSubjects.value
                              ? Column(
                                  children: controller.moreSubjects
                                      .map((s) => Padding(
                                            padding: const EdgeInsets.only(top: 18),
                                            child: _buildSubjectCard(
                                              s,
                                              iconSize: iconSize,
                                              cardPadding: cardPadding,
                                              titleFontSize: isDesktop ? 26 : (isTablet ? 24 : 21),
                                              subtitleFontSize: isDesktop ? 16 : (isTablet ? 15 : 13.5),
                                            ),
                                          ))
                                      .toList(),
                                )
                              : const SizedBox()),

                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubjectCard(
    Map<String, dynamic> s, {
    required double iconSize,
    required double cardPadding,
    required double titleFontSize,
    required double subtitleFontSize,
  }) {
    final String title = s["title"];
    final String subtitle = s["subtitle"];
    final List<Color> iconGradient = s["gradientColors"] as List<Color>;

    final Widget centerWidget = title == "Physics"
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
            }[title] ??
                Icons.book_rounded,
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
          border: Border.all(color: Colors.grey.shade200),
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
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: iconGradient),
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
                      height: 1.4,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 20, color: Color(0xFF3BAA8F)),
          ],
        ),
      ),
    );
  }
}