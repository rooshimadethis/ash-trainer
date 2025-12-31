import '../../../shared/domain/repositories/workout_repository.dart';
import '../../../../core/utils/grid_optimizer.dart';
import '../../../shared/domain/entities/training/workout.dart';

class ApplyRescheduleMatrix {
  final WorkoutRepository _workoutRepo;
  final GridOptimizer _optimizer;

  ApplyRescheduleMatrix(this._workoutRepo, this._optimizer);

  Future<void> execute({required String goalId}) async {
    // 1. Get all workouts for the goal
    final allWorkouts = await _workoutRepo.getWorkoutsForGoal(goalId);

    // 2. Identify missed workouts (Status: planned, Date: in the past)
    final now = DateTime.now();
    final missed = allWorkouts.where((w) {
      final isPlannedMissed =
          w.status == 'planned' && _isDateBeforeToday(w.scheduledDate, now);
      final isSkippedKey = w.status == 'skipped' &&
          w.isKey &&
          w.scheduledDate.isAfter(now.subtract(const Duration(days: 3)));
      return isPlannedMissed || isSkippedKey;
    }).toList();

    if (missed.isEmpty) {
      print('ApplyRescheduleMatrix: No missed or skipped key workouts found.');
      return;
    }

    print('ApplyRescheduleMatrix: Found ${missed.length} workouts to process:');
    for (final m in missed) {
      print(' - ${m.name} (${m.status}, ${_formatDate(m.scheduledDate)})');
    }

    // 3. For each missed workout, identify its block and relevant buddies
    // We group by block to optimize
    final blockIds = missed.map((w) => w.blockId).whereType<String>().toSet();

    final List<Workout> allUpdates = [];

    for (final blockId in blockIds) {
      final blockMissed = missed.where((w) => w.blockId == blockId).toList();
      final blockRemaining = allWorkouts
          .where((w) =>
              w.blockId == blockId &&
              !_isDateBeforeToday(w.scheduledDate, now) &&
              w.status == 'planned')
          .toList();

      // 4. Run Optimizer
      final updates = _optimizer.rescheduleMissed(
        missedWorkouts: blockMissed,
        remainingWorkoutsInBlock: blockRemaining,
      );

      allUpdates.addAll(updates);
    }

    // 5. Save updates
    if (allUpdates.isNotEmpty) {
      print('ApplyRescheduleMatrix: Saving ${allUpdates.length} updates:');
      for (final u in allUpdates) {
        print(' - ${u.name} -> ${u.status} on ${_formatDate(u.scheduledDate)}');
      }
      await _workoutRepo.batchUpdateWorkouts(allUpdates);
    } else {
      print('ApplyRescheduleMatrix: No updates generated.');
    }
  }

  bool _isDateBeforeToday(DateTime date, DateTime now) {
    // Check if the date is strictly before "today" (midnight)
    final today = DateTime(now.year, now.month, now.day);
    return date.isBefore(today);
  }

  String _formatDate(DateTime d) {
    return '${d.month}/${d.day}';
  }
}
