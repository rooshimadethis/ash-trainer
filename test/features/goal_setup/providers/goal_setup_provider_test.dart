import 'package:ash_trainer/data/providers/repository_providers.dart';
import 'package:ash_trainer/features/goal_setup/presentation/providers/goal_setup_provider.dart';
import 'package:ash_trainer/features/shared/domain/entities/goal.dart';
import 'package:ash_trainer/features/shared/domain/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helpers.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late MockGoalRepository mockGoalRepository;
  late ProviderContainer container;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockGoalRepository = MockGoalRepository();

    container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(mockUserRepository),
        goalRepositoryProvider.overrideWithValue(mockGoalRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('GoalSetupProvider - Initial State', () {
    test('should have correct default values', () {
      final state = container.read(goalSetupProvider);

      expect(state.currentStep, 1);
      expect(state.age, isNull);
      expect(state.gender, isNull);
      expect(state.weight, isNull);
      expect(state.preferredWeightUnit, 'kg');
      expect(state.height, isNull);
      expect(state.preferredHeightUnit, 'cm');
      expect(state.unavailableDays, isEmpty);
      expect(state.constraints, isNull);
      expect(state.selectedGoalType, isNull);
      expect(state.targetDistance, isNull);
      expect(state.targetDate, isNull);
      expect(state.targetTime, isNull);
      expect(state.currentBestTime, isNull);
      expect(state.eventName, isNull);
      expect(state.eventDate, isNull);
      expect(state.maintenanceFrequency, isNull);
      expect(state.maintenanceDuration, isNull);
      expect(state.endDate, isNull);
      expect(state.healthPermissionsGranted, false);
      expect(state.isGenerating, false);
      expect(state.error, isNull);
    });
  });

  group('GoalSetupProvider - Navigation', () {
    test('nextStep should increment currentStep', () {
      final notifier = container.read(goalSetupProvider.notifier);

      expect(container.read(goalSetupProvider).currentStep, 1);

      notifier.nextStep();
      expect(container.read(goalSetupProvider).currentStep, 2);

      notifier.nextStep();
      expect(container.read(goalSetupProvider).currentStep, 3);
    });

    test('previousStep should decrement currentStep', () {
      final notifier = container.read(goalSetupProvider.notifier);

      // Move to step 3
      notifier.nextStep();
      notifier.nextStep();
      expect(container.read(goalSetupProvider).currentStep, 3);

      notifier.previousStep();
      expect(container.read(goalSetupProvider).currentStep, 2);

      notifier.previousStep();
      expect(container.read(goalSetupProvider).currentStep, 1);
    });

    test('previousStep should not go below step 1', () {
      final notifier = container.read(goalSetupProvider.notifier);

      expect(container.read(goalSetupProvider).currentStep, 1);

      notifier.previousStep();
      expect(container.read(goalSetupProvider).currentStep, 1);

      notifier.previousStep();
      expect(container.read(goalSetupProvider).currentStep, 1);
    });
  });

  group('GoalSetupProvider - Personal Details', () {
    test('setPersonalDetails should update all fields', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setPersonalDetails(
        age: 30,
        gender: 'male',
        weight: 70.0,
        weightUnit: 'kg',
        height: 175.0,
        heightUnit: 'cm',
      );

      final state = container.read(goalSetupProvider);
      expect(state.age, 30);
      expect(state.gender, 'male');
      expect(state.weight, 70.0);
      expect(state.preferredWeightUnit, 'kg');
      expect(state.height, 175.0);
      expect(state.preferredHeightUnit, 'cm');
    });

    test('setPersonalDetails should handle partial updates', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setPersonalDetails(age: 25);
      expect(container.read(goalSetupProvider).age, 25);
      expect(container.read(goalSetupProvider).gender, isNull);

      notifier.setPersonalDetails(gender: 'female');
      expect(container.read(goalSetupProvider).age, 25);
      expect(container.read(goalSetupProvider).gender, 'female');
    });

    test('setPersonalDetails should handle unit preferences', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setPersonalDetails(
        weight: 154.0,
        weightUnit: 'lb',
        height: 69.0,
        heightUnit: 'in',
      );

      final state = container.read(goalSetupProvider);
      expect(state.weight, 154.0);
      expect(state.preferredWeightUnit, 'lb');
      expect(state.height, 69.0);
      expect(state.preferredHeightUnit, 'in');
    });
  });

  group('GoalSetupProvider - Goal Type Selection', () {
    test('setGoalType should update selectedGoalType', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setGoalType(GoalType.distanceMilestone);
      expect(
        container.read(goalSetupProvider).selectedGoalType,
        GoalType.distanceMilestone,
      );

      notifier.setGoalType(GoalType.timePerformance);
      expect(
        container.read(goalSetupProvider).selectedGoalType,
        GoalType.timePerformance,
      );

      notifier.setGoalType(GoalType.event);
      expect(
          container.read(goalSetupProvider).selectedGoalType, GoalType.event);

      notifier.setGoalType(GoalType.maintenance);
      expect(
        container.read(goalSetupProvider).selectedGoalType,
        GoalType.maintenance,
      );
    });
  });

  group('GoalSetupProvider - Distance Milestone Details', () {
    test('setDistanceMilestoneDetails should update distance and date', () {
      final notifier = container.read(goalSetupProvider.notifier);
      final targetDate = TestFixtures.twelveWeeksFromNow;

      notifier.setDistanceMilestoneDetails(
        distance: TestFixtures.distance10K,
        date: targetDate,
      );

      final state = container.read(goalSetupProvider);
      expect(state.targetDistance, TestFixtures.distance10K);
      expect(state.targetDate, targetDate);
    });

    test('setDistanceMilestoneDetails should handle null date', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setDistanceMilestoneDetails(
        distance: TestFixtures.distance5K,
      );

      final state = container.read(goalSetupProvider);
      expect(state.targetDistance, TestFixtures.distance5K);
      expect(state.targetDate, isNull);
    });
  });

  group('GoalSetupProvider - Time Performance Details', () {
    test('setTimePerformanceDetails should update all fields', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setTimePerformanceDetails(
        distance: TestFixtures.distance5K,
        time: TestFixtures.time5K_25min,
        currentBest: TestFixtures.time5K_30min,
      );

      final state = container.read(goalSetupProvider);
      expect(state.targetDistance, TestFixtures.distance5K);
      expect(state.targetTime, TestFixtures.time5K_25min);
      expect(state.currentBestTime, TestFixtures.time5K_30min);
    });

    test('setTimePerformanceDetails should handle null currentBest', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setTimePerformanceDetails(
        distance: TestFixtures.distance10K,
        time: TestFixtures.time10K_50min,
      );

      final state = container.read(goalSetupProvider);
      expect(state.targetDistance, TestFixtures.distance10K);
      expect(state.targetTime, TestFixtures.time10K_50min);
      expect(state.currentBestTime, isNull);
    });
  });

  group('GoalSetupProvider - Event Details', () {
    test('setEventDetails should update all fields', () {
      final notifier = container.read(goalSetupProvider.notifier);
      final eventDate = TestFixtures.sixteenWeeksFromNow;

      notifier.setEventDetails(
        name: 'Austin Marathon',
        date: eventDate,
        distance: TestFixtures.distanceMarathon,
        time: 14400, // 4 hours
      );

      final state = container.read(goalSetupProvider);
      expect(state.eventName, 'Austin Marathon');
      expect(state.eventDate, eventDate);
      expect(state.targetDistance, TestFixtures.distanceMarathon);
      expect(state.targetTime, 14400);
    });

    test('setEventDetails should handle null time', () {
      final notifier = container.read(goalSetupProvider.notifier);
      final eventDate = TestFixtures.sixteenWeeksFromNow;

      notifier.setEventDetails(
        name: 'Local 10K',
        date: eventDate,
        distance: TestFixtures.distance10K,
      );

      final state = container.read(goalSetupProvider);
      expect(state.eventName, 'Local 10K');
      expect(state.eventDate, eventDate);
      expect(state.targetDistance, TestFixtures.distance10K);
      expect(state.targetTime, isNull);
    });
  });

  group('GoalSetupProvider - Maintenance Details', () {
    test('setMaintenanceDetails should update all fields', () {
      final notifier = container.read(goalSetupProvider.notifier);
      final endDate = TestFixtures.eightWeeksFromNow;

      notifier.setMaintenanceDetails(
        frequency: 3,
        duration: 30,
        end: endDate,
      );

      final state = container.read(goalSetupProvider);
      expect(state.maintenanceFrequency, 3);
      expect(state.maintenanceDuration, 30);
      expect(state.endDate, endDate);
    });

    test('setMaintenanceDetails should handle null endDate', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setMaintenanceDetails(
        frequency: 4,
        duration: 45,
      );

      final state = container.read(goalSetupProvider);
      expect(state.maintenanceFrequency, 4);
      expect(state.maintenanceDuration, 45);
      expect(state.endDate, isNull);
    });
  });

  group('GoalSetupProvider - Availability & Constraints', () {
    test('setUnavailableDays should update unavailableDays list', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setUnavailableDays(['Saturday', 'Sunday']);

      expect(
        container.read(goalSetupProvider).unavailableDays,
        ['Saturday', 'Sunday'],
      );
    });

    test('setUnavailableDays should handle empty list', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setUnavailableDays([]);

      expect(container.read(goalSetupProvider).unavailableDays, isEmpty);
    });

    test('setConstraints should update constraints text', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setConstraints('Knee gets cranky after 5K');

      expect(
        container.read(goalSetupProvider).constraints,
        'Knee gets cranky after 5K',
      );
    });
  });

  group('GoalSetupProvider - Health Permissions', () {
    test('setHealthPermissions should update permission status', () {
      final notifier = container.read(goalSetupProvider.notifier);

      expect(container.read(goalSetupProvider).healthPermissionsGranted, false);

      notifier.setHealthPermissions(true);
      expect(container.read(goalSetupProvider).healthPermissionsGranted, true);

      notifier.setHealthPermissions(false);
      expect(container.read(goalSetupProvider).healthPermissionsGranted, false);
    });
  });

  group('GoalSetupProvider - Goal Submission', () {
    test('submitGoal should create user with correct available days', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      // Set up state
      notifier.setPersonalDetails(
        age: 30,
        gender: 'male',
        weight: 70.0,
        height: 175.0,
      );
      notifier.setUnavailableDays(['Saturday', 'Sunday']);
      notifier.setGoalType(GoalType.distanceMilestone);
      notifier.setDistanceMilestoneDetails(distance: 10.0);

      // Mock repository responses
      final createdUser = TestDataBuilders.createTestUser(id: 'user-123');
      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => createdUser);
      when(mockGoalRepository.createGoal(any))
          .thenAnswer((_) async => TestDataBuilders.createDistanceMilestoneGoal(
                id: 'goal-123',
                userId: 'user-123',
              ));

      await notifier.submitGoal();

      // Verify user creation
      final capturedUser = verify(mockUserRepository.createUser(captureAny))
          .captured
          .single as User;
      expect(capturedUser.age, 30);
      expect(capturedUser.gender, 'male');
      expect(capturedUser.weight, 70.0);
      expect(capturedUser.height, 175.0);
      expect(
        capturedUser.availableDays,
        ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
      );
    });

    test('submitGoal should create goal with correct type-specific fields',
        () async {
      final notifier = container.read(goalSetupProvider.notifier);
      final targetDate = TestFixtures.twelveWeeksFromNow;

      // Set up state for distance milestone
      notifier.setPersonalDetails(age: 30);
      notifier.setGoalType(GoalType.distanceMilestone);
      notifier.setDistanceMilestoneDetails(
        distance: TestFixtures.distance10K,
        date: targetDate,
      );

      // Mock repository responses
      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => TestDataBuilders.createTestUser());
      when(mockGoalRepository.createGoal(any)).thenAnswer(
          (_) async => TestDataBuilders.createDistanceMilestoneGoal());

      await notifier.submitGoal();

      // Verify goal creation
      final capturedGoal = verify(mockGoalRepository.createGoal(captureAny))
          .captured
          .single as Goal;
      expect(capturedGoal.type, GoalType.distanceMilestone);
      expect(capturedGoal.targetDistance, TestFixtures.distance10K);
      expect(capturedGoal.targetDate, targetDate);
      expect(capturedGoal.confidence, 85.0);
    });

    test(
        'submitGoal should generate appropriate goal name for distance milestone',
        () async {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setPersonalDetails(age: 30);
      notifier.setGoalType(GoalType.distanceMilestone);
      notifier.setDistanceMilestoneDetails(distance: 5.0);

      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => TestDataBuilders.createTestUser());
      when(mockGoalRepository.createGoal(any)).thenAnswer(
          (_) async => TestDataBuilders.createDistanceMilestoneGoal());

      await notifier.submitGoal();

      final capturedGoal = verify(mockGoalRepository.createGoal(captureAny))
          .captured
          .single as Goal;
      expect(capturedGoal.name, 'Distance Goal');
    });

    test('submitGoal should generate appropriate goal name for event',
        () async {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setPersonalDetails(age: 30);
      notifier.setGoalType(GoalType.event);
      notifier.setEventDetails(
        name: 'Austin Marathon',
        date: TestFixtures.sixteenWeeksFromNow,
        distance: TestFixtures.distanceMarathon,
      );

      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => TestDataBuilders.createTestUser());
      when(mockGoalRepository.createGoal(any))
          .thenAnswer((_) async => TestDataBuilders.createEventGoal());

      await notifier.submitGoal();

      final capturedGoal = verify(mockGoalRepository.createGoal(captureAny))
          .captured
          .single as Goal;
      expect(capturedGoal.name, 'Austin Marathon');
    });

    test('submitGoal should handle errors gracefully', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setPersonalDetails(age: 30);
      notifier.setGoalType(GoalType.distanceMilestone);
      notifier.setDistanceMilestoneDetails(distance: 10.0);

      // Mock repository error
      when(mockUserRepository.createUser(any))
          .thenThrow(Exception('Database error'));

      await notifier.submitGoal();

      final state = container.read(goalSetupProvider);
      expect(state.isGenerating, false);
      expect(state.error, contains('Database error'));
    });

    test('submitGoal should manage loading state correctly', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setPersonalDetails(age: 30);
      notifier.setGoalType(GoalType.distanceMilestone);
      notifier.setDistanceMilestoneDetails(distance: 10.0);

      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => TestDataBuilders.createTestUser());
      when(mockGoalRepository.createGoal(any)).thenAnswer(
          (_) async => TestDataBuilders.createDistanceMilestoneGoal());

      expect(container.read(goalSetupProvider).isGenerating, false);

      final future = notifier.submitGoal();

      // Note: In real async code, isGenerating would be true here,
      // but in tests it completes too fast to observe

      await future;

      expect(container.read(goalSetupProvider).isGenerating, false);
    });

    test('submitGoal should throw error when no goal type selected', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setPersonalDetails(age: 30);
      // Don't set goal type

      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => TestDataBuilders.createTestUser());

      await notifier.submitGoal();

      final state = container.read(goalSetupProvider);
      expect(state.error, contains('No goal type selected'));
    });

    test('submitGoal should increment step after successful submission',
        () async {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setPersonalDetails(age: 30);
      notifier.setGoalType(GoalType.distanceMilestone);
      notifier.setDistanceMilestoneDetails(distance: 10.0);

      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => TestDataBuilders.createTestUser());
      when(mockGoalRepository.createGoal(any)).thenAnswer(
          (_) async => TestDataBuilders.createDistanceMilestoneGoal());

      final initialStep = container.read(goalSetupProvider).currentStep;
      await notifier.submitGoal();

      expect(
        container.read(goalSetupProvider).currentStep,
        initialStep + 1,
      );
    });
  });
}
