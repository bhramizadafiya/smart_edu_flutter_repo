import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyMaterialListController extends GetxController {
  /// Original full list of study materials (source of truth)
  var studyMaterials = <Map<String, dynamic>>[].obs;

  /// Filtered and sorted list shown in the UI
  var filteredMaterials = <Map<String, dynamic>>[].obs;

  /// Reactive search query
  var searchQuery = ''.obs;

  /// Sort state: true = ascending (A-Z), false = descending (Z-A)
  final RxBool sortAscending = false.obs;

  /// TextEditingController for the search TextField
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadStudyMaterials();

    // Start with descending order (Z-A) by default
    sortAscending.value = false;

    // Debounce search: wait 300ms after typing stops
    debounce(
      searchQuery,
      (_) => applyFilterAndSort(),
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

    filteredMaterials.value = List.from(studyMaterials);
  }

  /// Called when user types in search bar
  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  /// Clear search and reset list
  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    applyFilterAndSort();
  }

  /// Upload button action
  void onUploadPressed() {
    Get.toNamed('/add-study-material');
  }

  /// Preview button action
  void onPreviewPressed() {
    Get.snackbar('Preview', 'Preview Book clicked', snackPosition: SnackPosition.BOTTOM);
  }

  /// Toggle sort order between ascending and descending
  void onSortPressed() {
    sortAscending.value = !sortAscending.value;
    applyFilterAndSort();
  }

  /// Public method: Apply search filter and sorting (called from view after edit/delete/add)
  void applyFilterAndSort() {
    List<Map<String, dynamic>> tempList = List.from(studyMaterials);

    // Apply search filter
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isNotEmpty) {
      tempList = tempList.where((material) {
        return material['title'].toString().toLowerCase().contains(query) ||
            material['subtitle'].toString().toLowerCase().contains(query) ||
            material['type'].toString().toLowerCase().contains(query);
      }).toList();
    }

    // Apply sorting by title
    tempList.sort((a, b) {
      final comparison = a['title']
          .toString()
          .toLowerCase()
          .compareTo(b['title'].toString().toLowerCase());
      return sortAscending.value ? comparison : -comparison;
    });

    // Update displayed list
    filteredMaterials.value = tempList;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}