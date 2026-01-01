import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/utils/unit_converter.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../shared/presentation/providers/user_provider.dart';

class WorkoutSuccessScreen extends ConsumerStatefulWidget {
  final Workout workout;

  const WorkoutSuccessScreen({super.key, required this.workout});

  @override
  ConsumerState<WorkoutSuccessScreen> createState() =>
      _WorkoutSuccessScreenState();
}

class _WorkoutSuccessScreenState extends ConsumerState<WorkoutSuccessScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use workout-specific theme
    final workoutTheme = ref.watch(workoutThemeProvider(widget.workout));
    final preferredUnit = ref.watch(preferredDistanceUnitProvider);
    final workoutColor = workoutTheme.colorScheme.primary;

    final isRunning = widget.workout.type.contains('run');

    return Theme(
      data: workoutTheme,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            // Confetti
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 2, // down
                maxBlastForce: 5,
                minBlastForce: 2,
                emissionFrequency: 0.05,
                numberOfParticles: 50,
                gravity: 0.1,
                shouldLoop: false,
                colors: [
                  workoutColor,
                  workoutColor.withValues(alpha: 0.7),
                  Theme.of(context).primaryColor,
                  Colors.white,
                ],
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Spacer(),

                    // Celebration Icon
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: workoutColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: workoutColor.withValues(alpha: 0.2),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.check_circle_rounded,
                        size: 80,
                        color: workoutColor,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Victory Message
                    Text(
                      _getVictoryMessage(),
                      style: AppTextStyles.h1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Workout logged successfully.',
                      style: AppTextStyles.bodyMedium.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                    ),

                    const SizedBox(height: 48),

                    // Stats Summary Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.outline),
                      ),
                      child: Column(
                        children: [
                          _buildStatRow(
                            'DURATION',
                            '${(widget.workout.actualDuration ?? 0) ~/ 60}m',
                            widget.workout.plannedDuration ~/ 60 > 0
                                ? 'Goal: ${widget.workout.plannedDuration ~/ 60}m'
                                : null,
                            workoutColor,
                          ),
                          if (isRunning &&
                              widget.workout.actualDistance != null) ...[
                            const SizedBox(height: 24),
                            _buildStatRow(
                              'DISTANCE',
                              '${UnitConverter.convertDistanceFromKm(widget.workout.actualDistance!, preferredUnit).toStringAsFixed(2)} ${preferredUnit.toUpperCase()}',
                              widget.workout.plannedDistance != null
                                  ? 'Goal: ${UnitConverter.convertDistanceFromKm(widget.workout.plannedDistance!, preferredUnit).toStringAsFixed(2)}'
                                  : null,
                              workoutColor,
                            ),
                          ],
                          const SizedBox(height: 24),
                          _buildStatRow(
                            'EFFORT',
                            '${widget.workout.rpe}/10',
                            null,
                            workoutColor,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Ash Motivation
                    Text(
                      _getAshMotivation(),
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Spacer(),

                    AshButton(
                      label: 'Done',
                      onPressed: () {
                        // Pop all the way back to the main view
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
      String label, String value, String? subtext, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(letterSpacing: 1.2),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.h2.copyWith(color: accentColor),
        ),
        if (subtext != null) ...[
          const SizedBox(height: 2),
          Text(
            subtext,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ],
    );
  }

  String _getVictoryMessage() {
    final messages = [
      'Workout Crushed!',
      'Great Session!',
      'Consistency is Key!',
      'You Nailed It!',
      'Level Up!',
    ];
    return messages[Random().nextInt(messages.length)];
  }

  String _getAshMotivation() {
    final messages = [
      "\"Every drop of sweat is a deposit in the bank of success.\"",
      "\"The work you do today defines who you are tomorrow.\"",
      "\"Recovery is just as important as the effort. Rest well.\"",
      "\"That's how it's done. Keep showing up.\"",
      "\"Your future self is thanking you for this effort.\"",
    ];
    return messages[Random().nextInt(messages.length)];
  }
}
