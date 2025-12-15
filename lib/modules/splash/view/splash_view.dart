import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/splash_controller.dart';
import '../../../theme/design_system.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  final int _dotCount = 5;
  final double _minScale = 0.6;
  final double _maxScale = 1.0;

  @override
  void initState() {
    super.initState();
    Get.find<SplashController>();

    // ✅ Make status bar + navigation bar transparent (true fullscreen)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();

    // ✅ Restore system UI when leaving splash
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  double _triangle(double t) {
    t = t - t.floorToDouble();
    double v = t * 2;
    if (v > 1) v = 2 - v;
    return v;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        final double scaleFactor = width < 600
            ? 1.0
            : width < 1024
            ? 1.25
            : 1.6;

        final double logoDiameter = (width * 0.22 * scaleFactor).clamp(
          80.0,
          200.0,
        );
        final double titleFont = (width * 0.06 * scaleFactor).clamp(20.0, 40.0);
        final double subtitleFont = (width * 0.025 * scaleFactor).clamp(
          18.0,
          20.0,
        );
        final double baseDotSize = (width * 0.012 * scaleFactor).clamp(
          8.0,
          18.0,
        );
        final double topSpacing = (height * 0.06).clamp(20.0, 120.0);
        final double betweenLogoAndTitle = (height * 0.02).clamp(12.0, 48.0);
        final double bottomPadding = (height * 0.05).clamp(24.0, 120.0);

        return Scaffold(
          // ✅ No AppBar, no SafeArea → full screen display
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.gradientStart,
                  AppColors.gradientMiddle,
                  AppColors.gradientEnd,
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                final double progress = _animController.value;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: topSpacing),

                    // ---- Center block ----
                    Column(
                      children: [
                        Container(
                          width: logoDiameter,
                          height: logoDiameter,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.textPrimary,
                              width: logoDiameter * 0.05,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: logoDiameter * 0.12,
                                offset: Offset(0, logoDiameter * 0.06),
                              ),
                            ],
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.gradientEnd,
                                AppColors.gradientMiddle,
                                AppColors.gradientStart,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'YB',
                              style: TextStyle(
                                fontSize: (logoDiameter * 0.33).clamp(
                                  18.0,
                                  48.0,
                                ),
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: betweenLogoAndTitle),
                        Text('YB Nexus', style: AppTextStyles.title),
                        SizedBox(height: titleFont * 0.12),
                        Text('Education App', style: AppTextStyles.subtitle),
                        SizedBox(height: subtitleFont * 0.6),
                        Text(
                          'Empowering Learning with AI',
                          style: AppTextStyles.tagline,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 120,
                          height: 1.5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),

                    // ---- Bottom section ----
                    Padding(
                      padding: EdgeInsets.only(bottom: bottomPadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_dotCount, (index) {
                              final double offset =
                                  (progress + index * (1.0 / _dotCount)) % 1.0;
                              final double tri = _triangle(offset);
                              final double scale =
                                  _minScale + ((_maxScale - _minScale) * tri);
                              final double opacity = 0.35 + (0.65 * tri);

                              return Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: baseDotSize * 0.5,
                                ),
                                child: Transform.scale(
                                  scale: scale,
                                  child: Opacity(
                                    opacity: opacity,
                                    child: Container(
                                      width: baseDotSize,
                                      height: baseDotSize,
                                      decoration: const BoxDecoration(
                                        color: AppColors.textPrimary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: subtitleFont * 0.6),
                          Text(
                            'Loading...',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: subtitleFont,
                            ),
                          ),
                          SizedBox(height: subtitleFont * 1.8),
                          Container(
                            width: 180,
                            height: 1.5,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          SizedBox(height: subtitleFont * 1.5),
                          Text('Version 1.0.0', style: AppTextStyles.version),
                          SizedBox(height: 6),
                          Text(
                            '© 2025 YB Nexus. All rights reserved.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: (subtitleFont * 0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/splash_controller.dart';
// import '../../../theme/design_system.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({super.key});

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _animController;
//   final int _dotCount = 5;
//   final double _minScale = 0.6;
//   final double _maxScale = 1.0;

//   @override
//   void initState() {
//     super.initState();
//     Get.find<SplashController>();
//     _animController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1400),
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     _animController.dispose();
//     super.dispose();
//   }

//   double _triangle(double t) {
//     t = t - t.floorToDouble();
//     double v = t * 2;
//     if (v > 1) v = 2 - v;
//     return v;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final double width = constraints.maxWidth;
//         final double height = constraints.maxHeight;

//         final double scaleFactor = width < 600
//             ? 1.0
//             : width < 1024
//             ? 1.25
//             : 1.6;

//         final double logoDiameter = (width * 0.22 * scaleFactor).clamp(
//           80.0,
//           200.0,
//         );
//         final double titleFont = (width * 0.06 * scaleFactor).clamp(20.0, 40.0);
//         final double subtitleFont = (width * 0.025 * scaleFactor).clamp(
//           18.0,
//           20.0,
//         );
//         final double baseDotSize = (width * 0.012 * scaleFactor).clamp(
//           8.0,
//           18.0,
//         );
//         final double topSpacing = (height * 0.06).clamp(20.0, 120.0);
//         final double betweenLogoAndTitle = (height * 0.02).clamp(12.0, 48.0);
//         final double bottomPadding = (height * 0.05).clamp(24.0, 120.0);

//         return Scaffold(
//           body: Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   AppColors.gradientStart,
//                   AppColors.gradientMiddle,
//                   AppColors.gradientEnd,
//                 ],
//                 begin: Alignment.topRight,
//                 end: Alignment.bottomLeft,
//               ),
//             ),
//             child: AnimatedBuilder(
//               animation: _animController,
//               builder: (context, child) {
//                 final double progress = _animController.value;

//                 return SafeArea(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(height: topSpacing),

//                       // ---- Center block ----
//                       Column(
//                         children: [
//                           Container(
//                             width: logoDiameter,
//                             height: logoDiameter,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: AppColors.textPrimary,
//                                 width: logoDiameter * 0.05,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.12),
//                                   blurRadius: logoDiameter * 0.12,
//                                   offset: Offset(0, logoDiameter * 0.06),
//                                 ),
//                               ],
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   AppColors.gradientEnd,
//                                   AppColors.gradientMiddle,
//                                   AppColors.gradientStart,
//                                 ],
//                                 begin: Alignment.bottomLeft,
//                                 end: Alignment.topRight,
//                               ),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 'YB',
//                                 style: TextStyle(
//                                   fontSize: (logoDiameter * 0.33).clamp(
//                                     18.0,
//                                     48.0,
//                                   ),
//                                   fontWeight: FontWeight.w800,
//                                   color: AppColors.textPrimary,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: betweenLogoAndTitle),
//                           Text('YB Nexus', style: AppTextStyles.title),
//                           SizedBox(height: titleFont * 0.12),
//                           Text('Education App', style: AppTextStyles.subtitle),
//                           SizedBox(height: subtitleFont * 0.6),
//                           Text(
//                             'Empowering Learning with AI',
//                             style: AppTextStyles.tagline,
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             width: 120,
//                             height: 1.5,
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.6),
//                               borderRadius: BorderRadius.circular(2),
//                             ),
//                           ),
//                         ],
//                       ),

//                       // ---- Bottom section ----
//                       Padding(
//                         padding: EdgeInsets.only(bottom: bottomPadding),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             // Animated dots
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: List.generate(_dotCount, (index) {
//                                 final double offset =
//                                     (progress + index * (1.0 / _dotCount)) %
//                                     1.0;
//                                 final double tri = _triangle(offset);
//                                 final double scale =
//                                     _minScale + ((_maxScale - _minScale) * tri);
//                                 final double opacity = 0.35 + (0.65 * tri);

//                                 return Container(
//                                   margin: EdgeInsets.symmetric(
//                                     horizontal: baseDotSize * 0.5,
//                                   ),
//                                   child: Transform.scale(
//                                     scale: scale,
//                                     child: Opacity(
//                                       opacity: opacity,
//                                       child: Container(
//                                         width: baseDotSize,
//                                         height: baseDotSize,
//                                         decoration: const BoxDecoration(
//                                           color: AppColors.textPrimary,
//                                           shape: BoxShape.circle,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                             ),
//                             SizedBox(height: subtitleFont * 0.6),
//                             Text(
//                               'Loading...',
//                               style: TextStyle(
//                                 color: AppColors.textSecondary,
//                                 fontSize: subtitleFont,
//                               ),
//                             ),
//                             SizedBox(height: subtitleFont * 1.8),
//                             Container(
//                               width: 180,
//                               height: 1.5,
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.6),
//                                 borderRadius: BorderRadius.circular(2),
//                               ),
//                             ),
//                             SizedBox(height: subtitleFont * 1.5),
//                             Text('Version 1.0.0', style: AppTextStyles.version),
//                             SizedBox(height: 6),
//                             Text(
//                               '© 2025 YB Nexus. All rights reserved.',
//                               style: TextStyle(
//                                 color: AppColors.textSecondary,
//                                 fontSize: (subtitleFont * 0.85),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
