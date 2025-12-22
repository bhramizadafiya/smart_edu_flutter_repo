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
      case 'NEET':
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
      case 'CLAT':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientPurpleStart,
              AppColors.gradientPurpleMiddle,
              AppColors.gradientPurpleEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 'CAT':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientOrangeStart,
              AppColors.gradientOrangeMiddle,
              AppColors.gradientOrangeEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 'UGC':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientUgcStart,
              AppColors.gradientUgcMiddle,
              AppColors.gradientUgcEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        );
      case 'GATE':
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gradientGateStart,
              AppColors.gradientGateMiddle,
              AppColors.gradientGateEnd,
            ],
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
    final RxBool isSearching = false.obs;
    final RxString searchQuery = ''.obs;
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 255, 249),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 216, 216, 216),
                width: 1.0,
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.greenColor),
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
            title: Obx(() {
              if (isSearching.value) {
                return TextField(
                  controller: searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.black87, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Search exams...',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    searchQuery.value = value.toLowerCase().trim();
                  },
                );
              } else {
                return const Text(
                  'Select Your Exam',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                    color: AppColors.greenColor,
                  ),
                );
              }
            }),
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
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // ================= HEADER SECTION (NOW SCROLLABLE) =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 40),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
               
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
                    'Choose Your Competitive Exam',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.gradientEnd,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select your competitive exam preparation to access relevant study materials',
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

            const SizedBox(height: 24),

            // ================= COMPETITIVE EXAMS LIST =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => isSearching.value
                      ? const SizedBox.shrink()
                      : const Text(
                          'Competitive Exams',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: AppColors.greenColor,
                          ),
                        )),
                  const SizedBox(height: 16),
                  Obx(() {
                    final filteredExams = controller.exams.where((exam) {
                      final query = searchQuery.value;
                      if (query.isEmpty) return true;
                      return exam.title.toLowerCase().contains(query) ||
                          exam.code.toLowerCase().contains(query) ||
                          exam.subtitle.toLowerCase().contains(query);
                    }).toList();

                    if (filteredExams.isEmpty && searchQuery.value.isNotEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Center(
                          child: Text(
                            'No exams found',
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true, // Important for nesting in SingleChildScrollView
                      physics: const NeverScrollableScrollPhysics(), // Disable inner scroll
                      itemCount: filteredExams.length,
                      itemBuilder: (context, index) {
                        final exam = filteredExams[index];
                        final Color accentColor = _getExamAccentColor(exam.code);

                        return GestureDetector(
                          onTap: () => controller.selectExam(exam),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: Colors.grey.shade300, width: 1.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: _getGradientDecoration(exam.code),
                                  child: Center(
                                    child: Text(
                                      exam.code,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
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
                                        exam.title,
                                        style: const TextStyle(
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        exam.subtitle,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        exam.subjects,
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(Icons.whatshot, size: 18, color: accentColor),
                                          const SizedBox(width: 6),
                                          Text(
                                            exam.difficulty,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: accentColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 24),
                                          const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                                          const SizedBox(width: 6),
                                          Text(
                                            exam.duration,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 30), // Extra bottom space
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}