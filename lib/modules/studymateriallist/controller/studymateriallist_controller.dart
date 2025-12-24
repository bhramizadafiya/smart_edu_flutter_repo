// studymateriallist_controller.dart
import 'package:flutter/material.dart';
import 'package:get/Get.dart';

class StudyMaterialListController extends GetxController {
  var studyMaterials = <Map<String, dynamic>>[].obs;
  var filteredMaterials = <Map<String, dynamic>>[].obs;

  var searchQuery = ''.obs;
  final RxBool sortAscending = false.obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadStudyMaterials(); // Initial mock data

    debounce(searchQuery, (_) => applyFilterAndSort(), time: const Duration(milliseconds: 300));
  }

  void loadStudyMaterials() {
    studyMaterials.value = [
      // Your mock data...
    ];
    applyFilterAndSort();
  }

  // Called after successful upload to refresh list
  void fetchMaterials() {
    applyFilterAndSort(); // Just refresh UI from existing data
    Get.snackbar('Refreshed', 'Study materials updated', backgroundColor: Colors.green.shade100);
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    applyFilterAndSort();
  }

  void onUploadPressed() {
    Get.toNamed('/add-study-material');
  }

  void onPreviewPressed() {
    Get.snackbar('Preview', 'Preview Book clicked', snackPosition: SnackPosition.BOTTOM);
  }

  void onSortPressed() {
    sortAscending.value = !sortAscending.value;
    applyFilterAndSort();
  }

  void applyFilterAndSort() {
    List<Map<String, dynamic>> temp = List.from(studyMaterials);

    final query = searchQuery.value.trim().toLowerCase();
    if (query.isNotEmpty) {
      temp = temp.where((m) =>
          m['title'].toString().toLowerCase().contains(query) ||
          m['subtitle'].toString().toLowerCase().contains(query)).toList();
    }

    temp.sort((a, b) {
      final comp = a['title'].toString().toLowerCase().compareTo(b['title'].toString().toLowerCase());
      return sortAscending.value ? comp : -comp;
    });

    filteredMaterials.value = temp;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}