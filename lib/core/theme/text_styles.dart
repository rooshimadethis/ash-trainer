import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle get display => GoogleFonts.spaceGrotesk();
  static TextStyle get body => GoogleFonts.lexend();

  static TextStyle get h1 => display.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        height: 1.0,
        letterSpacing: -1.5,
      );

  static TextStyle get h2 => display.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -0.8,
      );

  static TextStyle get h3 => display.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -0.5,
      );

  static TextStyle get h4 => display.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.0,
        letterSpacing: -0.2,
      );

  static TextStyle get buttonText => display.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      );

  static TextStyle get bodyLarge => body.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get bodyMedium => body.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get bodySmall => body.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  static TextStyle get label => display.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.0,
        textBaseline: TextBaseline.alphabetic,
      );

  static TextStyle get labelLarge => display.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      );

  static TextStyle get labelSmall => display.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      );
}
