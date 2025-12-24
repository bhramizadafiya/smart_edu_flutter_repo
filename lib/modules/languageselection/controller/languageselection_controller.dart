// lib/modules/languageselection/controller/languageselection_controller.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api_endpoints.dart';
import '../../../utils/auth_token_service.dart';

class LanguageItem {
  final String id;
  final String title;
  final String subtitle;
  final String shortLabel;
  final int colorValue;

  LanguageItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.shortLabel,
    required this.colorValue,
  });
}

class LanguageSelectionController extends GetxController {
  // Dynamic languages from API
  final languages = RxList<LanguageItem>([]);
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  final AuthTokenService authService = Get.find<AuthTokenService>();

  // Selected language index
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLanguages(); // Load from API on start

    ever(selectedIndex, (val) => debugPrint('[LSController] selectedIndex changed -> $val'));
  }

  /// Fetch languages from backend
  Future<void> fetchLanguages() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    try {
      final headers = await authService.getAuthHeaders();

      final uri = Uri.parse(ApiConfig.getAllLanguages); // Add this in api_endpoints.dart

      final response = await http.post(uri, headers: headers);

      debugPrint('Languages API Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'success' && jsonData['statuscode'] == 200) {
          final List<dynamic> data = jsonData['data'] ?? [];

          languages.clear();

          for (var item in data) {
            final String langName = (item['language_name'] ?? '').toString().trim();

            if (langName.isEmpty) continue;

            final String title = langName.capitalizeFirst ?? langName;
            final String id = item['language_id'] ?? langName.toLowerCase();

            // Define short label, subtitle, and color based on language
            String shortLabel;
            String subtitle;
            int colorValue;

            switch (langName.toLowerCase()) {
              case 'gujarati':
                shortLabel = 'ગુ';
                subtitle = 'ગુજરાતી ભાષામાં અભ્યાસ કરો';
                colorValue = 0xFFF36B36; // Deep orange
                break;
              case 'hindi':
                shortLabel = 'हि';
                subtitle = 'हिंदी भाषा में अध्ययन करें';
                colorValue = 0xFFF3A24B; // Orange
                break;
              case 'english':
              default:
                shortLabel = 'En';
                subtitle = 'Study in English language';
                colorValue = 0xFF2C54D8; // Blue
                break;
            }

            languages.add(LanguageItem(
              id: id,
              title: title,
              subtitle: subtitle,
              shortLabel: shortLabel,
              colorValue: colorValue,
            ));
          }

          // Auto-select first language if none selected
          if (languages.isNotEmpty && selectedIndex.value >= languages.length) {
            selectedIndex.value = 0;
          }

          if (languages.isEmpty) {
            hasError.value = true;
            errorMessage.value = 'No languages available';
          }
        } else {
          throw Exception(jsonData['message'] ?? 'Failed to load languages');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching languages: $e');
      hasError.value = true;
      errorMessage.value = 'Failed to load languages. Please try again.';

      Get.snackbar(
        'Error',
        'Unable to fetch languages',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade800,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void select(int index) {
    if (index >= 0 && index < languages.length) {
      selectedIndex.value = index;
      debugPrint('Selected language: ${languages[index].title}');
    }
  }

  void onContinue() {
    if (languages.isEmpty) {
      Get.snackbar('Error', 'No language selected', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final selected = languages[selectedIndex.value];
    debugPrint('Continuing with language: ${selected.title} (${selected.id})');

    // TODO: Save selected language (shared prefs, secure storage, or API)
    // Example: await storage.write(key: 'selected_language', value: selected.id);

    Get.toNamed('/chat-resource-selection');
  }
}