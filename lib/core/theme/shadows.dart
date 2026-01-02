import 'package:flutter/material.dart';
import 'colors.dart';

class AppShadows {
  /// soft-sm: 0 2px 4px rgba(0,0,0,0.06)
  static List<BoxShadow> get softSm => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          offset: const Offset(0, 2),
          blurRadius: 4,
        ),
      ];

  /// soft-md: 0 4px 8px rgba(0,0,0,0.08)
  static List<BoxShadow> get softMd => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          offset: const Offset(0, 4),
          blurRadius: 8,
        ),
      ];

  /// soft-lg: 0 8px 16px rgba(0,0,0,0.1)
  static List<BoxShadow> get softLg => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          offset: const Offset(0, 8),
          blurRadius: 16,
        ),
      ];

  /// soft-xl: 0 12px 24px rgba(0,0,0,0.12)
  static List<BoxShadow> get softXl => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          offset: const Offset(0, 12),
          blurRadius: 24,
        ),
      ];

  /// retro: softer offset shadow
  static List<BoxShadow> get retro => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          offset: const Offset(4, 4),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ];

  /// retro-hover: subtle pressed state
  static List<BoxShadow> get retroHover => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          offset: const Offset(2, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ];

  /// retro-dark: softer dark mode shadow using retroAccent
  static List<BoxShadow> get retroDark => [
        BoxShadow(
          color: AppColors.retroAccent.withValues(alpha: 0.25),
          offset: const Offset(4, 4),
          blurRadius: 10,
          spreadRadius: 0,
        ),
      ];

  /// Approximation of soft-inset (0 2px 4px rgba(0,0,0,0.06) as an outer shadow)
  /// Since Flutter's BoxDecoration doesn't natively support 'inset',
  /// we use this as a very tight, subtle outer shadow.
  static List<BoxShadow> get softInsetApprox => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          offset: const Offset(0, 2),
          blurRadius: 4,
          spreadRadius: -1,
        ),
      ];
}
