// languageselection_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageItem {
  final String id;
  final String title;
  final String subtitle;
  final String shortLabel; // e.g. 'हि' 'ગુ' 'En'
  final int colorValue; // ARGB color int for avatar background

  LanguageItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.shortLabel,
    required this.colorValue,
  });
}

class LanguageSelectionController extends GetxController {
  // languages list (you can fetch from remote or localize later)
  final languages = <LanguageItem>[
    LanguageItem(
      id: 'hi_alt',
      title: 'Hindi',
      subtitle: 'हिंदी भाषा में अध्ययन करें',
      shortLabel: 'हि',
      colorValue:
          0xFFF3A24B, // orange (duplicate to show selected state example)
    ),
    LanguageItem(
      id: 'gu',
      title: 'Gujarati',
      subtitle: 'ગુજરાતી ભાષામાં અભ્યાસ કરો',
      shortLabel: 'ગુ',
      colorValue: 0xFFF36B36, // deep orange
    ),
    LanguageItem(
      id: 'en',
      title: 'English',
      subtitle: 'Study in English language',
      shortLabel: 'En',
      colorValue: 0xFF2C54D8, // blue
    ),
  ].obs;

  // index of selected language
  final selectedIndex = 0.obs;

  // tapped language

  @override
  void onInit() {
    super.onInit();
    ever(
      selectedIndex,
      (val) => debugPrint(
        '[LSController:${hashCode}] selectedIndex changed -> $val',
      ),
    );
  }

  void select(int index) {
    debugPrint(
      '[LSController:${hashCode}] select called with $index  before=${selectedIndex.value}',
    );
    if (index >= 0 && index < languages.length) {
      selectedIndex.value = index;
    }
    debugPrint(
      '[LSController:${hashCode}] after selectedIndex=${selectedIndex.value}',
    );
  }

  // continue action
  void onContinue() {
    final selected = languages[selectedIndex.value];
    // TODO: save selection to store, settings, or API
    // Example:
    // settingsService.saveLanguage(selected.id);
    // For now just print and pop:
    debugPrint('Selected language: ${selected.title} (${selected.id})');
    Get.toNamed('/chat-resource-selection');
  }
}
