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
    print(
        'GridOptimizer: Processing missed workout "${missed.name}" (${missed.type}, isKey: ${missed.isKey}) on ${_formatDate(missed.scheduledDate)}');

    // 1. Easy Run Rule: Delete (Mark as Skipped)
    if (_isEasyRun(missed)) {
      print('GridOptimizer: - Rule: Easy Run (Non-Key) -> Delete (Skip)');
      return _RescheduleResult([missed.copyWith(status: 'skipped')]);
    }

    // 2. Long Run Rule: Priority Priority
    if (_isLongRun(missed)) {
      print('GridOptimizer: - Rule: Long Run -> Priority Move');
      return _handleLongRunPriority(missed, grid);
    }

    // 3. Speed/Tempo Run Rule: Swap
    if (_isHardRun(missed)) {
      print('GridOptimizer: - Rule: Hard Run -> Swap');
      return _handleHardRunSwap(missed, grid);
    }

    // 4. Strength Session Rule: Consolidate
    if (_isStrength(missed)) {
      print('GridOptimizer: - Rule: Strength -> Consolidate');
      return _handleStrengthConsolidation(missed, grid);
    }

    print('GridOptimizer: - No matching rule found. Skipped.');
    return null;
  }

  _RescheduleResult? _handleLongRunPriority(
      Workout missed, List<Workout> grid) {
    // Look for the next available day in the block to move the Long Run.
    final nextAvailableDate =
        _findNextAvailableDate(missed.scheduledDate, grid);
    if (nextAvailableDate == null) {
      print(
          'GridOptimizer:   - No future dates available in block. Cannot reschedule.');
      return null;
    }
    print(
        'GridOptimizer:   - Found next date: ${_formatDate(nextAvailableDate)}');

    final updates = <Workout>[];

    // 1. Displace anything existing on that date
    final displaced = grid
        .where((w) => _isSameDay(w.scheduledDate, nextAvailableDate))
        .toList();
    for (final d in displaced) {
      if (!d.isKey) {
        print(
            'GridOptimizer:   - Displacing/Skipping existing non-key workout: "${d.name}"');
        updates.add(d.copyWith(status: 'skipped'));
      } else {
        // If it's another key workout, we have a conflict we can't solve algorithmically
        print(
            'GridOptimizer:   - Conflict: Target date has key workout "${d.name}". Cannot displace. Aborting move.');
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
      print(
          'GridOptimizer:   - 48h Recovery Rule: Skipping strength session "${s.name}" on ${_formatDate(s.scheduledDate)}');
      updates.add(s.copyWith(status: 'skipped'));
    }

    print(
        'GridOptimizer:   - Moving Long Run to ${_formatDate(nextAvailableDate)}');
    updates.add(missed.copyWith(
      scheduledDate: nextAvailableDate,
      status: 'planned', // Ensure it's active if it was previously skipped
    ));
    return _RescheduleResult(updates);
  }

  _RescheduleResult? _handleHardRunSwap(Workout missed, List<Workout> grid) {
    // Find potential STRENGTH days
    final potentialDays = grid
        .where((w) =>
            _isStrength(w) && w.scheduledDate.isAfter(missed.scheduledDate))
        .map((w) => w.scheduledDate)
        .toSet()
        .toList();

    potentialDays.sort();

    if (potentialDays.isEmpty) {
      print('GridOptimizer:   - No future strength days found.');
      return null;
    }

    for (final date in potentialDays) {
      // Verify no conflicts (No Key Runs on this day)
      final existingOnDay =
          grid.where((w) => _isSameDay(w.scheduledDate, date)).toList();

      final hasKeyRun = existingOnDay.any((w) => _isRun(w) && w.isKey);
      if (hasKeyRun) {
        print(
            'GridOptimizer:   - Skipping candidate date ${_formatDate(date)}: Has conflicting Key Run.');
        continue;
      }

      // Valid slot found!
      final updates = <Workout>[];

      // Handle existing workouts
      for (final existing in existingOnDay) {
        if (_isStrength(existing)) {
          updates.add(existing.copyWith(status: 'skipped'));
        } else if (_isRun(existing) && !existing.isKey) {
          print(
              'GridOptimizer:   - Also skipping existing non-key run "${existing.name}" to prevent 2 runs.');
          updates.add(existing.copyWith(status: 'skipped'));
        }
      }

      updates.add(missed.copyWith(
        scheduledDate: date,
        status: 'planned',
      ));

      print(
          'GridOptimizer:   - Swapping with Strength day: ${_formatDate(date)}');
      return _RescheduleResult(updates);
    }

    print(
        'GridOptimizer:   - No valid strength day found (all had conflicts).');
    return null;
  }

  _RescheduleResult? _handleStrengthConsolidation(
      Workout missed, List<Workout> grid) {
    // Move to next HARD RUN day (Consolidate).
    final nextHardRun = grid.firstWhere(
      (w) => _isHardRun(w) && w.scheduledDate.isAfter(missed.scheduledDate),
      orElse: () => missed, // dummy
    );

    if (nextHardRun.id == missed.id) {
      print(
          'GridOptimizer:   - No future Hard Run day found to consolidate with.');
      return null;
    }

    print(
        'GridOptimizer:   - Consolidating with Hard Run on ${_formatDate(nextHardRun.scheduledDate)} ("${nextHardRun.name}")');

    // Check separation rule (simplified to just same date, app manages timing)
    return _RescheduleResult([
      missed.copyWith(
        scheduledDate: nextHardRun.scheduledDate,
        status: 'planned',
      ),
    ]);
  }

  String _formatDate(DateTime d) {
    return '${d.month}/${d.day}';
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
  bool _isRun(Workout w) => _isEasyRun(w) || _isLongRun(w) || _isHardRun(w);
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
