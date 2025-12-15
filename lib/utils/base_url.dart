// lib/utils/base_url.dart
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

String getBaseUrl() {
  // For web
  if (kIsWeb) return 'http://localhost:5000';

  // For Android emulator (Android Studio default)
  if (Platform.isAndroid) return 'http://10.0.2.2:5000';

  // For Genymotion emulator
  // if (Platform.isAndroid) return 'http://10.0.3.2:5000';

  // iOS simulator and desktop
  return 'http://localhost:5000';
}
