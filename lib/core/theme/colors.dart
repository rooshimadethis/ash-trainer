import 'package:flutter/material.dart';

class AppColors {
  // ============================================================================
  // UNIFIED 6-COLOR PALETTE
  // ============================================================================
  // A constrained, cohesive palette used consistently across the entire app.
  // Each color has a semantic meaning and is used for related concepts.

  /// Emerald - Success, completion, easy effort, recovery
  static const Color emerald = Color(0xFF34D399);

  /// Blue - Duration, time, long efforts, sleep
  static const Color blue = Color(0xFF60A5FA);

  /// Amber - Warning, tempo, countdown, race
  static const Color amber = Color(0xFFFBBF24);

  /// Rose - High intensity, intervals, heart rate, errors
  static const Color rose = Color(0xFFFB7185);

  /// Violet - Strength, building, power
  static const Color violet = Color(0xFFA78BFA);

  /// Cyan - Mobility, flexibility, readiness
  static const Color cyan = Color(0xFF22D3EE);

  /// Neutral - Rest days, muted states
  static const Color neutral = Color(0xFFA1A1AA);

  // ============================================================================
  // BRAND COLORS
  // ============================================================================

  static const Color primary = Color(0xFF6366F1); // Indigo 500
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);

  // ============================================================================
  // BACKGROUND & SURFACES
  // ============================================================================

  // Dark mode
  static const Color background = Color(0xFF0F172A); // Slate 900
  static const Color surface = Color(0xFF1E293B); // Slate 800
  static const Color surfaceLighter = Color(0xFF334155); // Slate 700
  static const Color surfaceHighlight = Color(0xFF475569); // Slate 600

  // Light mode
  static const Color backgroundLight = Color(0xFFF8FAFC); // Slate 50
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceLightSecondary = Color(0xFFF1F5F9); // Slate 100
  static const Color surfaceLightHighlight = Color(0xFFE2E8F0); // Slate 200

  // ============================================================================
  // CHAT BUBBLES
  // ============================================================================

  static const Color ashMessageDark = Color(0xFF1E293B);
  static const Color ashMessageLight = Color(0xFFF1F5F9);
  static const Color userMessage = Color(0xFF6366F1);

  // ============================================================================
  // BORDERS & DIVIDERS
  // ============================================================================

  static const Color border = Color(0xFF27272A);
  static const Color borderLight = Color(0xFFE2E8F0);

  // ============================================================================
  // TEXT COLORS
  // ============================================================================

  static const Color textPrimaryDark = Color(0xFFFAFAFA);
  static const Color textSecondaryDark = Color(0xFFA1A1AA);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);

  // ============================================================================
  // SEMANTIC COLORS (Mapped to unified palette)
  // ============================================================================

  // Workout Types - mapped to 6-color palette
  static const Color runEasy = emerald; // Easy effort → Emerald
  static const Color runLong = blue; // Long duration → Blue
  static const Color runTempo = amber; // Tempo/threshold → Amber
  static const Color runIntervals = rose; // High intensity → Rose
  static const Color strength = violet; // Strength → Violet
  static const Color mobility = cyan; // Mobility → Cyan
  static const Color rest = neutral; // Rest → Neutral
  static const Color race = amber; // Race → Amber (same as tempo)

  // Training Blocks - mapped to 6-color palette
  static const Color blockBase = emerald; // Base building → Emerald
  static const Color blockBuild = violet; // Build phase → Violet
  static const Color blockPeak = rose; // Peak intensity → Rose
  static const Color blockTaper = blue; // Taper/recovery → Blue
  static const Color blockRecovery = emerald; // Recovery → Emerald
  static const Color blockRace = amber; // Race week → Amber

  // Status colors - mapped to palette
  static const Color success = emerald;
  static const Color error = rose;
  static const Color warning = amber;

  // Stats & Metrics - mapped to palette
  static const Color statCompleted = emerald; // Completion stats
  static const Color statDuration = blue; // Time/duration stats
  static const Color statHrv = amber; // HRV (heart rate variability)
  static const Color statSleep = blue; // Sleep duration
  static const Color statRhr = rose; // Resting heart rate
  static const Color statReadiness = cyan; // Readiness score

  // ============================================================================
  // RETRO THEME ACCENTS
  // ============================================================================

  static const Color retroAccent =
      Color(0xFFFF4D8C); // Pink for dark mode selections

  // ============================================================================
  // BASIC COLORS
  // ============================================================================

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // ============================================================================
  // LEGACY ALIASES (for backwards compatibility)
  // ============================================================================

  static const Color backgroundDark = background;
  static const Color surfaceDark = surface;
  static const Color textPrimary = textPrimaryDark;
  static const Color textSecondary = textSecondaryDark;
  static const Color divider = border;
  static const Color accentBlue = primaryLight;
  static const Color ashMessage = ashMessageDark;
}
