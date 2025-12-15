// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../subjectselection/controller/subjectselection_controller.dart';
// import '../../../widgets/custom_appbar.dart';
// import '../../../theme/design_system.dart';

// class SubjectSelectionView extends GetView<SubjectSelectionController> {
//   const SubjectSelectionView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(title: 'Class 11 - Subjects', showSearch: true),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(
//           horizontal: size.width * 0.06,
//           vertical: size.height * 0.02,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(context),
//             const SizedBox(height: 25),
//             const Text(
//               "Core Subjects",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 16,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 15),
//             _buildSubjectTile(
//               color: const Color(0xFFE8F0FF),
//               icon: Icons.calculate,
//               iconBg: const Color(0xFF3B82F6),
//               title: "Mathematics",
//               subtitle: "Foundation for engineering & competitive exams",
//             ),
//             const SizedBox(height: 12),
//             _buildSubjectTile(
//               color: const Color(0xFFF0FFF4),
//               icon: Icons.science,
//               iconBg: const Color(0xFF10B981),
//               title: "Science",
//               subtitle: "NEET & JEE foundation preparation",
//             ),
//             const SizedBox(height: 12),
//             _buildSubjectTile(
//               color: const Color(0xFFFFF7ED),
//               iconText: "En",
//               iconBg: const Color(0xFFF59E0B),
//               title: "Physics",
//               subtitle: "Essential communication skills development",
//             ),
//             const SizedBox(height: 20),
//             _buildMoreSubjectsTile(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(vertical: size.height * 0.04),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE8F8EE),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 48, // diameter = 2 * radius
//             height: 48,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF66D1B2), // Light Mint Green
//                   Color(0xFF3BAA8F), // Medium Teal
//                   Color(0xFF1C524A), // Deep Green Teal
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: const Center(
//               child: Text(
//                 "11",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 12),
//           Text("Class 11 Science", style: AppTextStyles.maintitle),
//           SizedBox(height: 8),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 25.0),
//             child: Text(
//               "Select a subject to access study materials, practice tests, and AI assistance",
//               textAlign: TextAlign.center,
//               style: AppTextStyles.mainsubtitle,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSubjectTile({
//     required Color color,
//     required String title,
//     required String subtitle,
//     Color? iconBg,
//     IconData? icon,
//     String? iconText,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             spreadRadius: 1,
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: iconBg ?? AppColors.textcolor,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             width: 48,
//             height: 48,
//             child: Center(
//               child: icon != null
//                   ? Icon(icon, color: Colors.white, size: 24)
//                   : Text(
//                       iconText ?? "",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//             ),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(subtitle, style: AppTextStyles.mainsubtitle),
//               ],
//             ),
//           ),
//           const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
//         ],
//       ),
//     );
//   }

//   Widget _buildMoreSubjectsTile() {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF9FAFB),
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Row(
//         children: [
//           // Left Add Icon
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [Icon(Icons.add, color: AppColors.textcolor)],
//           ),
//           const SizedBox(width: 10),

//           // Center Texts
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Text(
//                   "View More Subjects",
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "Hindi, Sanskrit, Social Science, IT & more",
//                   style: AppTextStyles.mainsubtitle,
//                 ),
//               ],
//             ),
//           ),

//           // Right Forward Arrow Icon
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../subjectselection/controller/subjectselection_controller.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../theme/design_system.dart';

class SubjectSelectionView extends GetView<SubjectSelectionController> {
  const SubjectSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Class 11 - Subjects', showSearch: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
          vertical: size.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 25),
            const Text(
              "Core Subjects",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),

            // 🔹 Dynamic Subjects from Controller
            Obx(
              () => Column(
                children: List.generate(controller.subjects.length, (index) {
                  final subject = controller.subjects[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () => controller.onSubjectTap(subject["title"]),
                      child: _buildSubjectTile(
                        color: const Color(0xFFFFFFFF),
                        icon: subject["icon"] == "math"
                            ? Icons.calculate
                            : subject["icon"] == "science"
                            ? Icons.science
                            : null,
                        iconText: subject["icon"] == "en" ? "En" : null,
                        iconBg: Color(subject["color"]),
                        title: subject["title"],
                        subtitle: subject["subtitle"],
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),
            _buildMoreSubjectsTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: size.height * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F8EE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
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
            child: const Center(
              child: Text(
                "11",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text("Class 11 Science", style: AppTextStyles.maintitle),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Select a subject to access study materials, practice tests, and AI assistance",
              textAlign: TextAlign.center,
              style: AppTextStyles.mainsubtitle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectTile({
    required Color color,
    required String title,
    required String subtitle,
    Color? iconBg,
    IconData? icon,
    String? iconText,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconBg ?? AppColors.textcolor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 48,
            height: 48,
            child: Center(
              child: icon != null
                  ? Icon(icon, color: Colors.white, size: 24)
                  : Text(
                      iconText ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.mainsubtitle),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
        ],
      ),
    );
  }

  Widget _buildMoreSubjectsTile() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.add, color: AppColors.textcolor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "View More Subjects",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Hindi, Sanskrit, Social Science, IT & more",
                  style: AppTextStyles.mainsubtitle,
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
        ],
      ),
    );
  }
}
