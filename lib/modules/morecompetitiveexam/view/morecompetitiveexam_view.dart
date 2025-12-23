// view/morecompetitiveexam_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/theme/design_system.dart';
import '../controller/morecompetitiveexam_controller.dart';

class MoreCompetitiveExamsView extends GetView<MoreCompetitiveExamsController> {
  const MoreCompetitiveExamsView({Key? key}) : super(key: key);

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
      case 'CLAT':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientPurpleStart, AppColors.gradientPurpleMiddle, AppColors.gradientPurpleEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 'CAT':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientOrangeStart, AppColors.gradientOrangeMiddle, AppColors.gradientOrangeEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 'UGC':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientUgcStart, AppColors.gradientUgcMiddle, AppColors.gradientUgcEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 'GATE':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientGateStart, AppColors.gradientGateMiddle, AppColors.gradientGateEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      default:
        return BoxDecoration(color: Colors.blue.shade700, shape: BoxShape.circle);
    }
  }

  Color _getExamAccentColor(String code) {
    switch (code) {
      case 'JEE':
        return AppColors.gradientRedMiddle;
      case 'NEET':
        return AppColors.gradientMiddle;
      case 'CLAT':
        return AppColors.gradientPurpleMiddle;
      case 'CAT':
        return AppColors.gradientOrangeMiddle;
      case 'UGC':
        return AppColors.gradientUgcMiddle;
      case 'GATE':
        return AppColors.gradientGateMiddle;
      default:
        return Colors.blue.shade700;
    }
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
        final double badgeFontSize = isMobile ? 16 : (isTablet ? 24 : 26);
        final double bodySize = isMobile ? 16 : 17;
        final double smallSize = isMobile ? 13 : 14;
        final double verySmallSize = isMobile ? 11 : 12;

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
                  onPressed: () {
                    if (isSearching.value) {
                      isSearching.value = false;
                      searchQuery.value = '';
                      searchController.clear();
                    } else {
                      Get.back();
                    }
                  },
                ),
                title: Obx(() => isSearching.value
                    ? TextField(
                        controller: searchController,
                        autofocus: true,
                        style: TextStyle(color: Colors.black87, fontSize: isMobile ? 17 : 19),
                        decoration: InputDecoration(
                          hintText: 'Search exams...',
                          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: isMobile ? 16 : 17),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => searchQuery.value = value.toLowerCase().trim(),
                      )
                    : Text(
                        'Select Your Exam',
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

              // HEADER SECTION
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
                        'Choose Your Competitive Exam',
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
                          'Select your competitive exam preparation to access relevant study materials',
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

              // "Competitive Exams" TITLE - NOW ALWAYS VISIBLE (even during search)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text(
                    'Competitive Exams',
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.greenColor,
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: isMobile ? 12 : 16)),

              // EXAMS LIST
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: Obx(() {
                  final filteredExams = controller.exams.where((exam) {
                    final query = searchQuery.value;
                    if (query.isEmpty) return true;
                    return exam.title.toLowerCase().contains(query) ||
                        exam.code.toLowerCase().contains(query) ||
                        exam.subtitle.toLowerCase().contains(query);
                  }).toList();

                  if (filteredExams.isEmpty && searchQuery.value.isNotEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(isMobile ? 60 : 80),
                          child: Text(
                            'No exams found',
                            style: TextStyle(fontSize: isMobile ? 16 : 18, color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final exam = filteredExams[index];
                        final Color accentColor = _getExamAccentColor(exam.code);

                        return Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: contentMaxWidth),
                            child: GestureDetector(
                              onTap: () => controller.selectExam(exam),
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
                                      decoration: _getGradientDecoration(exam.code),
                                      child: Center(
                                        child: Text(
                                          exam.code,
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
                                            exam.title,
                                            style: TextStyle(
                                              fontSize: bodySize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 1),
                                          Text(
                                            exam.subtitle,
                                            style: TextStyle(
                                              fontSize: smallSize,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            exam.subjects,
                                            style: TextStyle(
                                              fontSize: smallSize - 0.5,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Row(
                                            children: [
                                              Icon(Icons.whatshot, size: 13, color: accentColor),
                                              const SizedBox(width: 4),
                                              Flexible(
                                                child: Text(
                                                  exam.difficulty,
                                                  style: TextStyle(
                                                    fontSize: verySmallSize,
                                                    color: accentColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Icon(Icons.calendar_today, size: 13, color: Colors.grey.shade600),
                                              const SizedBox(width: 4),
                                              Text(
                                                exam.duration,
                                                style: TextStyle(
                                                  fontSize: verySmallSize,
                                                  color: Colors.grey.shade700,
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
                      childCount: filteredExams.length,
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