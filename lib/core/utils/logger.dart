import 'dart:developer' as developer;

/// Simple debug logger for development
/// Uses dart:developer log() to output to debug console
class AppLogger {
  /// Log an error with full context
  static void error(String message, Object error, [StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'ERROR',
      error: error,
      stackTrace: stackTrace,
      level: 1000, // Error level
    );
  }

  /// Log a warning
  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'WARNING',
      error: error,
      stackTrace: stackTrace,
      level: 900, // Warning level
    );
  }

  /// Log info (for debugging)
  static void info(String message) {
    developer.log(
      message,
      name: 'INFO',
      level: 800, // Info level
    );
  }
}
