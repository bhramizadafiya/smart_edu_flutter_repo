import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/allstandards/binding/allstandards_binding.dart';
import 'package:smarted/modules/allstandards/view/allstandards_view.dart';
import 'package:smarted/modules/coresubjects/binding/coresubjects_binding.dart';
import 'package:smarted/modules/coresubjects/controller/coresubjects_controller.dart';

import 'package:smarted/modules/coresubjects/view/coresubjects_view.dart';
import 'package:smarted/modules/morecompetitiveexam/binding/morecompetitiveexam_binding.dart';
import 'package:smarted/modules/morecompetitiveexam/view/morecompetitiveexam_view.dart';
import 'package:smarted/modules/studymateriallist/binding/studymateriallist_binding.dart';
import 'package:smarted/modules/studymateriallist/view/studymateriallist_view.dart';
import '../controller/dashboard_controller.dart';
import '../../../theme/design_system.dart'; // optional - your app styles
import '../../../widgets/custom_drawer.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,

      // Make header sticky by putting it in the AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: SafeArea(
          child: Container(
            color: Colors.white, // keep same background as body
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: _buildAppBar(context, ctrl, _scaffoldKey),
          ),
        ),
      ),

      // drawer: CustomDrawer(
      //   name: 'John Doe',
      //   role: 'Student',
      //   email: 'john.doe@email.com',
      //   onEditProfile: () {
      //     // open profile page
      //     Get.toNamed('/profile');
      //     _scaffoldKey.currentState?.closeDrawer();
      //   },
      //   onLogout: () {
      //     // optional override
      //     Get.offAllNamed('/login');
      //   },
      // ),
      drawer: CustomDrawer(
        name: 'John Doe',
        role: 'Student',
        email: 'john.doe@email.com',
        onEditProfile: () {
          Get.toNamed('/profile');
          _scaffoldKey.currentState?.closeDrawer();
        },
        onLogout: () async {
          // close drawer first for smooth UX
          _scaffoldKey.currentState?.closeDrawer();
          await controller.logout();
        },
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final bool isMobile = width < 600;
          final bool isTablet = width >= 600 && width < 1024;
          final bool isDesktop = width >= 1024;

          final horizontalPadding = isDesktop
              ? width * 0.08
              : (isTablet ? 28.0 : 16.0);
          final contentMaxWidth = isDesktop
              ? 1100.0
              : (isTablet ? 900.0 : double.infinity);

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top header bar (compact)
                    // _buildHeader(
                    //   context,
                    //   ctrl,
                    //   isMobile,
                    //   isDesktop,
                    //   _scaffoldKey,
                    // ),
                    const SizedBox(height: 16),

                    // Your Progress card
                    _buildProgressCard(ctrl, isMobile),

                    const SizedBox(height: 20),

                    // Recent Activity + Standards stacked
                    isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: _buildRecentActivity(ctrl),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                width: 360,
                                child: _buildStandards(ctrl),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              _buildRecentActivity(ctrl),
                              const SizedBox(height: 16),
                              _buildStandards(ctrl),
                            ],
                          ),

                    const SizedBox(height: 20),

                    // Competitive Exams
                    _buildExamsSection(ctrl),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    DashboardController ctrl,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;

    return Row(
      children: [
        GestureDetector(
          onTap: () => scaffoldKey.currentState?.openDrawer(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.textcolor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.menu, color: Colors.white, size: 18),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'YB Nexus',
          style: TextStyle(
            color: AppColors.textcolor,
            fontSize: isMobile ? 16 : 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Obx(
          () => Text(
            ctrl.welcome.value,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: isMobile ? 12 : 14,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildHeader(
  //   BuildContext context,
  //   DashboardController ctrl,
  //   bool isMobile,
  //   bool isDesktop,
  //   GlobalKey<ScaffoldState> scaffoldKey, // <— add this argument
  // ) {
  //   return Row(
  //     children: [
  //       // hamburger
  //       GestureDetector(
  //         onTap: () => scaffoldKey.currentState?.openDrawer(),
  //         child: Container(
  //           padding: const EdgeInsets.all(8),
  //           decoration: BoxDecoration(
  //             color: AppColors.textcolor,
  //             borderRadius: BorderRadius.circular(6),
  //           ),
  //           child: const Icon(Icons.menu, color: Colors.white, size: 18),
  //         ),
  //       ),
  //       const SizedBox(width: 12),

  //       // Title
  //       Text(
  //         'YB Nexus',
  //         style: TextStyle(
  //           color: AppColors.textcolor,
  //           fontSize: isMobile ? 16 : 20,
  //           fontWeight: FontWeight.w700,
  //         ),
  //       ),
  //       const Spacer(),

  //       // Welcome text
  //       Obx(
  //         () => Text(
  //           ctrl.welcome.value,
  //           style: TextStyle(
  //             color: Colors.grey[700],
  //             fontSize: isMobile ? 12 : 14,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildProgressCard(DashboardController ctrl, bool isMobile) {
    // Sizes scale
    final double cardInnerPadding = isMobile ? 14.0 : 18.0;
    final double ringSize = isMobile ? 96.0 : 120.0;
    final double ringStroke = isMobile ? 8.0 : 10.0;

    // Force progress = 25%
    final double progress = 0.25;
    final int percentInt = (progress * 100).toInt();

    // Example stats (replace with controller values)
    final int testsTaken = 12;
    final int bestScore = 92;
    final String improvement = '+15%';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 12 : 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Progress',
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),

          // Inner gradient card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(cardInnerPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade100),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFE9F8F1),
                  Color(0xFFF4FFF9),
                  Color(0xFFE7FAEE),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Circular ring with Avg Score
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: ringSize,
                          height: ringSize,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: ringStroke,
                            backgroundColor: Colors.green.shade50,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green.shade700,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$percentInt%',
                              style: TextStyle(
                                fontSize: isMobile ? 18 : 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.green.shade800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Avg Score',
                              style: TextStyle(
                                fontSize: isMobile ? 11 : 12,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(width: 22),

                // Right: Labels and values perfectly aligned
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Responsive header: on mobile show 'Last 30 days' below the title,
                      // on larger screens keep it right-aligned.
                      isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Overall Progress',
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green.shade900,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Last 30 days',
                                  style: TextStyle(
                                    fontSize: isMobile ? 12 : 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Overall Progress',
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green.shade900,
                                  ),
                                ),
                                Text(
                                  'Last 30 days',
                                  style: TextStyle(
                                    fontSize: isMobile ? 12 : 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),

                      const SizedBox(height: 14),

                      // Aligned labels and values
                      Column(
                        children: [
                          _alignedStatRow('Tests Taken', '$testsTaken'),
                          const SizedBox(height: 8),
                          _alignedStatRow('Best Score', '$bestScore%'),
                          const SizedBox(height: 8),
                          _alignedStatRow(
                            'Improvement',
                            improvement,
                            valueColor: Colors.green.shade700,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper function: aligns label and value neatly in one row
  Widget _alignedStatRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 13,
              color: valueColor ?? Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildProgressCard(DashboardController ctrl, bool isMobile) {
  //   return Container(
  //     width: double.infinity,
  //     padding: EdgeInsets.all(isMobile ? 12 : 18),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: Colors.grey.shade200),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.02),
  //           blurRadius: 8,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Your Progress',
  //           style: TextStyle(
  //             fontSize: isMobile ? 14 : 16,
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //         const SizedBox(height: 12),
  //         Obx(() {
  //           if (!ctrl.hasProgress.value) {
  //             return Container(
  //               height: 110,
  //               width: double.infinity,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: Colors.grey.shade50,
  //                 border: Border.all(color: Colors.grey.shade200),
  //               ),
  //               child: Center(
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Icon(
  //                       Icons.bar_chart_outlined,
  //                       size: 30,
  //                       color: Colors.grey.shade400,
  //                     ),
  //                     const SizedBox(height: 8),
  //                     Text(
  //                       'No Progress Data',
  //                       style: TextStyle(color: Colors.grey.shade600),
  //                     ),
  //                     Text(
  //                       'Take analytics',
  //                       style: TextStyle(color: Colors.blue.shade300),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           } else {
  //             final percent = (ctrl.progressPercent.value * 100).toInt();
  //             return Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 LinearProgressIndicator(value: ctrl.progressPercent.value),
  //                 const SizedBox(height: 8),
  //                 Text(
  //                   '$percent% completed',
  //                   style: const TextStyle(fontWeight: FontWeight.w600),
  //                 ),
  //               ],
  //             );
  //           }
  //         }),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildRecentActivity(DashboardController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
        children: [
          // Upload Materials Button
          Expanded(
            child: GestureDetector(
              onTap: () {
               Get.to(
  () => const StudyMaterialListView(),
  binding: StudyMaterialListBinding(),
);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                decoration: BoxDecoration(
                  color: const Color(0xFF4285F4), // Blue background
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add, color: Colors.white, size: 20),
                    SizedBox(width: 4),
                    Text(
                      'Upload Materials',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Standards Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => const AllStandardsView(),
                  binding: AllStandardsBinding(),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
                decoration: BoxDecoration(
                  color: const Color(0xFF4285F4),
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.school_rounded, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Standards',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Competitive Exam Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => const MoreCompetitiveExamsView(),
                  binding: MoreCompetitiveExamsBinding(),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
                decoration: BoxDecoration(
                  color: const Color(0xFF4285F4),
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.emoji_events_rounded, color: Colors.white, size: 18),
                    SizedBox(width: 4),
                    Text(
                      'Competitive Exam',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
        Text(
          'Recent Activity',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Obx(
          () => Column(
            children: ctrl.recentActivity
                .map(
                  (item) => GestureDetector(
                    onTap: () => ctrl.openActivityDetails(item),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // icon circle
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: item.color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.document_scanner,
                                color: item.color,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.meta,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: item.color.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item.status,
                                  style: TextStyle(
                                    color: item.color,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item.timeAgo,
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        // view all activity
        GestureDetector(
          onTap: () => Get.snackbar(
            'Activity',
            'View all activity',
            snackPosition: SnackPosition.BOTTOM,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              children: [
                Text(
                  'View All Activity',
                  style: TextStyle(color: Colors.blue.shade700),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward, size: 14, color: Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStandards(DashboardController ctrl) {
  BoxDecoration getStandardGradient(int badge) {
    switch (badge) {
      case 10:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientStart,
              AppColors.gradientMiddle,
              AppColors.gradientEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 11:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientStartBlue,
              AppColors.gradientMiddleBlue,
              AppColors.gradientEndBlue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 12:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientRedStart,
              AppColors.gradientRedMiddle,
              AppColors.gradientRedEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      default:
        return BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle);
    }
  }

  Color getStandardAccentColor(int badge) {
    switch (badge) {
      case 10:
        return AppColors.gradientMiddle;
      case 11:
        return AppColors.gradientMiddleBlue;
      case 12:
        return AppColors.gradientRedMiddle;
      default:
        return Colors.grey.shade600;
    }
  }

  Color getProgressColor(String progress) {
    switch (progress) {
      case 'In Progress':
        return Colors.orange.shade600;
      case 'Locked':
        return Colors.grey.shade600;
      case 'Advanced':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  IconData getProgressIcon(String progress) {
    switch (progress) {
      case 'In Progress':
        return Icons.whatshot;
      case 'Locked':
        return Icons.lock_outline;
      case 'Advanced':
        return Icons.auto_awesome;
      default:
        return Icons.circle;
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Standards',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 16),

      // Filter to show ONLY 10th, 11th, 12th
      Obx(() {
        final displayedStandards = ctrl.standards
            .where((s) => [10, 11, 12].contains(s.badge))
            .toList();

        return Column(
          children: displayedStandards.map((s) {
            final Color accentColor = getStandardAccentColor(s.badge);

            return GestureDetector(
              onTap: () {
                Get.to(
                  () => const CoreSubjectsView(),
                  binding: CoreSubjectsBinding(),
                  arguments: {
                    'classNumber': s.badge,
                    'classTitle': s.title,
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: getStandardGradient(s.badge),
                      child: Center(
                        child: Text(
                          '${s.badge}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.title,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            s.subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            s.secondSubtitle,
                            style: TextStyle(
                              fontSize: 13.5,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                s.streamIcon,
                                size: 17,
                                color: accentColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                s.streamText,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: accentColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 24), // Reduced gap
                              Icon(
                                getProgressIcon(s.progress),
                                size: 17,
                                color: getProgressColor(s.progress),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                s.progress,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: getProgressColor(s.progress),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                      size: 26,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }),

      const SizedBox(height: 16),
      Center(
        child: GestureDetector(
          onTap: () {
            Get.to(
              () => const AllStandardsView(),
              binding: AllStandardsBinding(),
            );
          },
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'View All Standards',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.north_east,
                  size: 17,
                  color: Colors.grey.shade700,
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
Widget _buildExamsSection(DashboardController ctrl) {
 
  BoxDecoration _getGradientDecoration(String code) {
    switch (code) {
      case 'JEE':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientRedStart, AppColors.gradientRedMiddle, AppColors.gradientRedEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 'NEET':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientMiddle, AppColors.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 'UGC':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientPurpleStart, AppColors.gradientPurpleMiddle, AppColors.gradientPurpleEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 'GATE':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientOrangeStart, AppColors.gradientOrangeMiddle, AppColors.gradientOrangeEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      default:
        return BoxDecoration(
          color: Colors.blue.shade700,
          shape: BoxShape.circle,
        );
    }
  }

  Color _getTextAndIconColor(String code) {
    switch (code) {
      case 'JEE':
        return AppColors.gradientRedMiddle;
      case 'NEET':
        return AppColors.gradientMiddle;
      case 'UGC':
        return AppColors.gradientPurpleMiddle;
      case 'GATE':
        return AppColors.gradientOrangeMiddle;
      default:
        return Colors.blue.shade700;
    }
  }

  Widget _buildAccessBadge(String accessType, Color examColor) {
  Color badgeBgColor = examColor.withOpacity(0.15);
  Color textColor = examColor;

  if (accessType.toLowerCase() == 'available') {
    badgeBgColor = Colors.purple.withOpacity(0.1);
    textColor = Colors.purple.shade700;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: badgeBgColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      accessType,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: textColor, // ← Make sure it's "textColor", not "textcolor"
      ),
    ),
  );
}
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Competitive Exams',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 16),
      Obx(
        () => Column(
          children: ctrl.exams.take(4).map((e) {
            final Color examColor = _getTextAndIconColor(e.code);

            return GestureDetector(
              onTap: () => ctrl.openExam(e),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // REPLACED CircleAvatar → Container with Gradient
                    Container(
                      width: 56,  // 28 * 2 (same as radius 28)
                      height: 56,
                      decoration: _getGradientDecoration(e.code),
                      child: Center(
                        child: Text(
                          e.code,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            e.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            e.subtitle,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(Icons.subject, size: 16, color: examColor),
                              const SizedBox(width: 6),
                              Text(
                                e.subjectsIcon,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: examColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(width: 12),
                              Icon(Icons.whatshot, size: 16, color: Colors.orange.shade700),
                              const SizedBox(width: 6),
                              Text(
                                e.difficulty,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Colors.orange.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildAccessBadge(e.accessType, examColor),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),

      const SizedBox(height: 8),

      // Full-width "View All" button
      GestureDetector(
        onTap: () {
          Get.to(() => const MoreCompetitiveExamsView(),
              binding: MoreCompetitiveExamsBinding());
        },
        child: Container(
          width: 600, // Fixed: now truly full width
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8), // Pill shape
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'View All Competitive Exams',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.north_east,
                size: 17,
                color: Colors.grey.shade700,
              ),
            ],
          ),
        ),
      ),

      const SizedBox(height: 20),
    ],
  );
}

  Color _examColor(String code) {
    switch (code.toUpperCase()) {
      case 'JEE':
        return Colors.red;
      case 'NEET':
        return Colors.green;
      case 'UGC':
        return Colors.purple;
      case 'GATE':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}
