import 'package:flutter/material.dart';
import 'colors.dart';

/// Centralized border constants and helpers for consistent styling across the app.
class AppBorders {
  // --- Border Widths ---
  static const double thin = 1.5;
  static const double medium = 2.0;
  static const double selected = 2.5;

  // --- Border Radii ---
  static const double radiusSm = 8.0;
  static const double radiusMd = 16.0;
  static const double radiusLg = 24.0;
  static const double radiusXl = 32.0;
  static const double radiusFull = 100.0;

  /// Returns the appropriate selection border color based on theme and selection state.
  static Color selectionColor(BuildContext context,
      {required bool isSelected, bool isToday = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isSelected) {
      return isDark ? AppColors.retroAccent : Colors.black;
    }

    if (isToday) {
      return Theme.of(context).primaryColor;
    }

    return isDark
        ? Colors.white.withValues(alpha: 0.1)
        : Colors.black.withValues(alpha: 0.1);
  }

  /// Returns the border width based on selection state.
  static double selectionWidth({required bool isSelected}) {
    return isSelected ? selected : thin;
  }

  /// Creates a complete Border for calendar day cells.
  static Border dayCell(BuildContext context,
      {required bool isSelected, bool isToday = false}) {
    return Border.all(
      color: selectionColor(context, isSelected: isSelected, isToday: isToday),
      width: selectionWidth(isSelected: isSelected),
    );
  }

  /// Creates a Border for card components.
  static Border card(BuildContext context, {Color? color, double? width}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Border.all(
      color: color ??
          (isDark
              ? AppColors.retroAccent.withValues(alpha: 0.5)
              : Colors.black.withValues(alpha: 0.8)),
      width: width ?? thin,
    );
  }

  /// Creates a subtle Border for surface cards.
  static Border surface(BuildContext context, {double? width}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Border.all(
      color: isDark
          ? AppColors.retroAccent.withValues(alpha: 0.5)
          : Colors.black.withValues(alpha: 0.1),
      width: width ?? thin,
    );
  }
}
