import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/allstandards/binding/allstandards_binding.dart';
import 'package:smarted/modules/allstandards/view/allstandards_view.dart';
import 'package:smarted/modules/coresubjects/binding/coresubjects_binding.dart';
import 'package:smarted/modules/coresubjects/view/coresubjects_view.dart';
import 'package:smarted/modules/morecompetitiveexam/binding/morecompetitiveexam_binding.dart';
import 'package:smarted/modules/morecompetitiveexam/view/morecompetitiveexam_view.dart';
import 'package:smarted/modules/studymateriallist/binding/studymateriallist_binding.dart';
import 'package:smarted/modules/studymateriallist/view/studymateriallist_view.dart';
import '../controller/dashboard_controller.dart';
import '../../../theme/design_system.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: _buildAppBar(context, ctrl, _scaffoldKey),
          ),
        ),
      ),
      drawer: CustomDrawer(
        name: 'John Doe',
        role: 'Student',
        email: 'john.doe@email.com',
        onEditProfile: () {
          Get.toNamed('/profile');
          _scaffoldKey.currentState?.closeDrawer();
        },
        onLogout: () async {
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
              : isTablet
                  ? 28.0
                  : 16.0;
          final contentMaxWidth = isDesktop
              ? 1200.0
              : isTablet
                  ? 960.0
                  : double.infinity;

          final double titleFontSize = isMobile ? 17 : 19;
          final double sectionTitleSize = isMobile ? 16 : 18;
          final double bodyTextSize = isMobile ? 13 : 13.5;
          final double smallTextSize = isMobile ? 12 : 13;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProgressCard(ctrl, isMobile, sectionTitleSize, bodyTextSize),
                    const SizedBox(height: 20),
                    _buildQuickAccessRow(), // New single-line icon buttons
                    const SizedBox(height: 20),
                    isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: _buildRecentActivity(ctrl, isMobile, titleFontSize, bodyTextSize, smallTextSize),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 3,
                                child: _buildStandards(ctrl, isMobile, titleFontSize, bodyTextSize, smallTextSize),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              _buildRecentActivity(ctrl, isMobile, titleFontSize, bodyTextSize, smallTextSize),
                              const SizedBox(height: 20),
                              _buildStandards(ctrl, isMobile, titleFontSize, bodyTextSize, smallTextSize),
                            ],
                          ),
                    const SizedBox(height: 28),
                    _buildExamsSection(ctrl, isMobile, titleFontSize, bodyTextSize, smallTextSize),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, DashboardController ctrl, GlobalKey<ScaffoldState> scaffoldKey) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Row(
      children: [
        GestureDetector(
          onTap: () => scaffoldKey.currentState?.openDrawer(),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.textcolor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.menu, color: Colors.white, size: 20),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          'YB Nexus',
          style: TextStyle(
            color: AppColors.textcolor,
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Obx(() => Text(
              ctrl.welcome.value,
              style: TextStyle(color: Colors.grey[700], fontSize: isMobile ? 13 : 15),
            )),
      ],
    );
  }

  // New: Single line quick access with IconButtons
  Widget _buildQuickAccessRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _iconActionButton(
          icon: Icons.upload_file,
          label: 'Upload Materials',
          onTap: () => Get.to(() => const StudyMaterialListView(), binding: StudyMaterialListBinding()),
        ),
        _iconActionButton(
          icon: Icons.school_rounded,
          label: 'Standards',
          onTap: () => Get.to(() => const AllStandardsView(), binding: AllStandardsBinding()),
        ),
        _iconActionButton(
          icon: Icons.emoji_events_rounded,
          label: 'Competitive Exam',
          onTap: () => Get.to(() => const MoreCompetitiveExamsView(), binding: MoreCompetitiveExamsBinding()),
        ),
      ],
    );
  }

  Widget _iconActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF4285F4),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3)),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(DashboardController ctrl, bool isMobile, double sectionTitleSize, double bodyTextSize) {
    final double ringSize = isMobile ? 96 : 116;
    final double ringStroke = isMobile ? 8 : 10;
    final double progress = 0.25;
    final int percentInt = (progress * 100).toInt();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 14 : 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Progress', style: TextStyle(fontSize: sectionTitleSize, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade100),
              gradient: const LinearGradient(colors: [Color(0xFFE9F8F1), Color(0xFFF4FFF9), Color(0xFFE7FAEE)]),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        valueColor: AlwaysStoppedAnimation(Colors.green.shade700),
                      ),
                    ),
                    Column(
                      children: [
                        Text('$percentInt%', style: TextStyle(fontSize: isMobile ? 20 : 24, fontWeight: FontWeight.w800, color: Colors.green.shade800)),
                        Text('Avg Score', style: TextStyle(fontSize: isMobile ? 11 : 12, color: Colors.green.shade700)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Overall Progress', style: TextStyle(fontSize: isMobile ? 14 : 16, fontWeight: FontWeight.w700, color: Colors.green.shade900)),
                      const SizedBox(height: 4),
                      Text('Last 30 days', style: TextStyle(fontSize: bodyTextSize - 1, color: Colors.grey.shade600)),
                      const SizedBox(height: 12),
                      _statRow('Tests Taken', '12', bodyTextSize),
                      _statRow('Best Score', '92%', bodyTextSize),
                      _statRow('Improvement', '+15%', bodyTextSize, valueColor: Colors.green.shade700),
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

  Widget _statRow(String label, String value, double fontSize, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: fontSize - 1, color: Colors.grey.shade700)),
          Text(value, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: valueColor ?? Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(DashboardController ctrl, bool isMobile, double titleSize, double bodySize, double smallSize) {
    IconData _getIcon(String title) {
      if (title.contains('Mathematics') || title.contains('Mock Test')) return Icons.calculate;
      if (title.contains('AI Chat')) return Icons.chat_bubble;
      if (title.contains('Uploaded') || title.contains('Study Material')) return Icons.upload_file;
      if (title.contains('Practice Quiz') || title.contains('Attempt')) return Icons.flag;
      return Icons.document_scanner;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Activity', style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Obx(() => Column(
              children: ctrl.recentActivity.map((item) {
                return GestureDetector(
                  onTap: () => ctrl.openActivityDetails(item),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)]),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(color: item.color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
                          child: Icon(_getIcon(item.title), color: item.color, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: TextStyle(fontSize: bodySize, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text(item.meta, style: TextStyle(fontSize: smallSize, color: Colors.grey.shade600), maxLines: 2, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: item.color.withOpacity(0.12), borderRadius: BorderRadius.circular(16)), child: Text(item.status, style: TextStyle(fontSize: smallSize - 1, color: item.color, fontWeight: FontWeight.w700))),
                            const SizedBox(height: 6),
                            Text(item.timeAgo, style: TextStyle(fontSize: smallSize - 1, color: Colors.grey.shade500)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )),
        const SizedBox(height: 10),
        Center(child: GestureDetector(onTap: () => Get.snackbar('Activity', 'View all activity'), child: Text('View All Activity →', style: TextStyle(color: Colors.blue.shade700, fontSize: bodySize, fontWeight: FontWeight.w600)))),
      ],
    );
  }

  // Standards and Exams sections remain unchanged from previous version (with all your fixes)
  // ... [Keep _buildStandards and _buildExamsSection exactly as in the last version]

  Widget _buildStandards(DashboardController ctrl, bool isMobile, double titleSize, double bodySize, double smallSize) {
    // (Same as previous clean version – kept unchanged)
    BoxDecoration getGradient(int badge) {
      switch (badge) {
        case 10: return const BoxDecoration(gradient: LinearGradient(colors: [AppColors.gradientStart, AppColors.gradientMiddle, AppColors.gradientEnd]), shape: BoxShape.circle);
        case 11: return const BoxDecoration(gradient: LinearGradient(colors: [AppColors.gradientStartBlue, AppColors.gradientMiddleBlue, AppColors.gradientEndBlue]), shape: BoxShape.circle);
        case 12: return const BoxDecoration(gradient: LinearGradient(colors: [AppColors.gradientRedStart, AppColors.gradientRedMiddle, AppColors.gradientRedEnd]), shape: BoxShape.circle);
        default: return BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle);
      }
    }

    Color getAccent(int badge) {
      switch (badge) { case 10: return AppColors.gradientMiddle; case 11: return AppColors.gradientMiddleBlue; case 12: return AppColors.gradientRedMiddle; default: return Colors.grey.shade600; }
    }

    Color getProgressColor(String p) => p == 'In Progress' ? Colors.orange.shade600 : p == 'Locked' ? Colors.grey.shade600 : Colors.red.shade600;
    IconData getProgressIcon(String p) => p == 'In Progress' ? Icons.whatshot : p == 'Locked' ? Icons.lock_outline : Icons.auto_awesome;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Standards', style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Obx(() => Column(
              children: ctrl.standards.where((s) => [10, 11, 12].contains(s.badge)).map((s) {
                final accent = getAccent(s.badge);
                return GestureDetector(
                  onTap: () => Get.to(() => const CoreSubjectsView(), binding: CoreSubjectsBinding(), arguments: {'classNumber': s.badge, 'classTitle': s.title}),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 10)]),
                    child: Row(
                      children: [
                        Container(width: 60, height: 60, decoration: getGradient(s.badge), child: Center(child: Text('${s.badge}', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)))),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s.title, style: TextStyle(fontSize: bodySize + 1, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 3),
                              Text(s.subtitle, style: TextStyle(fontSize: smallSize, color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 3),
                              Text(s.secondSubtitle, style: TextStyle(fontSize: smallSize - 0.5, color: Colors.grey.shade600)),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Icon(Icons.stream, size: 15, color: accent),
                                  const SizedBox(width: 5),
                                  Flexible(child: Text(s.streamText, style: TextStyle(fontSize: smallSize, color: accent, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
                                  const SizedBox(width: 12),
                                  Icon(getProgressIcon(s.progress), size: 15, color: getProgressColor(s.progress)),
                                  const SizedBox(width: 5),
                                  Text(s.progress, style: TextStyle(fontSize: smallSize, color: getProgressColor(s.progress), fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 24),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Get.to(() => const AllStandardsView(), binding: AllStandardsBinding()),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('View All Standards', style: TextStyle(fontSize: bodySize, color: Colors.grey.shade700, fontWeight: FontWeight.w600)), const SizedBox(width: 8), const Icon(Icons.north_east, size: 16, color: Colors.grey)]),
          ),
        ),
      ],
    );
  }

  Widget _buildExamsSection(DashboardController ctrl, bool isMobile, double titleSize, double bodySize, double smallSize) {
    BoxDecoration getGradient(String code) {
      switch (code) {
        case 'JEE': return const BoxDecoration(gradient: LinearGradient(colors: [AppColors.gradientRedStart, AppColors.gradientRedMiddle, AppColors.gradientRedEnd]), shape: BoxShape.circle);
        case 'NEET': return const BoxDecoration(gradient: LinearGradient(colors: [AppColors.gradientStart, AppColors.gradientMiddle, AppColors.gradientEnd]), shape: BoxShape.circle);
        case 'UGC': return const BoxDecoration(gradient: LinearGradient(colors: [AppColors.gradientPurpleStart, AppColors.gradientPurpleMiddle, AppColors.gradientPurpleEnd]), shape: BoxShape.circle);
        case 'GATE': return const BoxDecoration(gradient: LinearGradient(colors: [AppColors.gradientOrangeStart, AppColors.gradientOrangeMiddle, AppColors.gradientOrangeEnd]), shape: BoxShape.circle);
        default: return BoxDecoration(color: Colors.blue.shade700, shape: BoxShape.circle);
      }
    }

    Color getColor(String code) {
      switch (code) { case 'JEE': return AppColors.gradientRedMiddle; case 'NEET': return AppColors.gradientMiddle; case 'UGC': return AppColors.gradientPurpleMiddle; case 'GATE': return AppColors.gradientOrangeMiddle; default: return Colors.blue.shade700; }
    }

    Widget _badge(String text, Color color) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
        child: Text(text, style: TextStyle(fontSize: smallSize - 1, fontWeight: FontWeight.w600, color: color)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Competitive Exams', style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Obx(() => Column(
              children: ctrl.exams.take(4).map((e) {
                final color = getColor(e.code);
                return GestureDetector(
                  onTap: () => ctrl.openExam(e),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 10)]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(width: 54, height: 54, decoration: getGradient(e.code), child: Center(child: Text(e.code, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)))),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.title, style: TextStyle(fontSize: bodySize + 1, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 3),
                              Text(e.subtitle, style: TextStyle(fontSize: smallSize, color: Colors.grey.shade700), maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 3),
                              Row(
  children: [
    // Subject part (left-aligned)
    Icon(Icons.subject, size: 15, color: color),
    const SizedBox(width: 5),
    Text(
      e.subjectsIcon,
      style: TextStyle(
        fontSize: smallSize,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
    
    SizedBox(width: 10),
    Icon(Icons.whatshot, color: Colors.orange.shade700,size: 15),
    const SizedBox(width: 5),
    Text(
      e.difficulty,
      style: TextStyle(
        fontSize: smallSize,
        color: Colors.orange.shade700,
        fontWeight: FontWeight.w600,
      ),
      overflow: TextOverflow.ellipsis, // optional: truncate if too long
      maxLines: 1,
    ),
  ],
),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Center(child: _badge(e.accessType, color)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Get.to(() => const MoreCompetitiveExamsView(), binding: MoreCompetitiveExamsBinding()),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('View All Competitive Exams', style: TextStyle(fontSize: bodySize, color: Colors.grey.shade700, fontWeight: FontWeight.w600)), const SizedBox(width: 8), const Icon(Icons.north_east, size: 16, color: Colors.grey)]),
          ),
        ),
      ],
    );
  }
}