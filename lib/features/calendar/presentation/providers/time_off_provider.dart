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
      // 1. Delete conflicts if requested
      if (deleteConflicts) {
        final workoutRepo = ref.read(workoutRepositoryProvider);
        final conflicts = await workoutRepo.getWorkoutsForDateRange(
            startDate: start, endDate: end);
        for (var workout in conflicts) {
          await workoutRepo.deleteWorkout(workout.id);
        }
      }

      // 2. Add Time Off
      await ref.read(timeOffRepositoryProvider).addTimeOff(start, end, reason);

      // 3. Trigger Re-plan if duration > 2 days
      final duration = end.difference(start).inDays + 1;
      if (duration > 2) {
        try {
          final goalRepo = ref.read(goalRepositoryProvider);
          final userRepo = ref.read(userRepositoryProvider);
          final activeGoal = await goalRepo.getActiveGoal();
          final currentUser = await userRepo.getCurrentUser();

          if (activeGoal != null && currentUser != null) {
            AppLogger.i(
                'Time off > 2 days ($duration days). Triggering AI Adjustment...');
            final generatePlan = ref.read(generateTrainingPlanProvider);
            await generatePlan.execute(
              goalId: activeGoal.id,
              userId: currentUser.id,
              mode: PlanningMode.adjust,
            );
            AppLogger.i('AI Adjustment complete.');
          }
        } catch (e, st) {
          AppLogger.e('Failed to trigger AI adjustment for time off',
              error: e, stackTrace: st);
          // Non-fatal, continued to refresh list
        }
      }

      // 4. Refresh list
      return ref.read(timeOffRepositoryProvider).getAllTimeOffs();
    });
  }

  Future<void> deleteTimeOff(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(timeOffRepositoryProvider).deleteTimeOff(id);
      return ref.read(timeOffRepositoryProvider).getAllTimeOffs();
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
        // We delete and re-add because we don't have update yet, simpler
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
        // First segment
        await repo.addTimeOff(entry.startDate,
            dayToRemove.subtract(const Duration(days: 1)), entry.reason ?? '');
        // Second segment
        await repo.addTimeOff(dayToRemove.add(const Duration(days: 1)),
            entry.endDate, entry.reason ?? '');
      }

      return repo.getAllTimeOffs();
    });
  }
}
