import 'package:flutter/material.dart';

/// Centralized animation constants for consistent motion across the app.
class AppAnimations {
  // ============================================================================
  // DURATIONS
  // ============================================================================

  /// Very fast animations (100ms) - for immediate feedback
  static const Duration instant = Duration(milliseconds: 100);

  /// Fast animations (200ms) - for quick transitions
  static const Duration fast = Duration(milliseconds: 200);

  /// Normal animations (300ms) - standard UI transitions
  static const Duration normal = Duration(milliseconds: 300);

  /// Slow animations (400ms) - for emphasis
  static const Duration slow = Duration(milliseconds: 400);

  /// Very slow animations (600ms) - for dramatic effects
  static const Duration verySlow = Duration(milliseconds: 600);

  // ============================================================================
  // SPECIFIC USE CASES
  // ============================================================================

  /// Chat bubble pop-in animation
  static const Duration chatBubblePopIn = Duration(milliseconds: 400);

  /// Chat bubble text fade-in
  static const Duration chatBubbleTextFade = Duration(milliseconds: 300);

  /// Chat bubble growth animation
  static const Duration chatBubbleGrowth = Duration(milliseconds: 400);

  /// Typing indicator delay before showing text
  static const Duration typingDelay = Duration(seconds: 1);

  /// Typing indicator animation cycle
  static const Duration typingCycle = Duration(milliseconds: 1400);

  /// Card press animation
  static const Duration cardPress = Duration(milliseconds: 100);

  /// Selection state change
  static const Duration selection = Duration(milliseconds: 200);

  /// Option slider transition
  static const Duration optionSlider = Duration(milliseconds: 250);

  // ============================================================================
  // CURVES
  // ============================================================================

  /// Smooth ease out with slight overshoot - great for pop-ins
  static const Curve easeOutBack = Curves.easeOutBack;

  /// Smooth deceleration - great for size changes
  static const Curve easeOutQuart = Curves.easeOutQuart;

  /// Smooth acceleration and deceleration
  static const Curve easeInOut = Curves.easeInOut;

  /// Smooth deceleration
  static const Curve easeOut = Curves.easeOut;

  /// Smooth acceleration
  static const Curve easeIn = Curves.easeIn;

  /// Cubic bezier for smooth transitions
  static const Curve easeOutCubic = Curves.easeOutCubic;

  /// Linear motion - use sparingly
  static const Curve linear = Curves.linear;
}
