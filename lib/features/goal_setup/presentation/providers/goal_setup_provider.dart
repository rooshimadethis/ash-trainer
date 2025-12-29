import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/shared/domain/entities/goal.dart';
import '../../../../features/shared/domain/entities/user.dart';
import '../../../../data/providers/repository_providers.dart';

// State for the Goal Setup flow
class GoalSetupState {
  final int currentStep;
  final List<String> availableDays;
  final String? constraints;
  final GoalType? selectedGoalType;
  // Goal details
  final double? targetDistance;
  final DateTime? targetDate;
  final int? targetTime; // in seconds
  final int? currentBestTime; // in seconds
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
    this.availableDays = const [],
    this.constraints,
    this.selectedGoalType,
    this.targetDistance,
    this.targetDate,
    this.targetTime,
    this.currentBestTime,
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
    List<String>? availableDays,
    String? constraints,
    GoalType? selectedGoalType,
    double? targetDistance,
    DateTime? targetDate,
    int? targetTime,
    int? currentBestTime,
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
      availableDays: availableDays ?? this.availableDays,
      constraints: constraints ?? this.constraints,
      selectedGoalType: selectedGoalType ?? this.selectedGoalType,
      targetDistance: targetDistance ?? this.targetDistance,
      targetDate: targetDate ?? this.targetDate,
      targetTime: targetTime ?? this.targetTime,
      currentBestTime: currentBestTime ?? this.currentBestTime,
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

  void setAvailableDays(List<String> days) {
    state = state.copyWith(availableDays: days);
  }

  void setConstraints(String? constraints) {
    state = state.copyWith(constraints: constraints);
  }

  void setGoalType(GoalType type) {
    state = state.copyWith(selectedGoalType: type);
  }

  // Specific goal detail setters
  void setDistanceMilestoneDetails({double? distance, DateTime? date}) {
    state = state.copyWith(targetDistance: distance, targetDate: date);
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

  void setHealthPermissions(bool granted) {
    state = state.copyWith(healthPermissionsGranted: granted);
  }

  Future<void> submitGoal() async {
    state = state.copyWith(isGenerating: true, error: null);
    try {
      final userRepo = ref.read(userRepositoryProvider);
      final goalRepo = ref.read(goalRepositoryProvider);

      // 1. Create User
      final newUser = User(
        id: '', // DB will assign ID
        availableDays: state.availableDays,
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
        eventName: state.eventName,
        eventDate: state.eventDate,
        maintenanceFrequency: state.maintenanceFrequency,
        maintenanceDuration: state.maintenanceDuration,
        endDate: state.endDate,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        // Defaults
        confidence: 85.0, // Per specs
      );

      await goalRepo.createGoal(newGoal);

      // TODO: Trigger plan generation via AI Service

      state = state.copyWith(isGenerating: false);
      nextStep(); // Move to Plan Review or Success
    } catch (e) {
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
}

final goalSetupProvider =
    StateNotifierProvider<GoalSetupNotifier, GoalSetupState>((ref) {
  return GoalSetupNotifier(ref);
});
