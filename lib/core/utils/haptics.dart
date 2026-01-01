import 'package:flutter/services.dart';

/// Centralized utility for haptic feedback to ensure consistency across the app.
class AshHaptics {
  /// Subtle feedback for minor interactions like slider movements or ticks.
  static Future<void> lightImpact() async {
    await HapticFeedback.lightImpact();
  }

  /// Standard feedback for most taps, clicks, and button presses.
  static Future<void> mediumImpact() async {
    await HapticFeedback.mediumImpact();
  }

  /// Stronger feedback for more significant actions.
  static Future<void> heavyImpact() async {
    await HapticFeedback.heavyImpact();
  }

  /// Celebratory feedback for successful completions.
  static Future<void> success() async {
    // A standard success vibration pattern can be added here if needed,
    // for now we use mediumImpact as a placeholder for simpler success feel
    // or we can use HapticFeedback.vibrate().
    await HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 50));
    await HapticFeedback.mediumImpact();
  }
}
