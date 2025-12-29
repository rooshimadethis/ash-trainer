import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static TextStyle get display => GoogleFonts.spaceGrotesk();
  static TextStyle get body => GoogleFonts.notoSans();

  static TextStyle get h1 => display.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      );

  static TextStyle get h2 => display.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      );

  static TextStyle get h3 => display.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      );

  static TextStyle get buttonText => display.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
        letterSpacing: 0.5,
      );

  static TextStyle get bodyLarge =>
      body.copyWith(fontSize: 16, color: AppColors.textSecondary);

  static TextStyle get bodyMedium =>
      body.copyWith(fontSize: 14, color: AppColors.textSecondary);
}
