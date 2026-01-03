import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/repositories/time_off_repository_impl.dart';
import '../../../../data/providers/repository_providers.dart';
import '../../../../infrastructure/providers/service_providers.dart';
import 'package:ash_trainer/features/shared/presentation/providers/ash_status_provider.dart';

import '../../../shared/domain/entities/time_off_entry.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/repositories/time_off_repository.dart';
import '../../../shared/domain/entities/ai/context_models.dart'; // For PlanningMode
import '../../../../core/utils/logger.dart';
import 'package:ash_trainer/core/tasks/background_tasks.dart';
import 'package:drift/drift.dart';
import 'package:ash_trainer/data/datasources/local/drift_database.dart';
import 'package:ash_trainer/data/providers/task_providers.dart';
import 'package:ash_trainer/features/calendar/presentation/providers/calendar_provider.dart';
import 'package:ash_trainer/features/developer/presentation/providers/debug_providers.dart';

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

      if (isLongBreak) {
        ref.read(uiThinkingProvider.notifier).state = true;
      }

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
        final activeGoal =
            await ref.read(goalRepositoryProvider).getActiveGoal();
        if (activeGoal != null) {
          final taskId = "plan_gen_${activeGoal.id}";
          await _triggerAIAdjustment(duration: duration);

          // Polling loop to wait for background task completion in foreground
          // This ensures the UI stays in 'thinking' mode and refreshes once done
          bool isDone = false;
          int attempts = 0;
          final dao = ref.read(aiTaskDaoProvider);

          while (!isDone && attempts < 60) {
            await Future.delayed(const Duration(seconds: 2));
            try {
              final task = await dao.getTask(taskId);
              if (task == null) {
                isDone = true;
              }
            } catch (e) {
              AppLogger.w(
                  'Polling task status failed (could be transient lock): $e');
            }
            attempts++;
          }

          // After AI task completes, invalidate the workouts providers to fetch fresh data
          // from the disk (since background isolate's Drift doesn't trigger foreground streams)
          ref.invalidate(monthlyWorkoutsProvider);
          ref.invalidate(weeklyWorkoutsProvider);
          ref.invalidate(todayWorkoutProvider);
          ref.invalidate(monthlyBlocksProvider);
          ref.invalidate(weeklyBlocksProvider);
          ref.invalidate(todayBlockProvider);
          ref.invalidate(selectedWeekProvider); // Force re-calc
        }

        ref.read(uiThinkingProvider.notifier).state = false;
      }

      // 4. Refresh list
      final all = await ref.read(timeOffRepositoryProvider).getAllTimeOffs();
      return all;
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
        ref.read(uiThinkingProvider.notifier).state = true;
        await _triggerAIAdjustment(duration: duration);
        ref.read(uiThinkingProvider.notifier).state = false;
      }

      return repo.getAllTimeOffs();
    });
  }

  Future<void> _triggerAIAdjustment({
    required int duration,
  }) async {
    try {
      final goalRepo = ref.read(goalRepositoryProvider);
      final userRepo = ref.read(userRepositoryProvider);
      final activeGoal = await goalRepo.getActiveGoal();
      final currentUser = await userRepo.getCurrentUser();

      if (activeGoal != null && currentUser != null) {
        AppLogger.i(
            'Time off changed ($duration days). Triggering AI Adjustment...');

        final taskId = "plan_gen_${activeGoal.id}";

        // 1. Manually insert 'running' task from foreground isolate
        // This ensures the shimmer appears IMMEDIATELY before Workmanager even starts
        final dao = ref.read(aiTaskDaoProvider);
        await dao.upsertTask(AiTasksCompanion(
          id: Value(taskId),
          taskType: Value(BackgroundTasks.planGenerationTask),
          status: Value('running'),
          targetId: Value(activeGoal.id),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ));

        // 2. Schedule the background job for reliability
        await BackgroundTasks.schedulePlanGeneration(
          goalId: activeGoal.id,
          userId: currentUser.id,
          mode: PlanningMode.adjust,
          useMockAi: ref.read(debugUseMockAiProvider),
          alternateMockPlan: ref.read(debugAlternateMockPlanProvider),
        );
      }
    } catch (e, st) {
      AppLogger.e('Failed to trigger AI adjustment for time off changes',
          error: e, stackTrace: st);
    }
  }
}
