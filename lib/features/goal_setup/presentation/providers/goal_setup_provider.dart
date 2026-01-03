// lib/features/goal_setup/presentation/providers/goal_setup_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/shared/domain/entities/goal.dart';
import '../../../../features/shared/domain/entities/user.dart';
import '../../../../data/providers/repository_providers.dart';
import '../../../../infrastructure/providers/service_providers.dart';
import '../../../../core/utils/logger.dart';
import 'package:ash_trainer/features/shared/presentation/providers/ash_status_provider.dart';
import 'package:ash_trainer/core/tasks/background_tasks.dart';
import 'package:ash_trainer/features/shared/domain/entities/ai/context_models.dart';
import 'package:ash_trainer/features/developer/presentation/providers/debug_providers.dart';
import 'package:ash_trainer/data/providers/task_providers.dart';
import 'package:drift/drift.dart';
import 'package:ash_trainer/data/datasources/local/drift_database.dart';

// State for the Goal Setup flow
class GoalSetupState {
  final int currentStep;
  final int? age;
  final String? gender;
  final double? weight;
  final String preferredWeightUnit;
  final double? height;
  final String preferredHeightUnit;
  final List<String> unavailableDays;
  final String? constraints;

  final int? trainingFrequency;
  final double? currentWeeklyVolume;
  final String preferredDistanceUnit; // 'km' or 'mi'
  final String? runningPriority;
  final String? strengthPriority;
  final String? mobilityPriority;
  final GoalType? selectedGoalType;
  // Goal details
  final double? targetDistance;
  final DateTime? targetDate;
  final int? targetTime; // in seconds
  final int? currentBestTime; // in seconds
  final bool? isFirstTime;
  final String? eventName;
  final DateTime? eventDate;
  final int? maintenanceFrequency;
  final int? maintenanceDuration;
  final DateTime? endDate;

  final bool healthPermissionsGranted;
  final bool isGenerating;
  final String? error;

  const GoalSetupState({
    this.currentStep = 1,
    this.age,
    this.gender,
    this.weight,
    this.preferredWeightUnit = 'kg',
    this.height,
    this.preferredHeightUnit = 'cm',
    this.preferredDistanceUnit = 'km',
    this.unavailableDays = const [],
    this.constraints,
    this.trainingFrequency,
    this.currentWeeklyVolume,
    this.runningPriority,
    this.strengthPriority,
    this.mobilityPriority,
    this.selectedGoalType,
    this.targetDistance,
    this.targetDate,
    this.targetTime,
    this.currentBestTime,
    this.isFirstTime,
    this.eventName,
    this.eventDate,
    this.maintenanceFrequency,
    this.maintenanceDuration,
    this.endDate,
    this.healthPermissionsGranted = false,
    this.isGenerating = false,
    this.error,
  });

  GoalSetupState copyWith({
    int? currentStep,
    int? age,
    String? gender,
    double? weight,
    String? preferredWeightUnit,
    double? height,
    String? preferredHeightUnit,
    List<String>? unavailableDays,
    String? constraints,
    int? trainingFrequency,
    double? currentWeeklyVolume,
    String? preferredDistanceUnit,
    String? runningPriority,
    String? strengthPriority,
    String? mobilityPriority,
    GoalType? selectedGoalType,
    double? targetDistance,
    DateTime? targetDate,
    int? targetTime,
    int? currentBestTime,
    bool? isFirstTime,
    String? eventName,
    DateTime? eventDate,
    int? maintenanceFrequency,
    int? maintenanceDuration,
    DateTime? endDate,
    bool? healthPermissionsGranted,
    bool? isGenerating,
    String? error,
  }) {
    return GoalSetupState(
      currentStep: currentStep ?? this.currentStep,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      preferredWeightUnit: preferredWeightUnit ?? this.preferredWeightUnit,
      height: height ?? this.height,
      preferredHeightUnit: preferredHeightUnit ?? this.preferredHeightUnit,
      unavailableDays: unavailableDays ?? this.unavailableDays,
      constraints: constraints ?? this.constraints,
      trainingFrequency: trainingFrequency ?? this.trainingFrequency,
      currentWeeklyVolume: currentWeeklyVolume ?? this.currentWeeklyVolume,
      preferredDistanceUnit:
          preferredDistanceUnit ?? this.preferredDistanceUnit,
      runningPriority: runningPriority ?? this.runningPriority,
      strengthPriority: strengthPriority ?? this.strengthPriority,
      mobilityPriority: mobilityPriority ?? this.mobilityPriority,
      selectedGoalType: selectedGoalType ?? this.selectedGoalType,
      targetDistance: targetDistance ?? this.targetDistance,
      targetDate: targetDate ?? this.targetDate,
      targetTime: targetTime ?? this.targetTime,
      currentBestTime: currentBestTime ?? this.currentBestTime,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      maintenanceFrequency: maintenanceFrequency ?? this.maintenanceFrequency,
      maintenanceDuration: maintenanceDuration ?? this.maintenanceDuration,
      endDate: endDate ?? this.endDate,
      healthPermissionsGranted:
          healthPermissionsGranted ?? this.healthPermissionsGranted,
      isGenerating: isGenerating ?? this.isGenerating,
      error: error ?? this.error,
    );
  }
}

class GoalSetupNotifier extends StateNotifier<GoalSetupState> {
  final Ref ref;

  GoalSetupNotifier(this.ref) : super(const GoalSetupState());

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    if (state.currentStep > 1) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void setPersonalDetails({
    int? age,
    String? gender,
    double? weight,
    String? weightUnit,
    double? height,
    String? heightUnit,
  }) {
    state = state.copyWith(
      age: age,
      gender: gender,
      weight: weight,
      preferredWeightUnit: weightUnit,
      height: height,
      preferredHeightUnit: heightUnit,
    );
  }

  void setUnavailableDays(List<String> days) {
    state = state.copyWith(unavailableDays: days);
  }

  void setConstraints(String? constraints) {
    state = state.copyWith(constraints: constraints);
  }

  void setTrainingContext({
    int? frequency,
    double? volume,
    String? distanceUnit,
  }) {
    state = state.copyWith(
      trainingFrequency: frequency,
      currentWeeklyVolume: volume,
      preferredDistanceUnit: distanceUnit,
    );
  }

  void setPillarPriorities({
    String? running,
    String? strength,
    String? mobility,
  }) {
    // Enforce logic: Only 1 High priority allowed.
    // However, the UI should handle the interaction logic primarily.
    // Here we just save what is passed, assuming UI did the validation logic
    // or we can enforce it here too deeply.
    // For now, simple setter.
    state = state.copyWith(
      runningPriority: running,
      strengthPriority: strength,
      mobilityPriority: mobility,
    );
  }

  void setGoalType(GoalType type) {
    state = state.copyWith(selectedGoalType: type);
  }

  // Specific goal detail setters
  void setDistanceMilestoneDetails(
      {double? distance, DateTime? date, bool? isFirstTime}) {
    state = state.copyWith(
        targetDistance: distance, targetDate: date, isFirstTime: isFirstTime);
  }

  void setTimePerformanceDetails(
      {double? distance, int? time, int? currentBest}) {
    state = state.copyWith(
      targetDistance: distance,
      targetTime: time,
      currentBestTime: currentBest,
    );
  }

  void setEventDetails(
      {String? name, DateTime? date, double? distance, int? time}) {
    state = state.copyWith(
      eventName: name,
      eventDate: date,
      targetDistance: distance,
      targetTime: time,
    );
  }

  void setMaintenanceDetails({int? frequency, int? duration, DateTime? end}) {
    state = state.copyWith(
      maintenanceFrequency: frequency,
      maintenanceDuration: duration,
      endDate: end,
    );
  }

  Future<void> requestHealthPermissions() async {
    final healthService = ref.read(healthServiceProvider);
    final granted = await healthService.requestPermissions();
    state = state.copyWith(healthPermissionsGranted: granted);
  }

  void setHealthPermissions(bool granted) {
    state = state.copyWith(healthPermissionsGranted: granted);
  }

  Future<void> submitGoal() async {
    state = state.copyWith(isGenerating: true, error: null);
    ref.read(uiThinkingProvider.notifier).state = true;
    try {
      final userRepo = ref.read(userRepositoryProvider);
      final goalRepo = ref.read(goalRepositoryProvider);

      // 1. Create User
      final allDays = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
      final availableDays =
          allDays.where((day) => !state.unavailableDays.contains(day)).toList();

      final newUser = User(
        id: '', // DB will assign ID
        age: state.age,
        gender: state.gender,
        weight: state.weight,
        preferredWeightUnit: state.preferredWeightUnit,
        height: state.height,
        preferredHeightUnit: state.preferredHeightUnit,

        preferredDistanceUnit: state.preferredDistanceUnit,
        availableDays: availableDays,
        constraints: state.constraints,
        healthPermissionsGranted: state.healthPermissionsGranted,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final createdUser = await userRepo.createUser(newUser);

      // 2. Create Goal
      if (state.selectedGoalType == null) {
        throw Exception('No goal type selected');
      }

      final newGoal = Goal(
        id: '', // DB will assign ID
        userId: createdUser.id,
        type: state.selectedGoalType!,
        name: _generateGoalName(),
        targetDistance: state.targetDistance,
        targetDate: state.targetDate,
        targetTime: state.targetTime,
        currentBestTime: state.currentBestTime,
        isFirstTime: state.isFirstTime,
        eventName: state.eventName,
        eventDate: state.eventDate,
        maintenanceFrequency: state.maintenanceFrequency,
        maintenanceDuration: state.maintenanceDuration,
        endDate: state.endDate,
        // Initial Context
        initialTrainingFrequency: state.trainingFrequency,
        initialWeeklyVolume: _convertVolumeToKm(),
        runningPriority: state.runningPriority,
        strengthPriority: state.strengthPriority,
        mobilityPriority: state.mobilityPriority,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        // Defaults
        confidence: 85.0, // Per specs
      );

      final createdGoal = await goalRepo.createGoal(newGoal);

      // Trigger plan generation via Background Task
      final taskId = "plan_gen_${createdGoal.id}";
      final dao = ref.read(aiTaskDaoProvider);

      // 1. Manually insert 'running' task from foreground isolate for immediate UI feedback
      await dao.upsertTask(AiTasksCompanion(
        id: Value(taskId),
        taskType: Value(BackgroundTasks.planGenerationTask),
        status: Value('running'),
        targetId: Value(createdGoal.id),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ));

      // 2. Schedule the background job for reliability
      await BackgroundTasks.schedulePlanGeneration(
        goalId: createdGoal.id,
        userId: createdUser.id,
        mode: PlanningMode.initial,
        useMockAi: ref.read(debugUseMockAiProvider),
        alternateMockPlan: ref.read(debugAlternateMockPlanProvider),
      );

      // 3. Wait for the plan to be generated (polling the AiTasks table)
      bool isReady = false;
      int attempts = 0;
      const maxAttempts = 180; // 3 minutes

      while (!isReady && attempts < maxAttempts) {
        await Future.delayed(const Duration(seconds: 1));
        try {
          final task = await dao.getTask(taskId);

          // If task is gone, it means it completed (or failed)
          // We verify success by checking for workouts
          if (task == null) {
            final workouts = await ref
                .read(workoutRepositoryProvider)
                .getWorkoutsForGoal(createdGoal.id);
            if (workouts.isNotEmpty) {
              isReady = true;
            } else {
              // Check if it failed or if we're just in a race condition
              // If we've been polling for a while and no workouts, it failed.
              if (attempts > 5) {
                throw Exception('Plan generation failed in background.');
              }
            }
          }
        } catch (e) {
          if (e.toString().contains('locked')) {
            AppLogger.w('Database locked during poll, retrying...');
          } else {
            rethrow;
          }
        }
        attempts++;
      }

      if (!isReady) {
        throw Exception(
            'Plan generation timed out. Ash is taking longer than expected.');
      }

      ref.read(uiThinkingProvider.notifier).state = false;
      state = state.copyWith(isGenerating: false);
      nextStep(); // Move to Plan Review or Success
    } catch (e, stackTrace) {
      AppLogger.e('Failed to submit goal', error: e, stackTrace: stackTrace);
      ref.read(uiThinkingProvider.notifier).state = false;
      state = state.copyWith(isGenerating: false, error: e.toString());
    }
  }

  String _generateGoalName() {
    switch (state.selectedGoalType) {
      case GoalType.distanceMilestone:
        return 'Distance Goal';
      case GoalType.timePerformance:
        return 'Time Goal';
      case GoalType.event:
        return state.eventName ?? 'Event Goal';
      case GoalType.maintenance:
        return 'Maintenance';
      default:
        return 'Training Goal';
    }
  }

  double? _convertVolumeToKm() {
    if (state.currentWeeklyVolume == null) return null;
    if (state.preferredDistanceUnit == 'mi') {
      // 1 mile = 1.60934 km
      return state.currentWeeklyVolume! * 1.60934;
    }
    return state.currentWeeklyVolume;
  }
}

final goalSetupProvider =
    StateNotifierProvider<GoalSetupNotifier, GoalSetupState>((ref) {
  return GoalSetupNotifier(ref);
});
