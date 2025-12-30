import 'package:uuid/uuid.dart';
import '../../features/shared/domain/entities/ai/training_plan_response.dart';
import '../../features/shared/domain/entities/training/phase.dart';
import '../../features/shared/domain/entities/training/training_block.dart';
import '../../features/shared/domain/entities/training/workout.dart';

class TrainingPlanScheduler {
  TrainingPlanHydrationResult hydratePlan({
    required TrainingPlan plan,
    required DateTime startDate,
    required String userId,
    required String goalId,
  }) {
    final hydratedPhases = <Phase>[];
    final hydratedBlocks = <TrainingBlock>[];
    final hydratedWorkouts = <Workout>[];

    // Maps to link Skeletons to Entities
    final phaseIdMap = <String, String>{}; // AID -> newUUID
    final blockIdMap = <String, String>{}; // AID -> newUUID

    DateTime currentPhaseStart = startDate;

    // Use sorted phases to ensure correct sequence
    final sortedPhases = List<PhaseSkeleton>.from(plan.phases)
      ..sort((a, b) => a.phaseNumber.compareTo(b.phaseNumber));

    for (var phaseSkeleton in sortedPhases) {
      final newPhaseId = const Uuid().v4();
      phaseIdMap[phaseSkeleton.id] = newPhaseId;

      final durationDays = phaseSkeleton.durationWeeks * 7;
      final phaseEndDate =
          currentPhaseStart.add(Duration(days: durationDays - 1));

      final phase = Phase(
        id: newPhaseId,
        goalId: goalId,
        phaseNumber: phaseSkeleton.phaseNumber,
        phaseType: phaseSkeleton.phaseType,
        durationWeeks: phaseSkeleton.durationWeeks,
        targetWeeklyVolume: phaseSkeleton.targetWeeklyVolume,
        targetWeeklyDuration: phaseSkeleton.targetWeeklyDuration,
        startDate: currentPhaseStart,
        endDate: phaseEndDate,
        description: phaseSkeleton.description,
      );
      hydratedPhases.add(phase);

      // Skeletons don't strictly contain blocks hierarchically in the List,
      // but blocks have phaseId. We need to filter using the AI's phase ID.
      final phaseBlocks =
          plan.blocks.where((b) => b.phaseId == phaseSkeleton.id).toList();
      phaseBlocks.sort((a, b) => a.blockNumber.compareTo(b.blockNumber));

      DateTime currentBlockStart = currentPhaseStart;

      for (var blockSkeleton in phaseBlocks) {
        final newBlockId = const Uuid().v4();
        blockIdMap[blockSkeleton.id] = newBlockId;

        // Use durationDays from skeleton
        final blockEndDate = currentBlockStart
            .add(Duration(days: blockSkeleton.durationDays - 1));

        final block = TrainingBlock(
          id: newBlockId,
          phaseId: newPhaseId,
          blockNumber: blockSkeleton.blockNumber,
          intent: blockSkeleton.intent,
          durationDays: blockSkeleton.durationDays,
          startDate: currentBlockStart,
          endDate: blockEndDate,
        );
        hydratedBlocks.add(block);

        // Workouts for this block
        final blockWorkouts =
            plan.workouts.where((w) => w.blockId == blockSkeleton.id).toList();
        // Sort by dayNumber to ensure we process them in order for debugging,
        // though date calculation is purely based on dayNumber.
        blockWorkouts.sort((a, b) => a.dayNumber.compareTo(b.dayNumber));

        for (var workoutSkeleton in blockWorkouts) {
          // dayNumber is relative to Block Start (1-based)
          final workoutDate = currentBlockStart
              .add(Duration(days: workoutSkeleton.dayNumber - 1));

          final workout = Workout(
            id: const Uuid().v4(),
            userId: userId,
            goalId: goalId,
            phaseId: newPhaseId,
            blockId: newBlockId,
            scheduledDate: workoutDate,
            type: workoutSkeleton.type,
            name: workoutSkeleton.name,
            plannedDuration: workoutSkeleton.plannedDuration,
            plannedDistance: workoutSkeleton.plannedDistance,
            intensity: workoutSkeleton.intensity,
            description: workoutSkeleton.description,
            status: 'planned',
          );
          hydratedWorkouts.add(workout);
        }

        currentBlockStart = blockEndDate.add(const Duration(days: 1));
      }

      currentPhaseStart = phaseEndDate.add(const Duration(days: 1));
    }

    return TrainingPlanHydrationResult(
      phases: hydratedPhases,
      blocks: hydratedBlocks,
      workouts: hydratedWorkouts,
    );
  }
}

class TrainingPlanHydrationResult {
  final List<Phase> phases;
  final List<TrainingBlock> blocks;
  final List<Workout> workouts;

  TrainingPlanHydrationResult({
    required this.phases,
    required this.blocks,
    required this.workouts,
  });
}
