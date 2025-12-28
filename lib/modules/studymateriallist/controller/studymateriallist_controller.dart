// controllers/studymateriallist_controller.dart

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/utils/api_endpoints.dart';

class StudyMaterialListController extends GetxController {
  var studyMaterials = <Map<String, dynamic>>[].obs;
  var filteredMaterials = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  var sortOrder = 'desc'.obs;

  final TextEditingController searchController = TextEditingController();

  String? standardId;
  String? subjectId;

  final String userId = 'ybai_users_sav3bsx1m7';
  final String authToken = '19jnUAD7PlsPXatEukd5tEnCjsfCc3tvpBnejsqc';

  final dio.Dio _dio = dio.Dio();

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    standardId = args?['standard_id'] as String?;
    subjectId = args?['subject_id'] as String?;

    if (standardId == null || subjectId == null) {
      Get.snackbar(
        'Error',
        'Missing required information to load resources.',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      return;
    }

    fetchResources();

    debounce(
      searchQuery,
      (_) => fetchResources(),
      time: const Duration(milliseconds: 500),
    );
  }

  Future<void> fetchResources() async {
    if (standardId == null || subjectId == null) {
      isLoading.value = false;
      return;
    }

    isLoading.value = true;

    try {
      final payload = {
        "user_id": userId,
        "standard_id": standardId!,
        "subject_id": subjectId!,
        "language_id": "",
        "sorting": sortOrder.value,
        "title": searchQuery.value.trim(),
        "category": ""
      };

      final response = await _dio.post(
        ApiConfig.filterResources, // ← Using ApiConfig constant
        data: payload,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final List<dynamic> rawList = response.data['data'];

        final List<Map<String, dynamic>> mappedList = rawList.map((item) {
          final String fileType = (item['file_type'] ?? 'pdf').toString().toUpperCase();
          final String fileSize = item['file_size'] ?? 'Unknown';
          final String timeAgo = _formatTimeAgo(item['created_at']);

          return {
            'id': item['resource_id'],
            'title': item['resource_title'] ?? 'Untitled Resource',
            'subtitle': item['category'] ?? 'No category',
            'type': '$fileType • $fileSize',
            'status': _getStatusText(item['AI_status']),
            'statusColor': _getStatusColor(item['AI_status']),
            'icon': _getIcon(fileType),
            'time': timeAgo,
            'pdf_path': item['pdf_path'],
          };
        }).toList();

        studyMaterials.value = mappedList;
        filteredMaterials.value = List.from(mappedList);
      } else {
        throw Exception('API returned error status: ${response.data['message'] ?? 'Unknown'}');
      }
    } catch (e) {
      String errorMsg = 'Failed to load resources';
      if (e is dio.DioException) {
        errorMsg += ': ${e.message}';
        if (e.response?.data != null) {
          errorMsg += ' - ${e.response?.data['message'] ?? 'Server error'}';
        }
      }

      Get.snackbar(
        'Error',
        errorMsg,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 5),
      );

      studyMaterials.clear();
      filteredMaterials.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Formats created_at timestamp to relative time (e.g., "5 mins ago", "Just now")
  String _formatTimeAgo(String dateString) {
    try {
      DateTime utcDate = DateTime.parse('${dateString}Z');
      DateTime localDate = utcDate.toLocal();

      final now = DateTime.now();
      final difference = now.difference(localDate);

      if (difference.isNegative || difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        final mins = difference.inMinutes;
        return '$mins min${mins == 1 ? '' : 's'} ago';
      } else if (difference.inHours < 24) {
        final hours = difference.inHours;
        return '$hours hour${hours == 1 ? '' : 's'} ago';
      } else if (difference.inDays < 7) {
        final days = difference.inDays;
        return '$days day${days == 1 ? '' : 's'} ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks week${weeks == 1 ? '' : 's'} ago';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return '$months month${months == 1 ? '' : 's'} ago';
      } else {
        final years = (difference.inDays / 365).floor();
        return '$years year${years == 1 ? '' : 's'} ago';
      }
    } catch (e) {
      return 'Just now';
    }
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'processed':
        return 'Processed';
      case 'processing':
        return 'Processing';
      case 'failed':
        return 'Failed';
      default:
        return 'Pending';
    }
  }

  int _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'processed':
        return 0xFF00C853; // Green
      case 'processing':
        return 0xFFFFA000; // Amber
      case 'failed':
        return 0xFFFF1744; // Red
      default:
        return 0xFFFFA000; // Amber (Pending)
    }
  }

  String _getIcon(String type) {
    switch (type) {
      case 'PDF':
        return '📘';
      case 'DOC':
      case 'DOCX':
        return '📄';
      case 'TXT':
        return '📝';
      default:
        return '📄';
    }
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    fetchResources();
  }

  void onSortPressed() {
    sortOrder.value = sortOrder.value == 'asc' ? 'desc' : 'asc';
    fetchResources();
  }

  void onUploadPressed() {
    Get.toNamed('/add-study-material', arguments: {
      'standard_id': standardId,
      'subject_id': subjectId,
    });
  }

  void refreshList() {
    fetchResources();
  }

  void onPreviewPressed() {
    Get.snackbar(
      'Info',
      'Preview feature coming soon!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Trigger AI vector creation for chatting (uses ApiConfig constant)
  Future<bool> createResourceVector(String resourceId) async {
    try {
      final payload = {
        "resource_id": resourceId,
      };

      final response = await _dio.post(
        ApiConfig.createResourceVector, // ← Clean, centralized URL
        data: payload,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        Get.snackbar(
          'Success',
          'Resource is now ready for chat!',
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
          duration: const Duration(seconds: 3),
        );
        refreshList(); // Update status in list
        return true;
      } else {
        throw Exception(response.data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      String errorMsg = 'Failed to prepare resource for chat';
      bool alreadyProcessed = false;

      if (e is dio.DioException && e.response?.data != null) {
        final serverMsg = e.response?.data['message']?.toString() ?? '';
        errorMsg += ': $serverMsg';
        if (serverMsg.toLowerCase().contains('already')) {
          alreadyProcessed = true;
        }
      }

      Get.snackbar(
        alreadyProcessed ? 'Ready' : 'Notice',
        alreadyProcessed
            ? 'Resource already processed. Opening chat...'
            : errorMsg,
        backgroundColor: alreadyProcessed
            ? Colors.blue.shade100
            : Colors.orange.shade100,
        colorText: alreadyProcessed
            ? Colors.blue.shade900
            : Colors.orange.shade900,
        duration: const Duration(seconds: 4),
      );

      return alreadyProcessed; // Allow chat if already processed
    }
  }

  /// Update resource via API
  Future<void> updateResource({
    required String resourceId,
    required String title,
    required String description,
    required String category,
  }) async {
    try {
      final payload = {
        "resource_id": resourceId,
        "title": title.trim(),
        "description": description.trim(),
        "category": category,
      };

      final response = await _dio.post(
        ApiConfig.updateResource, 
        data: payload,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        Get.snackbar(
          'Success',
          'Resource updated successfully',
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
        );
        refreshList();
      } else {
        throw Exception('Failed to update resource');
      }
    } catch (e) {
      String errorMsg = 'Failed to update resource';
      if (e is dio.DioException && e.response?.data != null) {
        errorMsg += ': ${e.response?.data['message'] ?? e.message}';
      }
      Get.snackbar(
        'Error',
        errorMsg,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 5),
      );
    }
  }

  /// Delete resource via API
  Future<void> deleteResource(String resourceId) async {
    try {
      final payload = {"resource_id": resourceId};

      final response = await _dio.post(
        ApiConfig.deleteResources, // Add if you define it in ApiConfig
        data: payload,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        Get.snackbar(
          'Success',
          'Resource deleted successfully',
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
          duration: const Duration(seconds: 3),
        );
        refreshList();
      } else {
        throw Exception('Failed to delete resource');
      }
    } catch (e) {
      String errorMsg = 'Failed to delete resource';
      if (e is dio.DioException) {
        errorMsg += ': ${e.message}';
        if (e.response?.data != null) {
          errorMsg += ' - ${e.response?.data['message'] ?? ''}';
        }
      }
      Get.snackbar(
        'Error',
        errorMsg,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}