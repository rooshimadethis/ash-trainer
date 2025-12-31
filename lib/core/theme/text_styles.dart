import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static TextStyle get display => GoogleFonts.plusJakartaSans();
  static TextStyle get body =>
      GoogleFonts.inter(); // Switched to Inter for body

  static TextStyle get h1 => display.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w800, // Extra bold for H1
        color: AppColors.textPrimary,
        height: 1.1,
        letterSpacing: -1.0, // Tighter tracking
      );

  static TextStyle get h2 => display.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle get h3 => display.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: -0.3,
      );

  static TextStyle get h4 => display.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get buttonText => display.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        letterSpacing: 0.2,
      );

  static TextStyle get bodyLarge => body.copyWith(
        fontSize: 16,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => body.copyWith(
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get bodySmall => body.copyWith(
        fontSize: 12,
        color: AppColors.textMuted,
        height: 1.4,
      );

  static TextStyle get label => display.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: 0.5,
        textBaseline: TextBaseline.alphabetic,
      );

  static TextStyle get labelLarge => display.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: 0.1,
      );

  static TextStyle get labelSmall => display.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.2,
      );
}
