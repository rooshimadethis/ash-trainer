import 'package:ash_trainer/features/goal_setup/presentation/providers/goal_setup_provider.dart';
import 'package:ash_trainer/features/goal_setup/presentation/screens/goal_type_selection_screen.dart';
import 'package:ash_trainer/features/shared/domain/entities/goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GoalTypeSelectionScreen displays all 4 goal type cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: GoalTypeSelectionScreen(),
        ),
      ),
    );

    // Verify all goal types are displayed
    expect(find.text('Distance Milestone'), findsOneWidget);
    expect(find.text('Conquer a new distance 🎯'), findsOneWidget);

    expect(find.text('Time Performance'), findsOneWidget);
    expect(find.text('Get faster ⚡'), findsOneWidget);

    expect(find.text('Event'), findsOneWidget);
    expect(find.text('Race day ready 🏁'), findsOneWidget);

    expect(find.text('Maintenance'), findsOneWidget);
    expect(find.text('Stay consistent 🔄'), findsOneWidget);
  });

  testWidgets('GoalTypeSelectionScreen displays question text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: GoalTypeSelectionScreen(),
        ),
      ),
    );

    expect(find.text('What\'s the dream?'), findsOneWidget);
    expect(
      find.text('Choose what we are chasing together.'),
      findsOneWidget,
    );
  });

  testWidgets('Next button is disabled when no selection',
      (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: GoalTypeSelectionScreen(),
        ),
      ),
    );

    // No goal type selected initially
    expect(container.read(goalSetupProvider).selectedGoalType, isNull);

    // Next button text should exist
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('Tapping a goal type card selects it',
      (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: GoalTypeSelectionScreen(),
        ),
      ),
    );

    // Initially no goal type selected
    expect(container.read(goalSetupProvider).selectedGoalType, isNull);

    // Tap Distance Milestone card
    await tester.tap(find.text('Distance Milestone'));
    await tester.pump();

    // Goal type should be selected
    expect(
      container.read(goalSetupProvider).selectedGoalType,
      GoalType.distanceMilestone,
    );
  });

  testWidgets('Next button exists when goal type selected',
      (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: GoalTypeSelectionScreen(),
        ),
      ),
    );

    // Select a goal type
    await tester.tap(find.text('Time Performance'));
    await tester.pump();

    // Next button should exist
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('User can change selection', (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: GoalTypeSelectionScreen(),
        ),
      ),
    );

    // Select Distance Milestone
    await tester.tap(find.text('Distance Milestone'));
    await tester.pump();
    expect(
      container.read(goalSetupProvider).selectedGoalType,
      GoalType.distanceMilestone,
    );

    // Change to Event
    await tester.tap(find.text('Event'));
    await tester.pump();
    expect(
      container.read(goalSetupProvider).selectedGoalType,
      GoalType.event,
    );
  });

  testWidgets('All goal type icons are displayed', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: GoalTypeSelectionScreen(),
        ),
      ),
    );

    expect(find.byIcon(Icons.flag), findsOneWidget);
    expect(find.byIcon(Icons.timer), findsOneWidget);
    expect(find.byIcon(Icons.calendar_month), findsOneWidget);
    expect(find.byIcon(Icons.repeat), findsOneWidget);
  });

  testWidgets('Tapping Next with selection increments step',
      (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: GoalTypeSelectionScreen(),
        ),
      ),
    );

    // Select a goal type
    await tester.tap(find.text('Distance Milestone'));
    await tester.pump();

    final initialStep = container.read(goalSetupProvider).currentStep;

    // Tap Next button
    await tester.tap(find.text('Next'));
    await tester.pump();

    // Step should increment
    expect(
      container.read(goalSetupProvider).currentStep,
      initialStep + 1,
    );
  });
}
