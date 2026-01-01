import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_theme.dart';
import 'colors.dart';
import '../constants/workout_types.dart';
import '../../features/calendar/presentation/providers/calendar_provider.dart';
import '../../features/shared/domain/entities/training/workout.dart';

/// Provider that calculates the current accent color based on today's first workout.
final appAccentColorProvider = Provider<Color>((ref) {
  final todayWorkoutAsync = ref.watch(todayWorkoutProvider);

  return todayWorkoutAsync.maybeWhen(
    data: (workout) {
      if (workout != null) {
        return WorkoutTypes.getColor(workout.type);
      }
      return AppColors.primary;
    },
    orElse: () => AppColors.primary,
  );
});

/// Provider for the application theme mode (defaults to light for the new "friendly" vibe).
final isDarkModeProvider = StateProvider<bool>((ref) => false);

/// Provider for the dynamic application theme.
final appThemeProvider = Provider<ThemeData>((ref) {
  final accentColor = ref.watch(appAccentColorProvider);
  final isDark = ref.watch(isDarkModeProvider);

  return isDark
      ? AppTheme.darkTheme(primaryColor: accentColor)
      : AppTheme.lightTheme(primaryColor: accentColor);
});

/// Provider factory that creates a theme for a specific workout.
final workoutThemeProvider =
    Provider.family<ThemeData, Workout>((ref, workout) {
  final workoutColor = WorkoutTypes.getColor(workout.type);
  final isDark = ref.watch(isDarkModeProvider);

  return isDark
      ? AppTheme.darkTheme(primaryColor: workoutColor)
      : AppTheme.lightTheme(primaryColor: workoutColor);
});
