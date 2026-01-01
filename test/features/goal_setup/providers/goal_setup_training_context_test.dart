import 'package:ash_trainer/data/providers/repository_providers.dart';
import 'package:ash_trainer/features/goal_setup/presentation/providers/goal_setup_provider.dart';
import 'package:ash_trainer/features/training/presentation/providers/use_case_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockUserRepository mockUserRepository;
  late MockGoalRepository mockGoalRepository;
  late MockGenerateTrainingPlan mockGenerateTrainingPlan;
  late ProviderContainer container;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockGoalRepository = MockGoalRepository();
    mockGenerateTrainingPlan = MockGenerateTrainingPlan();

    container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(mockUserRepository),
        goalRepositoryProvider.overrideWithValue(mockGoalRepository),
        generateTrainingPlanProvider
            .overrideWithValue(mockGenerateTrainingPlan),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('GoalSetupProvider - Training Context', () {
    test('setTrainingContext should update frequency and volume', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setTrainingContext(
        frequency: 4,
        volume: 30,
      );

      final state = container.read(goalSetupProvider);
      expect(state.trainingFrequency, 4);
      expect(state.currentWeeklyVolume, 30);
    });

    test('setPillarPriorities should update priorities', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setPillarPriorities(
        running: 'High',
        strength: 'Medium',
        mobility: 'Low',
      );

      final state = container.read(goalSetupProvider);
      expect(state.runningPriority, 'High');
      expect(state.strengthPriority, 'Medium');
      expect(state.mobilityPriority, 'Low');
    });

    test('setPillarPriorities should handle nullable updates', () {
      final notifier = container.read(goalSetupProvider.notifier);

      notifier.setPillarPriorities(running: 'Medium');

      final state = container.read(goalSetupProvider);
      expect(state.runningPriority, 'Medium');
      expect(state.strengthPriority, isNull);
      expect(state.mobilityPriority, isNull);
    });
  });
}
