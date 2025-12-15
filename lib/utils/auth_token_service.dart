import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../utils/api_endpoints.dart';

class AuthTokenService extends GetxService {
  static const _tokenKey = 'auth_token';
  static const _expiryKey = 'auth_token_expiry';
  static const _userIdKey = 'user_id';

  final _storage = const FlutterSecureStorage();

  /// Returns stored token if valid, otherwise generates a new one.
  Future<String?> getValidToken() async {
    final token = await _storage.read(key: _tokenKey);
    final expiryString = await _storage.read(key: _expiryKey);

    if (token != null && expiryString != null) {
      final expiry = DateTime.tryParse(expiryString);
      if (expiry != null && DateTime.now().isBefore(expiry)) {
        return token; // still valid
      }
    }

    // expired or not available → generate new token
    return await _generateNewToken();
  }

  /// Force generate a new token from API
  Future<String?> _generateNewToken() async {
    final userId = await _storage.read(key: _userIdKey);
    if (userId == null) {
      debugPrint('No user_id found. Cannot generate token.');
      return null;
    }

    try {
      final uri = Uri.parse(ApiConfig.authtoken);
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        final data = body['data'] as Map<String, dynamic>?;

        if (data != null) {
          final accessToken = data['access_token'] as String?;
          final expiresAt = data['expires_at'] as String?;

          if (accessToken != null && expiresAt != null) {
            await _storage.write(key: _tokenKey, value: accessToken);
            await _storage.write(key: _expiryKey, value: expiresAt);

            debugPrint('Token generated successfully.');
            return accessToken;
          }
        }
      } else {
        debugPrint('Failed to generate token: ${response.body}');
      }
    } catch (e) {
      debugPrint('Token generation error: $e');
    }

    return null;
  }

  /// Adds Authorization header with Bearer token.
  Future<Map<String, String>> getAuthHeaders({
    Map<String, String>? extraHeaders,
  }) async {
    final token = await getValidToken();
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      ...?extraHeaders,
    };
    return headers;
  }

  /// Clears all token data (called on logout)
  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _expiryKey);
  }
}
