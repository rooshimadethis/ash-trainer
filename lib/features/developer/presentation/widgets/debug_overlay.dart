import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ash_trainer/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:ash_trainer/features/goal_setup/presentation/screens/goal_type_selection_screen.dart';
import '../screens/ai_test_screen.dart';
import 'package:ash_trainer/infrastructure/providers/service_providers.dart';
import 'package:ash_trainer/data/providers/repository_providers.dart';

class DebugOverlay extends StatelessWidget {
  final Widget child;

  const DebugOverlay({
    super.key,
    required this.child,
  });

  /// Shows the debug menu dialog with options to navigate to AI test screens
  /// and clear the database.
  static void showDebugMenu(
      BuildContext context, GlobalKey<NavigatorState> navigatorKey) {
    void navigateToTestHub(int index) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => AITestScreen(initialIndex: index),
        ),
      );
    }

    Future<void> clearDatabase(BuildContext context, WidgetRef ref) async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Clear Database?'),
          content: const Text(
            'This will delete all user data, goals, and workouts. '
            'The app will restart.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Clear All Data'),
            ),
          ],
        ),
      );

      if (confirmed != true) return;

      try {
        final db = ref.read(driftDatabaseProvider);

        // Delete all data from all tables
        await db.transaction(() async {
          await db.delete(db.workouts).go();
          await db.delete(db.trainingBlocks).go();
          await db.delete(db.phases).go();
          await db.delete(db.conversationMessages).go();
          await db.delete(db.conversations).go();
          await db.delete(db.mediumTermContext).go();
          await db.delete(db.longTermContext).go();
          await db.delete(db.goals).go();
          await db.delete(db.users).go();
        });

        // ignore: avoid_print
        print('🗑️ Database cleared successfully');

        // Navigate to welcome screen using root navigator
        if (context.mounted) {
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
            (route) => false,
          );
        }
      } catch (e) {
        // ignore: avoid_print
        print('❌ Error clearing database: $e');

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error clearing database: $e')),
          );
        }
      }
    }

    Future<void> createNewGoal(BuildContext context, WidgetRef ref,
        GlobalKey<NavigatorState> navigatorKey) async {
      // Read repositories BEFORE showing dialog to avoid disposal issues
      final goalRepository = ref.read(goalRepositoryProvider);
      final workoutRepository = ref.read(workoutRepositoryProvider);
      final db = ref.read(driftDatabaseProvider);

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Create New Goal?'),
          content: const Text(
            'This will delete your current goal and all associated workouts. '
            'You will be guided through creating a new goal.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.orange),
              child: const Text('Create New Goal'),
            ),
          ],
        ),
      );

      if (confirmed != true) return;

      try {
        // Get the active goal
        final activeGoal = await goalRepository.getActiveGoal();

        if (activeGoal == null) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No active goal found')),
            );
          }
          return;
        }

        // Delete goal and associated workouts in a transaction
        await db.transaction(() async {
          // Delete all workouts for this goal first
          await workoutRepository.deleteWorkoutsForGoal(activeGoal.id);

          // Delete the goal
          await goalRepository.deleteGoal(activeGoal.id);
        });

        // ignore: avoid_print
        print('🗑️ Goal and workouts deleted successfully');

        // Navigate to goal setup flow using root navigator
        if (context.mounted) {
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const GoalTypeSelectionScreen()),
            (route) => false,
          );
        }
      } catch (e) {
        // ignore: avoid_print
        print('❌ Error creating new goal: $e');

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating new goal: $e')),
          );
        }
      }
    }

    showDialog(
      context: context,
      builder: (dialogContext) => Consumer(
        builder: (consumerContext, ref, _) => AlertDialog(
          title: const Text('Debug Menu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text('AI: Plan Generator'),
                onTap: () {
                  Navigator.pop(dialogContext);
                  navigateToTestHub(0);
                },
              ),
              ListTile(
                leading: const Icon(Icons.tune),
                title: const Text('AI: Adjuster'),
                onTap: () {
                  Navigator.pop(dialogContext);
                  navigateToTestHub(1);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_calendar),
                title: const Text('AI: Rescheduler'),
                onTap: () {
                  Navigator.pop(dialogContext);
                  navigateToTestHub(2);
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat),
                title: const Text('AI: Chat'),
                onTap: () {
                  Navigator.pop(dialogContext);
                  navigateToTestHub(3);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.flag, color: Colors.blue),
                title: const Text('Create New Goal'),
                textColor: Colors.blue,
                onTap: () {
                  // Close the debug menu first
                  Navigator.pop(dialogContext);
                  // Then call createNewGoal with the captured ref and navigatorKey
                  createNewGoal(consumerContext, ref, navigatorKey);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.orange),
                title: const Text('Clear Database'),
                textColor: Colors.orange,
                onTap: () {
                  // Close the debug menu first
                  Navigator.pop(dialogContext);
                  // Then call clearDatabase with the captured ref
                  clearDatabase(consumerContext, ref);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
