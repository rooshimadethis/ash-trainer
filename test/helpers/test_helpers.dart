import 'package:ash_trainer/features/shared/domain/entities/goal.dart';
import 'package:ash_trainer/features/shared/domain/entities/user.dart';
import 'package:ash_trainer/features/shared/domain/repositories/goal_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';

// Generate mocks for repositories
@GenerateMocks([UserRepository, GoalRepository])
void main() {}

/// Test Data Builders
class TestDataBuilders {
  /// Creates a test User with default values
  static User createTestUser({
    String id = 'test-user-1',
    int? age = 30,
    String? gender = 'male',
    double? weight = 70.0,
    String preferredWeightUnit = 'kg',
    double? height = 175.0,
    String preferredHeightUnit = 'cm',
    List<String> availableDays = const [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ],
    String? constraints,
    bool healthPermissionsGranted = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final now = DateTime.now();
    return User(
      id: id,
      age: age,
      gender: gender,
      weight: weight,
      preferredWeightUnit: preferredWeightUnit,
      height: height,
      preferredHeightUnit: preferredHeightUnit,
      availableDays: availableDays,
      constraints: constraints,
      healthPermissionsGranted: healthPermissionsGranted,
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? now,
    );
  }

  /// Creates a test Goal with default values
  static Goal createTestGoal({
    String id = 'test-goal-1',
    String userId = 'test-user-1',
    required GoalType type,
    String? name,
    bool isActive = true,
    double? targetDistance,
    DateTime? targetDate,
    int? targetTime,
    int? currentBestTime,
    String? eventName,
    DateTime? eventDate,
    int? maintenanceFrequency,
    int? maintenanceDuration,
    DateTime? endDate,
    double confidence = 85.0,
    double adherenceScore = 0.0,
    double qualityScore = 0.0,
    double consistencyScore = 0.0,
    double recoveryScore = 0.0,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final now = DateTime.now();
    return Goal(
      id: id,
      userId: userId,
      type: type,
      name: name ?? _generateDefaultGoalName(type, eventName),
      isActive: isActive,
      targetDistance: targetDistance,
      targetDate: targetDate,
      targetTime: targetTime,
      currentBestTime: currentBestTime,
      eventName: eventName,
      eventDate: eventDate,
      maintenanceFrequency: maintenanceFrequency,
      maintenanceDuration: maintenanceDuration,
      endDate: endDate,
      confidence: confidence,
      adherenceScore: adherenceScore,
      qualityScore: qualityScore,
      consistencyScore: consistencyScore,
      recoveryScore: recoveryScore,
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? now,
    );
  }

  static String _generateDefaultGoalName(GoalType type, String? eventName) {
    switch (type) {
      case GoalType.distanceMilestone:
        return 'Distance Goal';
      case GoalType.timePerformance:
        return 'Time Goal';
      case GoalType.event:
        return eventName ?? 'Event Goal';
      case GoalType.maintenance:
        return 'Maintenance';
    }
  }

  /// Creates a Distance Milestone goal
  static Goal createDistanceMilestoneGoal({
    String id = 'test-goal-1',
    String userId = 'test-user-1',
    double targetDistance = 10.0, // 10K
    DateTime? targetDate,
  }) {
    return createTestGoal(
      id: id,
      userId: userId,
      type: GoalType.distanceMilestone,
      targetDistance: targetDistance,
      targetDate: targetDate ??
          DateTime.now().add(const Duration(days: 84)), // 12 weeks
    );
  }

  /// Creates a Time Performance goal
  static Goal createTimePerformanceGoal({
    String id = 'test-goal-1',
    String userId = 'test-user-1',
    double targetDistance = 5.0, // 5K
    int targetTime = 1500, // 25:00 in seconds
    int? currentBestTime,
  }) {
    return createTestGoal(
      id: id,
      userId: userId,
      type: GoalType.timePerformance,
      targetDistance: targetDistance,
      targetTime: targetTime,
      currentBestTime: currentBestTime,
    );
  }

  /// Creates an Event goal
  static Goal createEventGoal({
    String id = 'test-goal-1',
    String userId = 'test-user-1',
    String eventName = 'Austin Marathon',
    DateTime? eventDate,
    double targetDistance = 42.195, // Marathon
    int? targetTime,
  }) {
    return createTestGoal(
      id: id,
      userId: userId,
      type: GoalType.event,
      eventName: eventName,
      eventDate: eventDate ??
          DateTime.now().add(const Duration(days: 112)), // 16 weeks
      targetDistance: targetDistance,
      targetTime: targetTime,
    );
  }

  /// Creates a Maintenance goal
  static Goal createMaintenanceGoal({
    String id = 'test-goal-1',
    String userId = 'test-user-1',
    int maintenanceFrequency = 3, // 3 runs per week
    int maintenanceDuration = 30, // 30 minutes
    DateTime? endDate,
  }) {
    return createTestGoal(
      id: id,
      userId: userId,
      type: GoalType.maintenance,
      maintenanceFrequency: maintenanceFrequency,
      maintenanceDuration: maintenanceDuration,
      endDate: endDate,
    );
  }
}

/// Helper to create a ProviderContainer for testing
ProviderContainer createTestProviderContainer({
  List<Override> overrides = const [],
}) {
  return ProviderContainer(
    overrides: overrides,
  );
}

/// Common test fixtures
class TestFixtures {
  static final DateTime now = DateTime.now();

  // Common dates
  static DateTime get today => DateTime(now.year, now.month, now.day);
  static DateTime get tomorrow => today.add(const Duration(days: 1));
  static DateTime get nextWeek => today.add(const Duration(days: 7));
  static DateTime get eightWeeksFromNow => today.add(const Duration(days: 56));
  static DateTime get twelveWeeksFromNow => today.add(const Duration(days: 84));
  static DateTime get sixteenWeeksFromNow =>
      today.add(const Duration(days: 112));
  static DateTime get twentyWeeksFromNow =>
      today.add(const Duration(days: 140));

  // Common distances (in km)
  static const double distance5K = 5.0;
  static const double distance10K = 10.0;
  static const double distanceHalfMarathon = 21.0975;
  static const double distanceMarathon = 42.195;

  // Common times (in seconds)
  static const int time5K_20min = 1200;
  static const int time5K_25min = 1500;
  static const int time5K_30min = 1800;
  static const int time10K_45min = 2700;
  static const int time10K_50min = 3000;
  static const int time10K_60min = 3600;

  // Common day lists
  static const List<String> allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> weekdaysOnly = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  static const List<String> weekendsOnly = [
    'Saturday',
    'Sunday',
  ];
}
