// languageselection_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/design_system.dart'; // your AppColors, AppTextStyles
import '../controller/languageselection_controller.dart';
import '../../../widgets/custom_appbar.dart';

class LanguageSelectionView extends StatelessWidget {
  const LanguageSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<LanguageSelectionController>();
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final isWide = width > 720;

    // sizing helpers
    final double iconSize = isWide ? 88 : 72;
    final double avatarSize = isWide ? 56 : 48;
    final double cardRadius = 12.0;
    final horizontalPadding = isWide ? width * 0.12 : 18.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Select Language'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              const SizedBox(height: 18),

              // icon
              Center(
                child: Container(
                  height: iconSize,
                  width: iconSize,
                 
                  child: Center(
                    child: Icon(
                      Icons.translate,
                      size: iconSize * .95,
                      color:  Color(0xFF66D1B2),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Heading + subtitle
              Text(
                'Choose your preferred language',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isWide ? 22 : 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textcolor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select the language for your study materials and\nAI interactions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.black54,
                  height: 1.35,
                ),
              ),

              const SizedBox(height: 20),

              // language list (expanded, scrollable)
              Expanded(
                child: Obx(
                  () => ListView.separated(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: ctrl.languages.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, idx) {
                      final item = ctrl.languages[idx];

                      return Obx(() {
                        final selected = ctrl.selectedIndex.value == idx;

                        return Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(cardRadius),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(cardRadius),
                            onTap: () {
                              debugPrint(
                                '[View] tile tapped idx: $idx, ctrl.hash=${ctrl.hashCode}',
                              );
                              ctrl.select(idx);
                            },
                            splashFactory: InkRipple.splashFactory,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOut,
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 14,
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color.fromARGB(255, 239, 252, 248)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(cardRadius),
                                border: Border.all(
                                  color: selected
                                      ? AppColors.gradientMiddle
                                      : Colors.grey.shade300,
                                  width: selected ? 2 : 1,
                                ),
                                boxShadow: selected
                                    ? [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.03),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.01),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                              ),
                              child: Row(
                                children: [
                                  // avatar
                                  Container(
                                    height: avatarSize,
                                    width: avatarSize,
                                    decoration: BoxDecoration(
                                      color: Color(item.colorValue),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.shortLabel,
                                        style: TextStyle(
                                          fontSize: avatarSize * 0.42,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // text
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          style: TextStyle(
                                            fontSize: isWide ? 17 : 16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.textcolor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.subtitle,
                                          style: TextStyle(
                                            fontSize: isWide ? 13.5 : 13,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // radio/check indicator
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? AppColors.gradientMiddle
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: selected
                                            ? AppColors.gradientStart
                                            : Colors.grey.shade400,
                                        width: selected ? 0 : 1.3,
                                      ),
                                    ),
                                    child: Center(
                                      child: selected
                                          ? const Icon(
                                              Icons.check,
                                              size: 15,
                                              color: Colors.white,
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ),

              // bottom area: continue button + small text
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: isWide ? 54 : 50,
                    child: ElevatedButton(
                      onPressed: () => ctrl.onContinue(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.textcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: isWide ? 16.5 : 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'You can change this later in settings',
                    style: TextStyle(fontSize: 12.5, color: Colors.black45),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      // help action
                      // e.g. open a help page or show bottom sheet
                      Get.snackbar(
                        'Help',
                        'More info about choosing a language',
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.gradientMiddle,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Need help choosing?',
                          style: TextStyle(
                            color: AppColors.gradientMiddle,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
