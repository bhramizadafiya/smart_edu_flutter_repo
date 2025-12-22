// view/allstandards_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/coresubjects/binding/coresubjects_binding.dart';
import 'package:smarted/modules/coresubjects/view/coresubjects_view.dart';
import 'package:smarted/theme/design_system.dart';
import '../controller/allstandards_controller.dart';

class AllStandardsView extends GetView<AllStandardsController> {
  const AllStandardsView({Key? key}) : super(key: key);

  // Gradient for badge circle
  BoxDecoration _getStandardGradient(int badge) {
    switch (badge) {
      case 9:
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
        return BoxDecoration(
          color: Colors.grey.shade400,
          shape: BoxShape.circle,
        );
    }
  }

  // Accent color for stream & progress
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

  @override
  Widget build(BuildContext context) {
    // Search state
    final RxBool isSearching = false.obs;
    final RxString searchQuery = ''.obs;
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF9),
      body: CustomScrollView(
        slivers: [
          // AppBar with dynamic search
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.greenColor),
              onPressed: () => Get.back(),
            ),
            title: Obx(() => isSearching.value
                ? TextField(
                    controller: searchController,
                    autofocus: true,
                    style: const TextStyle(color: Colors.black87, fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Search standards...',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      searchQuery.value = value.toLowerCase().trim();
                    },
                  )
                : const Text(
                    'Select Your Standard',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greenColor,
                    ),
                  )),
            centerTitle: true,
            actions: [
              Obx(() => IconButton(
                    icon: Icon(
                      isSearching.value ? Icons.clear : Icons.search,
                      color: AppColors.greenColor,
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: const Color(0xFFD8D8D8),
                height: 1,
              ),
            ),
          ),

          // Header Section
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 40),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
              
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.school_rounded,
                    size: 56,
                    color: AppColors.gradientMiddle,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Choose Your Standard',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.gradientEnd,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Select your Standard to access relevant study materials',
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          // Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Standard',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  color: AppColors.greenColor,
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Filtered List of Standards
          Obx(() {
            final filteredStandards = controller.standards.where((standard) {
              final query = searchQuery.value;
              if (query.isEmpty) return true;
              return standard.title.toLowerCase().contains(query) ||
                  standard.subtitle.toLowerCase().contains(query) ||
                  standard.badge.toString().contains(query);
            }).toList();

            if (filteredStandards.isEmpty && searchQuery.value.isNotEmpty) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Text(
                      'No standards found',
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    ),
                  ),
                ),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final standard = filteredStandards[index];
                  final bool isLocked = standard.progress == 'Locked';
                  final Color accentColor = _getStandardAccentColor(standard.badge);

                  return GestureDetector(
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
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200, width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: _getStandardGradient(standard.badge),
                            child: Center(
                              child: Text(
                                standard.badge.toString().padLeft(2, '0'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
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
                                  standard.title,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  standard.subtitle,
                                  style: const TextStyle(fontSize: 14.5),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  standard.secondSubtitle,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      standard.streamIcon,
                                      size: 14,
                                      color: accentColor,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      standard.streamText,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: accentColor,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Icon(
                                      standard.progress == 'In Progress'
                                          ? Icons.whatshot
                                          : standard.progress == 'Locked'
                                              ? Icons.lock_outline
                                              : Icons.punch_clock,
                                      size: 14,
                                      color: standard.progress == 'Locked'
                                          ? Colors.grey.shade600
                                          : standard.progress == 'In Progress'
                                              ? Colors.orange.shade600
                                              : accentColor,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      standard.progress,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: standard.progress == 'Locked'
                                            ? Colors.grey.shade600
                                            : standard.progress == 'In Progress'
                                                ? Colors.orange.shade600
                                                : accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: isLocked ? Colors.grey.shade400 : Colors.grey.shade700,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: filteredStandards.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}