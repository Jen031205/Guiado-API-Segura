/// Provides environment-specific API configuration.
///
/// Values passed with `--dart-define` are app configuration, not secret storage.
library;

import 'package:flutter/foundation.dart';

/// Holds the base URL for the selected development environment.
class AppConfig {
  /// Prevents creating configuration instances.
  const AppConfig._();

  static const String _definedUrl = String.fromEnvironment('API_BASE_URL');

  /// Returns the API base URL supplied at build or run time.
  ///
  /// Use an HTTPS URL outside local development.
  static String get apiBaseUrl {
    if (_definedUrl.isNotEmpty) return _definedUrl;
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return 'http://localhost:3000/api/v1';
    }
    return 'http://10.0.2.2:3000/api/v1';
  }
}
