import 'package:flutter/material.dart';

/// Centralized dimension constants for consistent spacing and sizing across the app.
class AppDimensions {
  // ============================================================================
  // AVATAR SIZES
  // ============================================================================

  static const double avatarXs = 24.0;
  static const double avatarSm = 32.0;
  static const double avatarMd = 44.0;
  static const double avatarLg = 64.0;
  static const double avatarXl = 80.0;

  // ============================================================================
  // CHAT BUBBLE
  // ============================================================================

  static const double chatBubbleRadius = 20.0;
  static const double chatBubbleSmallRadius = 4.0;
  static const EdgeInsets chatBubblePadding = EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 10,
  );

  // ============================================================================
  // SPACING
  // ============================================================================

  static const double spacingXxs = 2.0;
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // ============================================================================
  // ICON SIZES
  // ============================================================================

  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  // ============================================================================
  // WORKOUT PIPS
  // ============================================================================

  static const double workoutPipExpanded = 18.0;
  static const double workoutPipCompact = 8.0;
  static const double workoutPipCheckIcon = 10.0;

  // ============================================================================
  // CARD HEIGHTS
  // ============================================================================

  static const double cardMinHeight = 100.0;
  static const double cardMediumHeight = 150.0;
  static const double cardLargeHeight = 200.0;

  // ============================================================================
  // BUTTON SIZES
  // ============================================================================

  static const double buttonHeightSm = 36.0;
  static const double buttonHeightMd = 44.0;
  static const double buttonHeightLg = 52.0;

  static const EdgeInsets buttonPaddingSm = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  );
  static const EdgeInsets buttonPaddingMd = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );
  static const EdgeInsets buttonPaddingLg = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 16,
  );

  // ============================================================================
  // TYPING INDICATOR
  // ============================================================================

  static const double typingIndicatorWidth = 40.0;
  static const double typingIndicatorHeight = 20.0;
  static const double typingDotSize = 6.0;
  static const double typingDotSpacing = 4.0;
  static const double typingDotBounce = 4.0;
}
