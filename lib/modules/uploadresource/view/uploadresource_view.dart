import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/uploadresource_controller.dart';

class UploadResourceView extends GetView<UploadResourceController> {
  const UploadResourceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // =======================
      // APP BAR (UNCHANGED)
      // =======================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () => Get.back(),
              ),
              title: Obx(
                () => Text(
                  controller.subjectName.value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0A4D3C),
                  ),
                ),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.more_vert, color: Colors.black87),
                ),
              ],
            ),
            Container(height: 0.8, color: Colors.grey.shade300),
          ],
        ),
      ),

      // =======================
      // BODY (RESPONSIVE)
      // =======================
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final bool isMobile = width < 600;
          final bool isTablet = width >= 600 && width < 1024;
          final bool isDesktop = width >= 1024;

          final double sidePadding =
              isDesktop ? width * 0.15 : (isTablet ? 60 : 20);

          final double topPadding =
              isDesktop ? 100 : (isTablet ? 90 : 80);

          final double bottomPadding =
              isDesktop ? 140 : (isTablet ? 130 : 120);

          final double maxContentWidth =
              isDesktop ? 900 : double.infinity;

          return Obx(
            () => ListView.builder(
              padding: EdgeInsets.fromLTRB(
                sidePadding,
                topPadding,
                sidePadding,
                bottomPadding,
              ),
              itemCount: controller.features.length,
              itemBuilder: (context, index) {
                final item = controller.features[index];
                final isLast =
                    index == controller.features.length - 1;

                return Center(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: maxContentWidth),
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: isLast ? 0 : 30),
                      child: _buildFeatureCard(
                        item,
                        index,
                        isDesktop: isDesktop,
                        isTablet: isTablet,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // =======================
  // FEATURE CARD (RESPONSIVE)
  // =======================
  Widget _buildFeatureCard(
    FeatureItem item,
    int index, {
    required bool isDesktop,
    required bool isTablet,
  }) {
    final double titleSize =
        isDesktop ? 24 : (isTablet ? 23 : 22);

    final double subtitleSize =
        isDesktop ? 16 : (isTablet ? 15.5 : 15);

    final double iconCircleSize =
        isDesktop ? 82 : (isTablet ? 78 : 75);

    final double iconSize =
        isDesktop ? 40 : (isTablet ? 38 : 36);

    final double buttonWidth =
        isDesktop ? 420 : (isTablet ? 380 : 350);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border:
                Border.all(color: Colors.grey.shade300, width: 1.4),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 62,
                  left: isDesktop ? 36 : 28,
                  right: isDesktop ? 36 : 28,
                  bottom: isDesktop ? 36 : 32,
                ),
                child: Column(
                  children: [
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF0A3D33),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: item.tags.map((tag) {
                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 9),
                            decoration: BoxDecoration(
                              color: item.lightColor,
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                tag,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: item.color,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      item.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: subtitleSize,
                        height: 1.6,
                        color:
                            Colors.black.withOpacity(0.76),
                      ),
                    ),
                  ],
                ),
              ),

              // Gradient Icon Circle (UNCHANGED)
              Positioned(
                top: -35,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: iconCircleSize,
                    height: iconCircleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: item.gradientColors,
                      ),
                    ),
                    child: Icon(
                      item.icon,
                      size: iconSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        // =======================
        // BUTTON (RESPONSIVE WIDTH)
        // =======================
        SizedBox(
          height: 50,
          width: buttonWidth,
          child: ElevatedButton.icon(
            onPressed: () => controller.onFeatureTap(index),
            icon: Icon(
              item.buttonIcon,
              size: 26,
              color: Colors.white,
            ),
            label: Text(
              item.buttonText,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: item.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        const SizedBox(height: 50),
      ],
    );
  }
}
