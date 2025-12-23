// lib/modules/coresubjects/view/coresubjects_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/coresubjects_controller.dart';

class CoreSubjectsView extends GetView<CoreSubjectsController> {
  const CoreSubjectsView({super.key});

  // Unified responsive scaling helper
  double _scale(BuildContext context, double base,
      {double mobile = 1.0, double tablet = 1.15, double desktop = 1.35}) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) return base * desktop;
    if (width >= 700) return base * tablet;
    return base * mobile;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 700;
    final bool isTablet = width >= 700 && width < 1024;
    final bool isDesktop = width >= 1024;

    final double horizontalPadding = isDesktop ? width * 0.12 : (isTablet ? 48 : 20);
    final double contentMaxWidth = isDesktop ? 1280 : (isTablet ? 980 : double.infinity);

    // Smaller icon sizes as requested
    final double iconSize = _scale(context, 65, mobile: 0.92, tablet: 1.1, desktop: 1.25); // Reduced from 68
    final double cardPadding = _scale(context, 12, mobile: 1.0, tablet: 1.25, desktop: 1.4);
    final double headerBottomSpace = _scale(context, 48, mobile: 1.0, tablet: 0.9, desktop: 1.1);

    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  centerTitle: true,
  title: Text(
    "Class ${controller.classNumber} - Subjects",
    style: TextStyle(
      color: const Color(0xFF0A4D3D),
      fontSize: _scale(context, 18, tablet: 1.12, desktop: 1.25),
      fontWeight: FontWeight.w800,
    ),
  ),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black87),
    onPressed: () => Get.back(),
  ),
  bottom: const PreferredSize(
    preferredSize: Size.fromHeight(1.0), // Height of the divider
    child: Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFD8D8D8), // Light grey thin border
    ),
  ),
),

      // ================= BODY =================
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // ================= HEADER =================
                Container(
                  width: double.infinity,
                  color: const Color(0xFFF1FDF6),
                  padding: EdgeInsets.only(top: 28, bottom: headerBottomSpace),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentMaxWidth),
                      child: Column(
                        children: [
                          // Smaller Gradient Circle
                          Container(
                            width: iconSize * 1.05,
                            height: iconSize * 1.05,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF66D1B2),
                                  Color(0xFF3BAA8F),
                                  Color(0xFF1C524A),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${controller.classNumber}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: iconSize * 0.42, // Adjusted for smaller size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            controller.classTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: _scale(context, 22, tablet: 1.18, desktop: 1.35),
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF0A3D33),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isDesktop ? 120 : (isTablet ? 90 : 36),
                            ),
                            child: Text(
                              "Select a subject to access study materials, practice tests, and AI assistance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: _scale(context, 14.5, tablet: 1.1, desktop: 1.15),
                                color: const Color(0xFF0A7860),
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ================= MAIN CONTENT =================
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentMaxWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          Text(
                            "Core Subjects",
                            style: TextStyle(
                              fontSize: _scale(context, 21, tablet: 1.1, desktop: 1.2),
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF0A4D3D),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Core Subjects Cards
                          ...controller.coreSubjects.map((s) => Padding(
                                padding: const EdgeInsets.only(bottom: 18),
                                child: _buildSubjectCard(
                                  s,
                                  iconSize: iconSize,
                                  cardPadding: cardPadding,
                                  titleFontSize: _scale(context, 19, tablet: 1.15, desktop: 1.25),
                                  subtitleFontSize: _scale(context, 13, tablet: 1.12, desktop: 1.2),
                                ),
                              )),

                          const SizedBox(height: 3),

                          // View More Button
                          GestureDetector(
                            onTap: controller.toggleViewMore,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: _scale(context, 12, tablet: 1.2, desktop: 1.35),
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F7FA),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade300, width: 1),
                              ),
                              child: Row(
                                children: [
                                  Obx(() => Icon(
                                        controller.showAllSubjects.value
                                            ? Icons.remove
                                            : Icons.add,
                                        size: _scale(context, 24),
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
                                              style: TextStyle(
                                                fontSize: _scale(context, 15.5),
                                                fontWeight: FontWeight.w900,
                                                color: const Color(0xFF2D3748),
                                              ),
                                            )),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Hindi, Sanskrit, Social Science, IT & more",
                                          style: TextStyle(
                                            fontSize: _scale(context, 12.5, desktop: 1.05),
                                            color: const Color(0xFF718096),
                                          ),
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
                                              titleFontSize: _scale(context, 20, tablet: 1.15, desktop: 1.25),
                                              subtitleFontSize: _scale(context, 13, tablet: 1.12, desktop: 1.2),
                                            ),
                                          ))
                                      .toList(),
                                )
                              : const SizedBox(height: 24)),

                          const SizedBox(height: 60),
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
    final List<Color> iconGradient = List<Color>.from(s["gradientColors"]);

    final Widget centerWidget = title == "Physics"
        ? Text(
            "En",
            style: TextStyle(
              color: Colors.white,
              fontSize: iconSize * 0.42, // Adjusted for smaller icon
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
            size: iconSize * 0.52, // Slightly smaller icon inside circle
            color: Colors.white,
          );

    return GestureDetector(
      onTap: () => controller.onSubjectTap(title),
      child: Container(
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Smaller Circle Avatar
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: iconGradient),
              ),
              child: Center(child: centerWidget),
            ),

            const SizedBox(width: 12),

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
                  const SizedBox(height: 1),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      height: 1.45,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: titleFontSize * 0.85,
              color: const Color(0xFF3BAA8F),
            ),
          ],
        ),
      ),
    );
  }
}