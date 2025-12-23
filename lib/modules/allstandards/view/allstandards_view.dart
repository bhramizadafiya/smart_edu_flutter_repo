// view/allstandards_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/coresubjects/binding/coresubjects_binding.dart';
import 'package:smarted/modules/coresubjects/view/coresubjects_view.dart';
import 'package:smarted/theme/design_system.dart';
import '../controller/allstandards_controller.dart';

class AllStandardsView extends GetView<AllStandardsController> {
  const AllStandardsView({Key? key}) : super(key: key);

  BoxDecoration _getStandardGradient(int badge) {
    switch (badge) {
      case 9: // Keep original green gradient for Class 9 (same as previous)
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientMiddle, AppColors.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 10:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientMiddle, AppColors.gradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 11:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientStartBlue, AppColors.gradientMiddleBlue, AppColors.gradientEndBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 12:
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientRedStart, AppColors.gradientRedMiddle, AppColors.gradientRedEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      default:
        return BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle);
    }
  }

  Color _getStandardAccentColor(int badge) {
    switch (badge) {
      case 9:
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

  Color _getProgressColor(String progress) {
    if (progress == 'In Progress') return Colors.orange.shade600;
    if (progress == 'Locked') return Colors.grey.shade600;
    return Colors.red.shade600; // Completed - dashboard style
  }

  IconData _getProgressIcon(String progress) {
    if (progress == 'In Progress') return Icons.whatshot;
    if (progress == 'Locked') return Icons.lock_outline;
    return Icons.auto_awesome; // Completed - dashboard style
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final bool isMobile = width < 600;
        final bool isTablet = width >= 600 && width < 1024;
        final bool isDesktop = width >= 1024;

        final double horizontalPadding = isDesktop
            ? width * 0.08
            : isTablet
                ? 28.0
                : 16.0;

        final double contentMaxWidth = isDesktop
            ? 1200.0
            : isTablet
                ? 960.0
                : double.infinity;

        final double badgeSize = isMobile ? 56 : (isTablet ? 60 : 64);
        final double badgeFontSize = isMobile ? 22 : (isTablet ? 24 : 26);
        final double bodySize = isMobile ? 16 : 17;
        final double smallSize = isMobile ? 13 : 14;
        final double verySmallSize = isMobile ? 11 : 12;

        // Search state
        final RxBool isSearching = false.obs;
        final RxString searchQuery = ''.obs;
        final TextEditingController searchController = TextEditingController();

        return Scaffold(
          backgroundColor: const Color(0xFFF7FFF9),
          body: CustomScrollView(
            slivers: [
              // APP BAR
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: AppColors.greenColor, size: isMobile ? 26 : 28),
                  onPressed: () => Get.back(),
                ),
                title: Obx(() => isSearching.value
                    ? TextField(
                        controller: searchController,
                        autofocus: true,
                        style: TextStyle(color: Colors.black87, fontSize: isMobile ? 17 : 19),
                        decoration: InputDecoration(
                          hintText: 'Search standards...',
                          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: isMobile ? 16 : 17),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => searchQuery.value = value.toLowerCase().trim(),
                      )
                    : Text(
                        'Select Your Standard',
                        style: TextStyle(
                          fontSize: isMobile ? 20 : 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.greenColor,
                        ),
                      )),
                centerTitle: true,
                actions: [
                  Obx(() => IconButton(
                        icon: Icon(
                          isSearching.value ? Icons.clear : Icons.search,
                          color: AppColors.greenColor,
                          size: isMobile ? 26 : 28,
                        ),
                        onPressed: () {
                          if (isSearching.value) {
                            isSearching.value = false;
                            searchQuery.value = '';
                            searchController.clear();
                          } else {
                            isSearching.value = true;
                          }
                        },
                      )),
                ],
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(height: 1, thickness: 1, color: Color(0xFFD8D8D8)),
                ),
              ),

              // HEADER - WITH SUBTITLE RESTORED
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(horizontalPadding, isMobile ? 32 : 40, horizontalPadding, isMobile ? 36 : 44),
                  decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
                  child: Column(
                    children: [
                      Icon(Icons.school_rounded, size: isMobile ? 56 : 64, color: AppColors.gradientMiddle),
                      SizedBox(height: isMobile ? 16 : 20),
                      Text(
                        'Choose Your Standard',
                        style: TextStyle(
                          fontSize: isMobile ? 21 : 25,
                          fontWeight: FontWeight.w800,
                          color: AppColors.gradientEnd,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isMobile ? 10 : 14),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 20),
                        child: Text(
                          'Select your Standard to access relevant study materials',
                          style: TextStyle(
                            fontSize: isMobile ? 14.5 : 16,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: isMobile ? 16 : 24)),

              // "Standards" TITLE - RESTORED
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text(
                    'Standards',
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.greenColor,
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: isMobile ? 12 : 16)),

              // STANDARDS LIST
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: Obx(() {
                  final filteredStandards = controller.standards.where((standard) {
                    final query = searchQuery.value;
                    if (query.isEmpty) return true;
                    return standard.title.toLowerCase().contains(query) ||
                        standard.subtitle.toLowerCase().contains(query) ||
                        standard.secondSubtitle.toLowerCase().contains(query) ||
                        standard.badge.toString().contains(query);
                  }).toList();

                  if (filteredStandards.isEmpty && searchQuery.value.isNotEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(isMobile ? 60 : 80),
                          child: Text(
                            'No standards found',
                            style: TextStyle(fontSize: isMobile ? 16 : 18, color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final standard = filteredStandards[index];
                        final Color accentColor = _getStandardAccentColor(standard.badge);

                        return Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: contentMaxWidth),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const CoreSubjectsView(),
                                  binding: CoreSubjectsBinding(),
                                  arguments: {
                                    'classNumber': standard.badge,
                                    'classTitle': standard.title,
                                  },
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
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
                                    // Badge
                                    Container(
                                      width: badgeSize,
                                      height: badgeSize,
                                      decoration: _getStandardGradient(standard.badge),
                                      child: Center(
                                        child: Text(
                                          '${standard.badge}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: badgeFontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 10),

                                    // Content
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            standard.title,
                                            style: TextStyle(
                                              fontSize: bodySize + 1,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            standard.subtitle,
                                            style: TextStyle(
                                              fontSize: smallSize,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            standard.secondSubtitle,
                                            style: TextStyle(
                                              fontSize: smallSize - 0.5,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Row(
                                            children: [
                                              Icon(Icons.stream, size: 13, color: accentColor),
                                              const SizedBox(width: 4),
                                              Flexible(
                                                child: Text(
                                                  standard.streamText,
                                                  style: TextStyle(
                                                    fontSize: verySmallSize,
                                                    color: accentColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),

                                              const SizedBox(width: 10),
                                              Icon(
                                                _getProgressIcon(standard.progress),
                                                size: 13,
                                                color: _getProgressColor(standard.progress),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                standard.progress,
                                                style: TextStyle(
                                                  fontSize: verySmallSize,
                                                  color: _getProgressColor(standard.progress),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Chevron
                                    Icon(
                                      Icons.chevron_right,
                                      color: Colors.grey.shade400,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: filteredStandards.length,
                    ),
                  );
                }),
              ),

              SliverToBoxAdapter(child: SizedBox(height: isMobile ? 30 : 50)),
            ],
          ),
        );
      },
    );
  }
}