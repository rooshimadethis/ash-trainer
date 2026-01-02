import 'package:logger/logger.dart';

/// Centralized logging utility for the application.
///
/// Uses the `logger` package with custom configuration to ensure all logs
/// appear in the debug console during development.
///
/// Usage:
/// ```dart
/// AppLogger.d('Debug message');
/// AppLogger.i('Info message');
/// AppLogger.w('Warning message');
/// AppLogger.e('Error message', error: exception, stackTrace: stackTrace);
/// ```
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to display in stack trace
      errorMethodCount: 8, // Number of method calls for errors
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print emoji for log levels
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: Level.debug, // Show all logs in debug mode
  );

  /// Log a debug message
  /// Use for detailed diagnostic information
  static void d(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log an info message
  /// Use for general informational messages
  static void i(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log a warning message
  /// Use for potentially harmful situations
  static void w(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log an error message
  /// Use for error events that might still allow the app to continue
  static void e(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log a fatal message
  /// Use for very severe error events that will presumably lead the app to abort
  static void f(dynamic message, {Object? error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  // Legacy method aliases for backwards compatibility
  @Deprecated('Use AppLogger.e() instead')
  static void error(String message, Object error, [StackTrace? stackTrace]) {
    e(message, error: error, stackTrace: stackTrace);
  }

  @Deprecated('Use AppLogger.w() instead')
  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    w(message, error: error, stackTrace: stackTrace);
  }

  @Deprecated('Use AppLogger.i() instead')
  static void info(String message) {
    i(message);
  }
}
