import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/entities/training/training_block.dart';
import '../../../../data/providers/repository_providers.dart';

/// Provider for the selected week in the Weekly View
final selectedWeekProvider = StateProvider<DateTime>((ref) {
  // Default to the start of the current week (Monday)
  final now = DateTime.now();
  return now.subtract(Duration(days: now.weekday - 1));
});

/// Provider for fetching workouts for a specific date range (Reactive)
final workoutsForRangeProvider =
    StreamProvider.family<List<Workout>, (DateTime, DateTime)>((ref, range) {
  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return workoutRepository.watchWorkoutsForDateRange(
    startDate: range.$1,
    endDate: range.$2,
  );
});

/// Provider for today's workout
final todayWorkoutProvider = StreamProvider<Workout?>((ref) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(const Duration(days: 1));

  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return workoutRepository
      .watchWorkoutsForDateRange(startDate: today, endDate: tomorrow)
      .map((workouts) => workouts.isNotEmpty ? workouts.first : null);
});

/// Provider for today's training block
final todayBlockProvider = StreamProvider<TrainingBlock?>((ref) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(const Duration(days: 1));

  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return workoutRepository
      .watchBlocksForDateRange(startDate: today, endDate: tomorrow)
      .map((blocks) => blocks.isNotEmpty ? blocks.first : null);
});

/// Provider for a single workout by ID
final workoutDetailProvider =
    StreamProvider.family<Workout?, String>((ref, id) {
  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return workoutRepository.watchWorkout(id);
});

/// Provider for the selected date
final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

/// Provider for the weekly workouts based on selectedWeekProvider
final weeklyWorkoutsProvider = StreamProvider<List<Workout>>((ref) {
  final startOfWeek = ref.watch(selectedWeekProvider);
  final endOfWeek = startOfWeek.add(const Duration(days: 7));

  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return workoutRepository.watchWorkoutsForDateRange(
    startDate: startOfWeek,
    endDate: endOfWeek,
  );
});

/// Provider for the month being viewed in Monthly View
final monthlyMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 1);
});

/// Provider for the monthly grid overview
final monthlyWorkoutsProvider = StreamProvider<List<Workout>>((ref) {
  final focusedMonth = ref.watch(monthlyMonthProvider);

  // Calculate start of range: Monday of the week containing the first of the month
  final start = focusedMonth.subtract(Duration(days: focusedMonth.weekday - 1));
  // Standard calendars can span up to 6 weeks
  final end = start.add(const Duration(days: 42));

  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return workoutRepository.watchWorkoutsForDateRange(
    startDate: start,
    endDate: end,
  );
});

/// Provider for fetching blocks for a specific date range
final blocksForRangeProvider =
    StreamProvider.family<List<TrainingBlock>, (DateTime, DateTime)>(
        (ref, range) {
  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return workoutRepository.watchBlocksForDateRange(
    startDate: range.$1,
    endDate: range.$2,
  );
});

final weeklyBlocksProvider = StreamProvider<List<TrainingBlock>>((ref) {
  final startOfWeek = ref.watch(selectedWeekProvider);
  final endOfWeek = startOfWeek.add(const Duration(days: 7));

  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return workoutRepository.watchBlocksForDateRange(
    startDate: startOfWeek,
    endDate: endOfWeek,
  );
});

final monthlyBlocksProvider = StreamProvider<List<TrainingBlock>>((ref) {
  final focusedMonth = ref.watch(monthlyMonthProvider);
  final start = focusedMonth.subtract(Duration(days: focusedMonth.weekday - 1));
  final end = start.add(const Duration(days: 42));

  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return workoutRepository.watchBlocksForDateRange(
    startDate: start,
    endDate: end,
  );
});
