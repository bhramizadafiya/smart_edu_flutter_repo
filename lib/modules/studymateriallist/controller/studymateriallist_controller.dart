import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyMaterialListController extends GetxController {
  // Original full list
  var studyMaterials = <Map<String, dynamic>>[].obs;

  // Filtered list shown in UI
  var filteredMaterials = <Map<String, dynamic>>[].obs;

  // Reactive search query
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadStudyMaterials();

    // Debounce search: wait 300ms after user stops typing before filtering
    debounce(
      searchQuery,
      (_) => filterMaterials(),
      time: const Duration(milliseconds: 300),
    );
  }

  void loadStudyMaterials() {
    studyMaterials.value = [
      {
        'title': 'Mathematics Textbook',
        'subtitle': 'Class 12 NCERT',
        'type': 'PDF • 15.2 MB',
        'status': 'Processed',
        'statusColor': 0xFF00C853,
        'icon': '📘',
        'time': '2 days ago',
      },
      {
        'title': 'Physics Notes Chapter 5',
        'subtitle': 'Handwritten Notes',
        'type': 'DOC • 8.5 MB',
        'status': 'Processing',
        'statusColor': 0xFFFFA000,
        'icon': '📓',
        'time': '5 days ago',
      },
      {
        'title': 'Chemistry Lab Manual',
        'subtitle': 'Practical Experiments',
        'type': 'PDF • 22.8 MB',
        'status': 'Processed',
        'statusColor': 0xFF00C853,
        'icon': '📙',
        'time': '1 week ago',
      },
      {
        'title': 'Biology Diagrams',
        'subtitle': 'Cell Structure Images',
        'type': 'IMG • 5.2 MB',
        'status': 'Failed',
        'statusColor': 0xFFFF1744,
        'icon': '📗',
        'time': '3 days ago',
      },
    ];

    // Initially show all
    filteredMaterials.value = studyMaterials;
  }

  void filterMaterials() {
    final query = searchQuery.value.trim().toLowerCase();

    if (query.isEmpty) {
      filteredMaterials.value = studyMaterials;
    } else {
      filteredMaterials.value = studyMaterials.where((material) {
        final title = material['title'].toString().toLowerCase();
        return title.contains(query);
      }).toList();
    }
  }

  // Call this from TextField's onChanged
  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  // Clear search
  void clearSearch() {
    searchQuery.value = '';
  }

  // Your existing actions
  void onUploadPressed() {
    Get.snackbar(
      'Upload',
      'Add new material clicked',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.toNamed('/add-study-material');
  }

  void onPreviewPressed() {
    Get.snackbar(
      'Preview',
      'Preview Book clicked',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onSortPressed() {
    Get.snackbar(
      'Sort',
      'Sort button clicked',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}