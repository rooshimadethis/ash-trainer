import 'package:ash_trainer/features/goal_setup/presentation/screens/goal_type_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/repository_providers.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/dashboard/presentation/screens/home_screen.dart';

enum StartupState {
  noUser,
  noActiveGoal,
  ready,
}

/// Startup router that checks for existing user data and routes accordingly
class StartupRouter extends ConsumerWidget {
  const StartupRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRepo = ref.watch(userRepositoryProvider);
    final goalRepo = ref.watch(goalRepositoryProvider);

    return FutureBuilder<StartupState>(
      future: _getStartupState(userRepo, goalRepo),
      builder: (context, snapshot) {
        // Show loading while checking
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final state = snapshot.data ?? StartupState.noUser;

        // ignore: avoid_print
        print('📍 Startup routing: state=$state');

        switch (state) {
          case StartupState.noUser:
            return const WelcomeScreen();
          case StartupState.noActiveGoal:
            return const GoalTypeSelectionScreen();
          case StartupState.ready:
            return const HomeScreen();
        }
      },
    );
  }

  Future<StartupState> _getStartupState(userRepo, goalRepo) async {
    try {
      final user = await userRepo.getCurrentUser();
      if (user == null) return StartupState.noUser;

      final activeGoal = await goalRepo.getActiveGoal();
      if (activeGoal == null) return StartupState.noActiveGoal;

      return StartupState.ready;
    } catch (e) {
      // ignore: avoid_print
      print('⚠️ Error checking startup state: $e');
      return StartupState.noUser;
    }
  }
}
