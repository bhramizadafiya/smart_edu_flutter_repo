// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../theme/design_system.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool showSearch;

//   const CustomAppBar({
//     super.key,
//     this.title = 'Class 11 - Subjects',
//     this.showSearch = false, // set true when you want the search icon visible
//   });

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back, color: Colors.black87),
//         onPressed: () => Get.back(),
//       ),
//       centerTitle: true,
//       title: Text(
//         title,
//         style: const TextStyle(
//           color: AppColors.textcolor,
//           fontWeight: FontWeight.w600,
//           fontSize: 20,
//         ),
//       ),
//       actions: showSearch
//           ? [
//               IconButton(
//                 icon: const Icon(Icons.search, color: Colors.black87),
//                 onPressed: () {},
//               ),
//             ]
//           : null,
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showSearch;

  const CustomAppBar({
    super.key,
    this.title = 'Class 11 - Subjects',
    this.showSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      // Make background solid white (or whatever you want)
      backgroundColor: Colors.white,
      // Remove elevation so no shadow/tint is applied
      elevation: 0,
      // Prevent Material 3 elevation overlay tint
      surfaceTintColor: Colors.white,
      // Remove shadow color (defensive)
      shadowColor: Colors.transparent,
      // If you use icons/text that expect dark color, set iconTheme/textTheme
      iconTheme: const IconThemeData(color: Colors.black87),
      titleTextStyle: const TextStyle(
        color: Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      // optional: keep status bar brightness consistent
      systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      actions: showSearch
          ? [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black87),
                onPressed: () {},
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
