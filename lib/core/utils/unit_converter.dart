library;

/// Unit conversion utilities for weight and height
///
/// Storage format:
/// - Weight: Always stored in KG
/// - Height: Always stored in CM
///
/// Display format: Based on user's preferred units

class UnitConverter {
  // Weight conversions
  static const double kgToLbsFactor = 2.20462;
  static const double lbsToKgFactor = 0.453592;

  /// Convert weight from KG to the specified unit
  static double convertWeightFromKg(double kg, String unit) {
    if (unit == 'lb') {
      return kg * kgToLbsFactor;
    }
    return kg; // Already in KG
  }

  /// Convert weight to KG from the specified unit
  static double convertWeightToKg(double value, String unit) {
    if (unit == 'lb') {
      return value * lbsToKgFactor;
    }
    return value; // Already in KG
  }

  // Height conversions
  static const double cmToInFactor = 0.393701;
  static const double inToCmFactor = 2.54;

  /// Convert height from CM to the specified unit
  static double convertHeightFromCm(double cm, String unit) {
    if (unit == 'in') {
      return cm * cmToInFactor;
    }
    return cm; // Already in CM
  }

  /// Convert height to CM from the specified unit
  static double convertHeightToCm(double value, String unit) {
    if (unit == 'in') {
      return value * inToCmFactor;
    }
    return value; // Already in CM
  }

  /// Format weight for display with proper precision
  static String formatWeight(double value, String unit) {
    return '${value.toStringAsFixed(1)} $unit';
  }

  /// Format height for display with proper precision
  static String formatHeight(double value, String unit) {
    if (unit == 'in') {
      // For inches, show feet and inches (e.g., 5'9")
      final feet = (value / 12).floor();
      final inches = (value % 12).round();
      return '$feet\'$inches"';
    }
    return '${value.toStringAsFixed(1)} $unit';
  }
}
