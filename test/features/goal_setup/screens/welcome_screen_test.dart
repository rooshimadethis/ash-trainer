import 'package:ash_trainer/features/goal_setup/presentation/providers/goal_setup_provider.dart';
import 'package:ash_trainer/features/goal_setup/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('WelcomeScreen displays welcome message and branding',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: WelcomeScreen(),
        ),
      ),
    );

    // Verify welcome message
    expect(
      find.text('Hey there! I\'m Ash, your AI running coach 👋'),
      findsOneWidget,
    );

    // Verify value propositions
    expect(
      find.text('Personalized training plans that adapt to YOU'),
      findsOneWidget,
    );
    expect(
      find.text('Smart coaching that learns from every run'),
      findsOneWidget,
    );
    expect(
      find.text('Your goals, your schedule, your pace'),
      findsOneWidget,
    );
  });

  testWidgets('WelcomeScreen displays "Let\'s do this!" button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: WelcomeScreen(),
        ),
      ),
    );

    expect(find.text('Let\'s do this!'), findsOneWidget);
  });

  testWidgets('Tapping button increments step', (WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: WelcomeScreen(),
        ),
      ),
    );

    // Initial step should be 1
    expect(container.read(goalSetupProvider).currentStep, 1);

    // Tap the button
    await tester.tap(find.text('Let\'s do this!'));
    await tester.pump();

    // Step should be incremented
    expect(container.read(goalSetupProvider).currentStep, 2);
  });

  testWidgets('WelcomeScreen displays value prop icons',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: WelcomeScreen(),
        ),
      ),
    );

    // Verify icons are present
    expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
    expect(find.byIcon(Icons.school), findsOneWidget);
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
  });
}
