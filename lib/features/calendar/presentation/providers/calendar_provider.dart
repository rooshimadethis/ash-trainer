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

/// Provider for the monthly/4-week overview
final monthlyWorkoutsProvider = StreamProvider<List<Workout>>((ref) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  // Last week + Current week + Next 2 weeks = 28 days
  final start = today.subtract(Duration(days: today.weekday - 1 + 7));
  final end = start.add(const Duration(days: 28));

  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return workoutRepository.watchWorkoutsForDateRange(
    startDate: start,
    endDate: end,
  );
});

/// Provider for fetching blocks for a specific date range
final blocksForRangeProvider =
    FutureProvider.family<List<TrainingBlock>, (DateTime, DateTime)>(
        (ref, range) async {
  final workoutRepository = ref.watch(workoutRepositoryProvider);
  return workoutRepository.getBlocksForDateRange(
    startDate: range.$1,
    endDate: range.$2,
  );
});

/// Provider for the weekly blocks based on selectedWeekProvider
final weeklyBlocksProvider = FutureProvider<List<TrainingBlock>>((ref) async {
  final startOfWeek = ref.watch(selectedWeekProvider);
  final endOfWeek = startOfWeek.add(const Duration(days: 7));

  return ref.watch(blocksForRangeProvider((startOfWeek, endOfWeek)).future);
});

/// Provider for the monthly/4-week overview blocks
final monthlyBlocksProvider = FutureProvider<List<TrainingBlock>>((ref) async {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  // Last week + Current week + Next 2 weeks = 28 days
  final start = today.subtract(Duration(days: today.weekday - 1 + 7));
  final end = start.add(const Duration(days: 28));

  return ref.watch(blocksForRangeProvider((start, end)).future);
});
