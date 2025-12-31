import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_theme.dart';
import 'colors.dart';
import '../constants/workout_types.dart';
import '../../features/calendar/presentation/providers/calendar_provider.dart';

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

/// Provider for the dynamic application theme.
final appThemeProvider = Provider<ThemeData>((ref) {
  final accentColor = ref.watch(appAccentColorProvider);
  return AppTheme.darkTheme(primaryColor: accentColor);
});
