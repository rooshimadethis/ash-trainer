import 'package:flutter/material.dart';

class AppColors {
  // Use Sky-500/600 for a calmer, less "electric" primary blue that fits the slate theme
  static const Color primary = Color(0xFF0EA5E9); // Sky 500
  static const Color primaryHover = Color(0xFF0284C7); // Sky 600

  // Neutral "Gallery" Base
  static const Color backgroundLight = Color(0xFFF9FAFB); // Gray 50
  static const Color backgroundDark = Color(0xFF0F172A); // Slate 900
  static const Color surfaceDark = Color(0xFF1E293B); // Slate 800
  static const Color surfaceHighlight = Color(0xFF334155); // Slate 700
  static const Color borderDark = Color(0xFF334155); // Slate 700

  static const Color textSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color surface = Color(0xFF1E293B); // Slate 800
  static const Color divider = Color(0xFF334155); // Slate 700

  static const Color accentOrange =
      Color(0xFFFDBA74); // Keeping as secondary for now
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Activity Colors (Semantic)
  static const Color runEasy = Color(0xFF10B981); // Emerald 500
  static const Color runLong = Color(0xFF3B82F6); // Blue 500
  static const Color runTempo = Color(0xFFF59E0B); // Amber 500
  static const Color runIntervals = Color(0xFFEF4444); // Red 500
  static const Color strength = Color(0xFF8B5CF6); // Violet 500
  static const Color mobility = Color(0xFF14B8A6); // Teal 500
  static const Color rest = Color(0xFF64748B); // Slate 500
  static const Color race = Color(0xFFEAB308); // Yellow 500

  // Block Intent Colors
  static const Color blockBase = Color(0xFF06B6D4); // Cyan 500 - Foundation
  static const Color blockBuild =
      Color(0xFFF97316); // Orange 500 - Growing intensity
  static const Color blockPeak = Color(0xFFEC4899); // Pink 500 - Max effort
  static const Color blockTaper =
      Color(0xFF8B5CF6); // Violet 500 - Sharpening (distinct from Indigo)
  static const Color blockRecovery =
      Color(0xFF10B981); // Emerald 500 - Rest & Restore
}
