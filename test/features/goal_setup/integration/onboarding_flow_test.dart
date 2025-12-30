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

  group('Onboarding Flow Integration Tests', () {
    test('Complete Distance Milestone flow', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      // Step 1: Welcome Screen (initial state)
      expect(container.read(goalSetupProvider).currentStep, 1);

      // Step 2: Select Goal Type
      notifier.nextStep();
      notifier.setGoalType(GoalType.distanceMilestone);
      expect(
        container.read(goalSetupProvider).selectedGoalType,
        GoalType.distanceMilestone,
      );

      // Step 3: Goal Details
      notifier.nextStep();
      notifier.setDistanceMilestoneDetails(
        distance: TestFixtures.distance10K,
        date: TestFixtures.twelveWeeksFromNow,
      );
      expect(
        container.read(goalSetupProvider).targetDistance,
        TestFixtures.distance10K,
      );
      expect(
        container.read(goalSetupProvider).targetDate,
        TestFixtures.twelveWeeksFromNow,
      );

      // Step 4: Personal Details
      notifier.nextStep();
      notifier.setPersonalDetails(
        age: 30,
        gender: 'male',
        weight: 70.0,
        weightUnit: 'kg',
        height: 175.0,
        heightUnit: 'cm',
      );
      expect(container.read(goalSetupProvider).age, 30);
      expect(container.read(goalSetupProvider).gender, 'male');

      // Step 5: Availability
      notifier.nextStep();
      notifier.setUnavailableDays(['Saturday', 'Sunday']);
      expect(
        container.read(goalSetupProvider).unavailableDays,
        ['Saturday', 'Sunday'],
      );

      // Step 6: Constraints
      notifier.nextStep();
      notifier.setConstraints('Knee gets cranky after 5K');
      expect(
        container.read(goalSetupProvider).constraints,
        'Knee gets cranky after 5K',
      );

      // Step 7: Health Permissions
      notifier.nextStep();
      notifier.setHealthPermissions(true);
      expect(container.read(goalSetupProvider).healthPermissionsGranted, true);

      // Mock repository responses
      final createdUser = TestDataBuilders.createTestUser(id: 'user-123');
      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => createdUser);
      when(mockGoalRepository.createGoal(any)).thenAnswer(
        (_) async => TestDataBuilders.createDistanceMilestoneGoal(
          id: 'goal-123',
          userId: 'user-123',
        ),
      );

      // Submit Goal
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
      expect(capturedUser.constraints, 'Knee gets cranky after 5K');
      expect(capturedUser.healthPermissionsGranted, true);

      // Verify goal creation
      final capturedGoal = verify(mockGoalRepository.createGoal(captureAny))
          .captured
          .single as Goal;
      expect(capturedGoal.type, GoalType.distanceMilestone);
      expect(capturedGoal.targetDistance, TestFixtures.distance10K);
      expect(capturedGoal.targetDate, TestFixtures.twelveWeeksFromNow);
      expect(capturedGoal.confidence, 85.0);
    });

    test('Complete Time Performance flow', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      // Navigate through flow
      notifier.nextStep(); // Welcome -> Goal Type
      notifier.setGoalType(GoalType.timePerformance);

      notifier.nextStep(); // Goal Type -> Goal Details
      notifier.setTimePerformanceDetails(
        distance: TestFixtures.distance5K,
        time: TestFixtures.time5K_25min,
        currentBest: TestFixtures.time5K_30min,
      );

      notifier.nextStep(); // Goal Details -> Personal Details
      notifier.setPersonalDetails(age: 25, gender: 'female');

      notifier.nextStep(); // Personal Details -> Availability
      notifier.setUnavailableDays([]);

      notifier.nextStep(); // Availability -> Constraints
      notifier.setConstraints(null);

      notifier.nextStep(); // Constraints -> Health Permissions
      notifier.setHealthPermissions(false);

      // Mock repository responses
      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => TestDataBuilders.createTestUser());
      when(mockGoalRepository.createGoal(any)).thenAnswer(
        (_) async => TestDataBuilders.createTimePerformanceGoal(),
      );

      await notifier.submitGoal();

      // Verify goal creation
      final capturedGoal = verify(mockGoalRepository.createGoal(captureAny))
          .captured
          .single as Goal;
      expect(capturedGoal.type, GoalType.timePerformance);
      expect(capturedGoal.targetDistance, TestFixtures.distance5K);
      expect(capturedGoal.targetTime, TestFixtures.time5K_25min);
      expect(capturedGoal.currentBestTime, TestFixtures.time5K_30min);
    });

    test('Complete Event flow', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.nextStep();
      notifier.setGoalType(GoalType.event);

      notifier.nextStep();
      notifier.setEventDetails(
        name: 'Austin Marathon',
        date: TestFixtures.sixteenWeeksFromNow,
        distance: TestFixtures.distanceMarathon,
        time: 14400, // 4 hours
      );

      notifier.nextStep();
      notifier.setPersonalDetails(age: 35);

      notifier.nextStep();
      notifier.setUnavailableDays(['Sunday']);

      notifier.nextStep();
      notifier.setConstraints(null);

      notifier.nextStep();
      notifier.setHealthPermissions(true);

      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => TestDataBuilders.createTestUser());
      when(mockGoalRepository.createGoal(any)).thenAnswer(
        (_) async => TestDataBuilders.createEventGoal(),
      );

      await notifier.submitGoal();

      final capturedGoal = verify(mockGoalRepository.createGoal(captureAny))
          .captured
          .single as Goal;
      expect(capturedGoal.type, GoalType.event);
      expect(capturedGoal.eventName, 'Austin Marathon');
      expect(capturedGoal.eventDate, TestFixtures.sixteenWeeksFromNow);
      expect(capturedGoal.targetDistance, TestFixtures.distanceMarathon);
      expect(capturedGoal.targetTime, 14400);
    });

    test('Complete Maintenance flow', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.nextStep();
      notifier.setGoalType(GoalType.maintenance);

      notifier.nextStep();
      notifier.setMaintenanceDetails(
        frequency: 3,
        duration: 30,
        end: TestFixtures.eightWeeksFromNow,
      );

      notifier.nextStep();
      notifier.setPersonalDetails(age: 40);

      notifier.nextStep();
      notifier.setUnavailableDays(TestFixtures.weekendsOnly);

      notifier.nextStep();
      notifier.setConstraints('Max 30 min per session');

      notifier.nextStep();
      notifier.setHealthPermissions(true);

      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => TestDataBuilders.createTestUser());
      when(mockGoalRepository.createGoal(any)).thenAnswer(
        (_) async => TestDataBuilders.createMaintenanceGoal(),
      );

      await notifier.submitGoal();

      final capturedGoal = verify(mockGoalRepository.createGoal(captureAny))
          .captured
          .single as Goal;
      expect(capturedGoal.type, GoalType.maintenance);
      expect(capturedGoal.maintenanceFrequency, 3);
      expect(capturedGoal.maintenanceDuration, 30);
      expect(capturedGoal.endDate, TestFixtures.eightWeeksFromNow);
    });

    test('Navigation back and forward preserves state', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      // Move forward and set data
      notifier.nextStep();
      notifier.setGoalType(GoalType.distanceMilestone);

      notifier.nextStep();
      notifier.setDistanceMilestoneDetails(distance: 10.0);

      notifier.nextStep();
      notifier.setPersonalDetails(age: 30, gender: 'male');

      // Navigate back
      notifier.previousStep();
      notifier.previousStep();

      // Verify state is preserved
      expect(
        container.read(goalSetupProvider).selectedGoalType,
        GoalType.distanceMilestone,
      );
      expect(container.read(goalSetupProvider).targetDistance, 10.0);
      expect(container.read(goalSetupProvider).age, 30);
      expect(container.read(goalSetupProvider).gender, 'male');

      // Navigate forward again
      notifier.nextStep();
      notifier.nextStep();

      // State should still be there
      expect(container.read(goalSetupProvider).age, 30);
      expect(container.read(goalSetupProvider).gender, 'male');
    });

    test('Error handling on submission failure', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      // Set up minimal valid state
      notifier.setGoalType(GoalType.distanceMilestone);
      notifier.setDistanceMilestoneDetails(distance: 10.0);
      notifier.setPersonalDetails(age: 30);

      // Mock repository error
      when(mockUserRepository.createUser(any))
          .thenThrow(Exception('Database connection failed'));

      await notifier.submitGoal();

      // Verify error state
      final state = container.read(goalSetupProvider);
      expect(state.isGenerating, false);
      expect(state.error, contains('Database connection failed'));
    });

    test('Available days computed correctly from unavailable days', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setGoalType(GoalType.distanceMilestone);
      notifier.setDistanceMilestoneDetails(distance: 5.0);
      notifier.setPersonalDetails(age: 25);
      notifier.setUnavailableDays(['Monday', 'Wednesday', 'Friday']);

      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => TestDataBuilders.createTestUser());
      when(mockGoalRepository.createGoal(any)).thenAnswer(
          (_) async => TestDataBuilders.createDistanceMilestoneGoal());

      await notifier.submitGoal();

      final capturedUser = verify(mockUserRepository.createUser(captureAny))
          .captured
          .single as User;
      expect(
        capturedUser.availableDays,
        ['Tuesday', 'Thursday', 'Saturday', 'Sunday'],
      );
    });

    test('All days available when no unavailable days set', () async {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setGoalType(GoalType.maintenance);
      notifier.setMaintenanceDetails(frequency: 3, duration: 30);
      notifier.setPersonalDetails(age: 30);
      notifier.setUnavailableDays([]); // No unavailable days

      when(mockUserRepository.createUser(any))
          .thenAnswer((_) async => TestDataBuilders.createTestUser());
      when(mockGoalRepository.createGoal(any))
          .thenAnswer((_) async => TestDataBuilders.createMaintenanceGoal());

      await notifier.submitGoal();

      final capturedUser = verify(mockUserRepository.createUser(captureAny))
          .captured
          .single as User;
      expect(capturedUser.availableDays, TestFixtures.allDays);
    });
  });
}
