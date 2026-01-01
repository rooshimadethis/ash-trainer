import 'package:flutter/material.dart';

class AppColors {
  // --- Brand Colors ---
  static const Color primary = Color(0xFF7C3AED); // Modern Violet
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color primaryDark = Color(0xFF5B21B6);
  static const Color accentCoral = Color(0xFFFB7185); // Warm accent
  static const Color accentMint = Color(0xFF34D399); // Fresh accent

  // --- Background & Surfaces ---
  // Dark (current) - Soft Charcoal/Navy
  static const Color background = Color(0xFF0F1219); // Deep, soft navy
  static const Color surface = Color(0xFF181D27); // Slightly lighter
  static const Color surfaceLighter = Color(0xFF242C3D);
  static const Color surfaceHighlight = Color(0xFF323D52);

  // Light (new)
  static const Color backgroundLight = Color(0xFFF8FAFC); // Slate 50
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceLightSecondary = Color(0xFFF1F5F9); // Slate 100
  static const Color surfaceLightHighlight = Color(0xFFE2E8F0); // Slate 200

  // --- Chat Bubbles ---
  static const Color ashMessageDark = Color(0xFF1E293B);
  static const Color ashMessageLight = Color(0xFFF1F5F9);
  static const Color userMessage = Color(0xFF6366F1); // Indigo 500

  // --- Borders & Dividers ---
  static const Color border = Color(0xFF27272A); // Zinc 800
  static const Color borderLight =
      Color(0xFFE2E8F0); // Slate 200 (for light mode)

  // --- Text Colors ---
  static const Color textPrimaryDark = Color(0xFFFAFAFA); // Zinc 50
  static const Color textSecondaryDark = Color(0xFFA1A1AA); // Zinc 400
  static const Color textPrimaryLight = Color(0xFF0F172A); // Slate 900
  static const Color textSecondaryLight = Color(0xFF475569); // Slate 600
  static const Color textMuted = Color(0xFF94A3B8); // Slate 400

  // --- Semantic Colors (Workouts) ---
  // Softened to 400-level shades for a "friendlier" look
  static const Color runEasy = Color(0xFF34D399); // Emerald 400
  static const Color runLong = Color(0xFF60A5FA); // Blue 400
  static const Color runTempo = Color(0xFFFBBF24); // Amber 400
  static const Color runIntervals = Color(0xFFF87171); // Red 400
  static const Color strength = Color(0xFFA78BFA); // Violet 400
  static const Color mobility = Color(0xFF22D3EE); // Cyan 400
  static const Color rest = Color(0xFFA1A1AA); // Zinc 400
  static const Color race = Color(0xFFFDE047); // Yellow 300

  // --- Training Block Colors ---
  static const Color blockBase = Color(0xFF2DD4BF); // Teal 400
  static const Color blockBuild = Color(0xFFA78BFA); // Violet 400
  static const Color blockPeak = Color(0xFFFB7185); // Rose 400
  static const Color blockTaper = Color(0xFF818CF8); // Indigo 400
  static const Color blockRecovery = Color(0xFF34D399); // Emerald 400
  static const Color blockRace = Color(0xFFFBBF24); // Amber 400

  static const Color success = Color(0xFF4ADE80); // Green 400
  static const Color error = Color(0xFFF87171); // Red 400
  static const Color warning = Color(0xFFFBBF24); // Amber 400

  // --- Opacity Constants ---
  static const double glassTintOpacity = 0.20; // Tinted cards, buttons, inputs
  static const double glassSurfaceOpacity = 0.5; // Neutral frosted glass
  static const double glassInactiveOpacity = 0.05; // Inactive elements
  static const double glassHighlightDarkOpacity = 0.03; // Dark mode highlights
  static const double glassHighlightLightOpacity = 0.5; // Light mode highlights
  static const double glassShadowOpacity = 0.15; // Standard depth shadow
  static const double glassOverlayOpacity =
      0.1; // Slider overlay / interactions
  static const double glassThumbOpacity = 0.8; // Slider thumb / strong accents

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Helpers
  static const Color backgroundDark = background;
  static const Color surfaceDark = surface;
  static const Color textPrimary = textPrimaryDark; // Legacy fallback
  static const Color textSecondary = textSecondaryDark; // Legacy fallback
  static const Color divider = border;
  static const Color accentBlue = primaryLight;

  // Dynamic aliases (can be updated based on theme)
  static const Color ashMessage = ashMessageDark;
}
