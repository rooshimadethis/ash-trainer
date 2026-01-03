import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/time_off_repository_impl.dart';
import '../../../../infrastructure/providers/service_providers.dart';
import '../../../../data/providers/repository_providers.dart';
import '../../../shared/domain/entities/time_off_entry.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/repositories/time_off_repository.dart';
import '../../../training/presentation/providers/use_case_providers.dart';
import '../../../shared/domain/entities/ai/context_models.dart'; // For PlanningMode
import '../../../../core/utils/logger.dart';

part 'time_off_provider.g.dart';

@riverpod
TimeOffRepository timeOffRepository(Ref ref) {
  final db = ref.watch(driftDatabaseProvider);
  return TimeOffRepositoryImpl(db.timeOffDao);
}

@riverpod
class TimeOffController extends _$TimeOffController {
  @override
  FutureOr<List<TimeOffEntry>> build() {
    return ref.watch(timeOffRepositoryProvider).getAllTimeOffs();
  }

  Future<List<Workout>> checkConflicts(DateTime start, DateTime end) async {
    final workoutRepo = ref.read(workoutRepositoryProvider);
    return workoutRepo.getWorkoutsForDateRange(startDate: start, endDate: end);
  }

  Future<void> addTimeOff(DateTime start, DateTime end, String reason,
      {bool deleteConflicts = true}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final duration = end.difference(start).inDays + 1;
      final isLongBreak = duration > 2;

      // 1. Delete conflicts only for short breaks without AI adjustment.
      // For long breaks, we WANT the AI to see the workouts we are displacing
      // so it can intelligently reschedule them. The AI 'adjust' mode will
      // clear the future plan once it has finished generating the new one.
      if (deleteConflicts && !isLongBreak) {
        final workoutRepo = ref.read(workoutRepositoryProvider);
        final conflicts = await workoutRepo.getWorkoutsForDateRange(
            startDate: start, endDate: end);
        for (var workout in conflicts) {
          await workoutRepo.deleteWorkout(workout.id);
        }
      }

      // 2. Add Time Off entry - AI will see this as part of the context
      await ref.read(timeOffRepositoryProvider).addTimeOff(start, end, reason);

      // 3. Trigger Re-plan if duration > 2 days
      if (isLongBreak) {
        await _triggerAIAdjustment(
          duration: duration,
          fallbackStart: deleteConflicts ? start : null,
          fallbackEnd: deleteConflicts ? end : null,
        );
      }

      // 4. Refresh list
      return ref.read(timeOffRepositoryProvider).getAllTimeOffs();
    });
  }

  Future<void> deleteTimeOff(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(timeOffRepositoryProvider);
      final allTimeOffs = await repo.getAllTimeOffs();
      final entry = allTimeOffs.firstWhere((e) => e.id == id);

      final duration = entry.endDate.difference(entry.startDate).inDays + 1;

      await repo.deleteTimeOff(id);

      // Trigger re-plan if we are removing a significant break
      if (duration > 2) {
        await _triggerAIAdjustment(duration: duration);
      }

      return repo.getAllTimeOffs();
    });
  }

  Future<void> removeDayFromTimeOff(
      TimeOffEntry entry, DateTime dayToRemove) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(timeOffRepositoryProvider);
      final isStart = DateUtils.isSameDay(entry.startDate, dayToRemove);
      final isEnd = DateUtils.isSameDay(entry.endDate, dayToRemove);

      // Case 1: Single day entry - just delete
      if (isStart && isEnd) {
        await repo.deleteTimeOff(entry.id);
      }
      // Case 2: Remove start day - update start date
      else if (isStart) {
        await repo.deleteTimeOff(entry.id);
        await repo.addTimeOff(entry.startDate.add(const Duration(days: 1)),
            entry.endDate, entry.reason ?? '');
      }
      // Case 3: Remove end day - update end date
      else if (isEnd) {
        await repo.deleteTimeOff(entry.id);
        await repo.addTimeOff(
            entry.startDate,
            entry.endDate.subtract(const Duration(days: 1)),
            entry.reason ?? '');
      }
      // Case 4: Middle day - split into two
      else {
        await repo.deleteTimeOff(entry.id);
        await repo.addTimeOff(entry.startDate,
            dayToRemove.subtract(const Duration(days: 1)), entry.reason ?? '');
        await repo.addTimeOff(dayToRemove.add(const Duration(days: 1)),
            entry.endDate, entry.reason ?? '');
      }

      // If the original entry was a long break, shifting it might require a re-plan
      final duration = entry.endDate.difference(entry.startDate).inDays + 1;
      if (duration > 2) {
        await _triggerAIAdjustment(duration: duration);
      }

      return repo.getAllTimeOffs();
    });
  }

  Future<void> _triggerAIAdjustment({
    required int duration,
    DateTime? fallbackStart,
    DateTime? fallbackEnd,
  }) async {
    try {
      final goalRepo = ref.read(goalRepositoryProvider);
      final userRepo = ref.read(userRepositoryProvider);
      final activeGoal = await goalRepo.getActiveGoal();
      final currentUser = await userRepo.getCurrentUser();

      if (activeGoal != null && currentUser != null) {
        AppLogger.i(
            'Time off changed ($duration days). Triggering AI Adjustment...');
        final generatePlan = ref.read(generateTrainingPlanProvider);
        await generatePlan.execute(
          goalId: activeGoal.id,
          userId: currentUser.id,
          mode: PlanningMode.adjust,
        );
        AppLogger.i('AI Adjustment complete.');
      }
    } catch (e, st) {
      AppLogger.e('Failed to trigger AI adjustment for time off changes',
          error: e, stackTrace: st);

      // Fallback: If AI fails and we have a range to clear, do it manually
      if (fallbackStart != null && fallbackEnd != null) {
        final workoutRepo = ref.read(workoutRepositoryProvider);
        final conflicts = await workoutRepo.getWorkoutsForDateRange(
            startDate: fallbackStart, endDate: fallbackEnd);
        for (var workout in conflicts) {
          await workoutRepo.deleteWorkout(workout.id);
        }
      }
    }
  }
}
