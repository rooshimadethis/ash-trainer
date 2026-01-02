import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  /// Base function for the heading font (Outfit).
  /// Perfect for headlines, labels, and high-impact UI elements.
  static TextStyle headingStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) =>
      GoogleFonts.outfit(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
      );

  /// Base function for the body font (Lexend).
  /// Optimized for legibility and long-form content.
  static TextStyle bodyStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) =>
      GoogleFonts.lexend(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
      );

  // --- Convenience Getters ---
  static TextStyle get display => headingStyle();
  static TextStyle get body => bodyStyle();

  static TextStyle get h1 => headingStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        height: 1.0,
        letterSpacing: -1.5,
      );

  static TextStyle get h2 => headingStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -0.8,
      );

  static TextStyle get h3 => headingStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -0.5,
      );

  static TextStyle get h4 => headingStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.0,
        letterSpacing: -0.2,
      );

  static TextStyle get buttonText => headingStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      );

  static TextStyle get bodyLarge => bodyStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get bodyMedium => bodyStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get bodySmall => bodyStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  static TextStyle get label => headingStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.0,
      );

  static TextStyle get labelLarge => headingStyle(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      );

  static TextStyle get labelSmall => headingStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      );
}
