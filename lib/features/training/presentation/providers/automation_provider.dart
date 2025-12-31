import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ash_trainer/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:ash_trainer/features/shared/domain/entities/goal.dart';
import 'use_case_providers.dart';

/// Provider to handle automatic training plan maintenance.
final trainingAutomationProvider = Provider<TrainingAutomation>((ref) {
  return TrainingAutomation(ref);
});

class TrainingAutomation {
  final Ref _ref;

  TrainingAutomation(this._ref);

  /// Checks for and applies algorithmic rescheduling for the active goal.
  Future<void> checkAndReschedule() async {
    final Goal? activeGoal = await _ref.read(activeGoalProvider.future);
    if (activeGoal == null) return;

    await _ref
        .read(applyRescheduleMatrixProvider)
        .execute(goalId: activeGoal.id);
  }

  /// Triggered after a workout is completed.
  /// Handles both rescheduling and the "Fill More" logic.
  Future<void> onWorkoutAction() async {
    await checkAndReschedule();
    // TODO: Add FillMoreTrainingBlocks logic here in later phase
  }
}
