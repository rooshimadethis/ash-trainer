import '../../features/shared/domain/entities/training/workout.dart';

/// Pure logic class to handle algorithmic rescheduling of missed workouts.
/// Adheres to the "Fixed Grid" philosophy and the "Reschedule Decision Matrix".
class GridOptimizer {
  /// The "6-Hour Rule": Combined sessions must be separated by at least 6 hours.
  static const int minHoursBetweenCombinedSessions = 6;

  /// The "48-Hour Recovery Rule": No leg-heavy strength within 48h of Long Run.
  static const int recoveryWindowHoursForLongRun = 48;

  /// Reschedules missed workouts within a block.
  /// Returns a list of updated workouts to be saved.
  List<Workout> rescheduleMissed({
    required List<Workout> missedWorkouts,
    required List<Workout> remainingWorkoutsInBlock,
  }) {
    final List<Workout> updates = [];
    final List<Workout> availableGrid = List.from(remainingWorkoutsInBlock);

    for (final missed in missedWorkouts) {
      final result = _rescheduleSingle(missed, availableGrid);
      if (result != null) {
        updates.addAll(result.updates);
        // Update the available grid for subsequent missed workouts
        for (final update in result.updates) {
          final index = availableGrid.indexWhere((w) => w.id == update.id);
          if (index != -1) {
            availableGrid[index] = update;
          } else {
            // New workout being shifted into a slot
            availableGrid.add(update);
          }
        }
      } else {
        // Default to skipped if no rule applies or no slot found
        updates.add(missed.copyWith(status: 'skipped'));
      }
    }

    return updates;
  }

  _RescheduleResult? _rescheduleSingle(Workout missed, List<Workout> grid) {
    // 1. Easy Run Rule: Delete (Mark as Skipped)
    if (_isEasyRun(missed)) {
      return _RescheduleResult([missed.copyWith(status: 'skipped')]);
    }

    // 2. Long Run Rule: Priority Priority
    if (_isLongRun(missed)) {
      return _handleLongRunPriority(missed, grid);
    }

    // 3. Speed/Tempo Run Rule: Swap
    if (_isHardRun(missed)) {
      return _handleHardRunSwap(missed, grid);
    }

    // 4. Strength Session Rule: Consolidate
    if (_isStrength(missed)) {
      return _handleStrengthConsolidation(missed, grid);
    }

    return null;
  }

  _RescheduleResult? _handleLongRunPriority(
      Workout missed, List<Workout> grid) {
    // Look for the next available day in the block to move the Long Run.
    final nextAvailableDate =
        _findNextAvailableDate(missed.scheduledDate, grid);
    if (nextAvailableDate == null) return null;

    final updates = <Workout>[];

    // 1. Displace anything existing on that date
    final displaced = grid
        .where((w) => _isSameDay(w.scheduledDate, nextAvailableDate))
        .toList();
    for (final d in displaced) {
      if (!d.isKey) {
        updates.add(d.copyWith(status: 'skipped'));
      } else {
        // If it's another key workout, we have a conflict we can't solve algorithmically
        return null;
      }
    }

    // 2. Enforce 48-Hour Rule: Skip any Strength sessions within 48h window of the new date
    final windowStart = nextAvailableDate
        .subtract(const Duration(hours: recoveryWindowHoursForLongRun));
    final windowEnd = nextAvailableDate
        .add(const Duration(hours: recoveryWindowHoursForLongRun));

    final strengthInWindow = grid
        .where((w) =>
                _isStrength(w) &&
                w.scheduledDate.isAfter(windowStart) &&
                w.scheduledDate.isBefore(windowEnd) &&
                !_isSameDay(w.scheduledDate,
                    nextAvailableDate) // Don't skip if it was already displaced/handled
            )
        .toList();

    for (final s in strengthInWindow) {
      updates.add(s.copyWith(status: 'skipped'));
    }

    updates.add(missed.copyWith(
      scheduledDate: nextAvailableDate,
      status: 'planned', // Ensure it's active if it was previously skipped
    ));
    return _RescheduleResult(updates);
  }

  _RescheduleResult? _handleHardRunSwap(Workout missed, List<Workout> grid) {
    // Move hard run to next scheduled STRENGTH day.
    // Downgrade that strength to mobility/skipped.
    final nextStrengthDay = grid.firstWhere(
      (w) => _isStrength(w) && w.scheduledDate.isAfter(missed.scheduledDate),
      orElse: () => missed, // dummy
    );

    if (nextStrengthDay.id == missed.id) return null;

    return _RescheduleResult([
      missed.copyWith(
        scheduledDate: nextStrengthDay.scheduledDate,
        status: 'planned',
      ),
      nextStrengthDay.copyWith(status: 'skipped'), // Or change type to mobility
    ]);
  }

  _RescheduleResult? _handleStrengthConsolidation(
      Workout missed, List<Workout> grid) {
    // Move to next HARD RUN day (Consolidate).
    final nextHardRun = grid.firstWhere(
      (w) => _isHardRun(w) && w.scheduledDate.isAfter(missed.scheduledDate),
      orElse: () => missed, // dummy
    );

    if (nextHardRun.id == missed.id) return null;

    // Check separation rule (simplified to just same date, app manages timing)
    return _RescheduleResult([
      missed.copyWith(
        scheduledDate: nextHardRun.scheduledDate,
        status: 'planned',
      ),
    ]);
  }

  // Helpers

  bool _isEasyRun(Workout w) => w.type.contains('easy') && !w.isKey;
  bool _isLongRun(Workout w) =>
      w.type.contains('long') ||
      (w.isKey && w.name.toLowerCase().contains('long'));
  bool _isHardRun(Workout w) =>
      (w.type.contains('tempo') ||
          w.type.contains('interval') ||
          w.type.contains('hill')) ||
      (w.isKey && !_isLongRun(w));
  bool _isStrength(Workout w) => w.type.contains('strength');

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  DateTime? _findNextAvailableDate(DateTime from, List<Workout> grid) {
    // Sort remaining days
    final dates = grid
        .map((w) => w.scheduledDate)
        .where((d) => d.isAfter(from))
        .toSet()
        .toList();
    dates.sort();
    return dates.isNotEmpty ? dates.first : null;
  }
}

class _RescheduleResult {
  final List<Workout> updates;
  _RescheduleResult(this.updates);
}
