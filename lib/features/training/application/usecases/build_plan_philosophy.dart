import '../../../shared/domain/entities/ai/context_models.dart';
import '../../../shared/domain/entities/goal.dart';

PlanGenerationPhilosophy buildPlanPhilosophy({
  required Goal goal,
  required double weeklyVolume,
}) {
  final intensityStrategy = _selectIntensityStrategy(goal.type, weeklyVolume);
  final taperGuidance = goal.type == GoalType.event
      ? _buildTaperGuidance(goal.targetDistance)
      : null;

  return PlanGenerationPhilosophy(
    // Running guidance
    intensityStrategy: intensityStrategy,
    intensityBreakdown: _getIntensityBreakdown(intensityStrategy),
    maxWeeklyVolumeIncrease: 0.10,
    minWeeksBetweenRecovery: 3,
    maxWeeksBetweenRecovery: 5,
    recoveryVolumeReduction: 0.25,
    pillarConstraints: [
      "No hard leg strength the day before a long run",
      "48-hour recovery between hard efforts in same pillar",
      "Hard days hard, easy days easy"
    ],
    taperGuidance: taperGuidance,
    trainingFocus: _getTrainingFocus(goal.type),
    workoutStyle: _getWorkoutStyle(goal.type),
    flexibilityLevel: _getFlexibilityLevel(goal.type),

    // Strength guidance (Phase 1 - MVP)
    strengthGuidance: _buildStrengthGuidance(
      goalType: goal.type,
      priority: goal.strengthPriority ?? 'medium',
    ),

    // Mobility guidance (Phase 1 - MVP)
    mobilityGuidance: _buildMobilityGuidance(
      goalType: goal.type,
      priority: goal.mobilityPriority ?? 'medium',
    ),
  );
}

// Running helpers
IntensityStrategy _selectIntensityStrategy(
    GoalType goalType, double weeklyVolume) {
  if (goalType == GoalType.maintenance) return IntensityStrategy.maintenance;
  if (weeklyVolume < 30) return IntensityStrategy.pyramidal;
  if (weeklyVolume >= 40) return IntensityStrategy.polarized;
  return IntensityStrategy.pyramidal; // Default to safer approach
}

Map<String, double> _getIntensityBreakdown(IntensityStrategy strategy) {
  switch (strategy) {
    case IntensityStrategy.pyramidal:
      return {'easy': 0.80, 'moderate': 0.15, 'high': 0.05};
    case IntensityStrategy.polarized:
      return {'easy': 0.80, 'high': 0.20};
    case IntensityStrategy.maintenance:
      return {'easy': 0.85, 'moderate': 0.05, 'high': 0.10};
  }
}

TaperGuidance _buildTaperGuidance(double? targetDistance) {
  if (targetDistance == null || targetDistance <= 5) {
    return const TaperGuidance(
      strategy: "progressive_volume_reduction",
      minDurationDays: 7,
      maxDurationDays: 10,
      maintainIntensity: true,
    );
  } else if (targetDistance <= 10) {
    return const TaperGuidance(
      strategy: "progressive_volume_reduction",
      minDurationDays: 10,
      maxDurationDays: 14,
      maintainIntensity: true,
    );
  } else if (targetDistance <= 21.1) {
    return const TaperGuidance(
      strategy: "progressive_volume_reduction",
      minDurationDays: 14,
      maxDurationDays: 14,
      maintainIntensity: true,
    );
  } else {
    return const TaperGuidance(
      strategy: "progressive_volume_reduction",
      minDurationDays: 14,
      maxDurationDays: 21,
      maintainIntensity: true,
    );
  }
}

String _getTrainingFocus(GoalType goalType) {
  switch (goalType) {
    case GoalType.distanceMilestone:
      return "Completion over speed - build endurance safely and prevent injury";
    case GoalType.timePerformance:
      return "Speed development - improve race pace and efficiency";
    case GoalType.event:
      return "Peak performance on race day - periodized training with race-specific work";
    case GoalType.maintenance:
      return "Sustain fitness with minimal effective dose - prioritize enjoyment";
  }
}

String _getWorkoutStyle(GoalType goalType) {
  switch (goalType) {
    case GoalType.distanceMilestone:
      return "time_based"; // "Run for 30 minutes" reduces pressure
    case GoalType.timePerformance:
    case GoalType.event:
      return "distance_based"; // "6 x 400m" for specific targets
    case GoalType.maintenance:
      return "effort_based"; // "Easy 30 min or 5K, whatever feels good"
  }
}

String _getFlexibilityLevel(GoalType goalType) {
  switch (goalType) {
    case GoalType.distanceMilestone:
      return "high";
    case GoalType.timePerformance:
      return "medium";
    case GoalType.event:
      return "low";
    case GoalType.maintenance:
      return "very_high";
  }
}

// Strength helpers
StrengthGuidance _buildStrengthGuidance({
  required GoalType goalType,
  required String priority,
}) {
  final frequency = _getStrengthFrequency(priority, goalType);
  final duration = priority == 'high' ? 20 : (priority == 'medium' ? 15 : 10);
  final sets = priority == 'high' ? 3 : 2;

  return StrengthGuidance(
    weeklyFrequency: frequency,
    sessionDurationMinutes: duration,
    setsPerExercise: sets,
    repRange: "8-12",
  );
}

int _getStrengthFrequency(String priority, GoalType goalType) {
  // Maintenance goals boost strength if running is low
  if (goalType == GoalType.maintenance) return 3;

  switch (priority.toLowerCase()) {
    case 'high':
      return 4;
    case 'medium':
      return 3;
    case 'low':
      return 2;
    default:
      return 2;
  }
}

// Mobility helpers
MobilityGuidance _buildMobilityGuidance({
  required GoalType goalType,
  required String priority,
}) {
  final frequency = _getMobilityFrequency(priority);
  final duration = priority == 'high' ? 30 : (priority == 'medium' ? 20 : 15);

  return MobilityGuidance(
    weeklyFrequency: frequency,
    sessionDurationMinutes: duration,
    sessionTypes: const ["active_pre_run", "passive_post_run", "recovery_deep"],
    focusAreas: const [
      "hip_mobility",
      "ankle_mobility",
      "thoracic_spine",
      "hamstrings"
    ],
    increaseDuringTaper: goalType == GoalType.event,
  );
}

int _getMobilityFrequency(String priority) {
  switch (priority.toLowerCase()) {
    case 'high':
      return 6;
    case 'medium':
      return 4;
    case 'low':
      return 3;
    default:
      return 3;
  }
}
