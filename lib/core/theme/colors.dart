import 'package:flutter/material.dart';

class AppColors {
  // --- Brand Colors ---
  static const Color primary = Color(0xFF3B82F6); // Modern Blue
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF2563EB);

  // --- Background & Surfaces ---
  // Using a deep, modern charcoal/slate palette
  static const Color background = Color(0xFF0C0C0E); // Very dark charcoal
  static const Color surface =
      Color(0xFF161618); // Slightly lighter card surface
  static const Color surfaceLighter = Color(0xFF232326);
  static const Color surfaceHighlight = Color(0xFF2C2C2E);

  // --- Borders & Dividers ---
  static const Color border = Color(0xFF27272A); // Zinc 800
  static const Color borderLight = Color(0xFF3F3F46); // Zinc 700

  // --- Text Colors ---
  static const Color textPrimary = Color(0xFFFAFAFA); // Zinc 50
  static const Color textSecondary = Color(0xFFA1A1AA); // Zinc 400
  static const Color textMuted = Color(0xFF71717A); // Zinc 500

  // --- Semantic Colors (Workouts) ---
  static const Color runEasy = Color(0xFF10B981); // Emerald 500
  static const Color runLong = Color(0xFF3B82F6); // Blue 500
  static const Color runTempo = Color(0xFFF59E0B); // Amber 500
  static const Color runIntervals = Color(0xFFEF4444); // Red 500
  static const Color strength = Color(0xFF8B5CF6); // Violet 500
  static const Color mobility = Color(0xFF06B6D4); // Cyan 500
  static const Color rest = Color(0xFF71717A); // Zinc 500
  static const Color race = Color(0xFFFACC15); // Yellow 400

  // --- Training Block Colors (Principles from calendar_block_visualization.md) ---
  static const Color blockBase =
      Color(0xFF0D9488); // Teal 600 - Foundation/Stability
  static const Color blockBuild = Color(
      0xFF8B5CF6); // Changed to Violet for Build to contrast with Blue brand
  static const Color blockPeak =
      Color(0xFFE11D48); // Rose 600 - Maximum Intensity
  static const Color blockTaper =
      Color(0xFF6366F1); // Indigo 500 - Recovery/Sharpness
  static const Color blockRecovery =
      Color(0xFF10B981); // Emerald 500 - Active Rest
  static const Color blockRace = Color(0xFFF59E0B); // Amber 500 - The Big Event

  // --- Status & Utility ---
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Helpers
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = background;
  static const Color surfaceDark = surface;
  static const Color divider = border;
  static const Color accentBlue = primaryLight;
}
