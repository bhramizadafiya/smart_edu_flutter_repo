import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyMaterialListController extends GetxController {
  /// Original full list of study materials
  var studyMaterials = <Map<String, dynamic>>[].obs;

  /// Filtered list shown in the UI
  var filteredMaterials = <Map<String, dynamic>>[].obs;

  /// Reactive search query
  var searchQuery = ''.obs;

  /// TextEditingController for the search TextField
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    // Load initial study materials
    loadStudyMaterials();

    // Debounce search: wait 300ms after user stops typing before filtering
    debounce(
      searchQuery,
      (_) => filterMaterials(),
      time: const Duration(milliseconds: 300),
    );
  }

  /// Load initial study materials (mock data)
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

    // Initially show all materials
    filteredMaterials.value = List<Map<String, dynamic>>.from(studyMaterials);
  }

  /// Filter materials based on search query
  void filterMaterials() {
    final query = searchQuery.value.trim().toLowerCase();

    if (query.isEmpty) {
      filteredMaterials.value = List<Map<String, dynamic>>.from(studyMaterials);
    } else {
      filteredMaterials.value = studyMaterials.where((material) {
        final title = material['title'].toString().toLowerCase();
        final subtitle = material['subtitle'].toString().toLowerCase();
        final type = material['type'].toString().toLowerCase();
        return title.contains(query) ||
            subtitle.contains(query) ||
            type.contains(query);
      }).toList();
    }
  }

  /// Called when user types in the search bar
  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  /// Clear search input and reset the list
  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    filteredMaterials.value = List<Map<String, dynamic>>.from(studyMaterials);
  }

  /// Upload button action
  void onUploadPressed() {
    Get.snackbar(
      'Upload',
      'Add new material clicked',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.toNamed('/add-study-material');
  }

  /// Preview button action
  void onPreviewPressed() {
    Get.snackbar(
      'Preview',
      'Preview Book clicked',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Sort button action
  void onSortPressed() {
    Get.snackbar(
      'Sort',
      'Sort button clicked',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
