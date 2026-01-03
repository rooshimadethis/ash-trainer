import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/utils/logger.dart';

import '../../../../core/constants/workout_types.dart';
import '../../../../core/utils/unit_converter.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../workout_logging/presentation/screens/workout_logging_screen.dart';
import '../providers/calendar_provider.dart';
import '../../../../data/providers/repository_providers.dart';
import '../../../training/presentation/providers/automation_provider.dart';
import '../../../shared/presentation/providers/user_provider.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../shared/presentation/widgets/ash_chat_bubble.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  final Workout workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutAsync = ref.watch(workoutDetailProvider(workout.id));

    return workoutAsync.when(
      data: (liveWorkout) {
        if (liveWorkout == null) {
          return const Scaffold(body: Center(child: Text('Workout not found')));
        }
        return _buildContent(context, ref, liveWorkout);
      },
      loading: () => _buildContent(context, ref, workout),
      error: (e, st) => _buildContent(context, ref, workout),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, Workout workout) {
    final typeColor = WorkoutTypes.getColor(workout.type);
    final isCompleted = workout.status == 'completed';
    final isRunning = workout.type.contains('run');

    // Use workout-specific theme
    final workoutTheme = ref.watch(workoutThemeProvider(workout));
    // Get user's preferred distance unit
    final preferredUnit = ref.watch(preferredDistanceUnitProvider);

    return Theme(
      data: workoutTheme,
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onSurface),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Workout Detail',
              style: AppTextStyles.h3,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge & Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: typeColor,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: (typeColor.computeLuminance() > 0.45
                                    ? HSLColor.fromColor(typeColor)
                                        .withLightness(0.12)
                                        .toColor()
                                    : Colors.white)
                                .withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          WorkoutTypes.getDisplayName(workout.type)
                              .toUpperCase(),
                          style: AppTextStyles.labelLarge.copyWith(
                            color: typeColor.computeLuminance() > 0.45
                                ? HSLColor.fromColor(typeColor)
                                    .withLightness(0.12)
                                    .toColor()
                                : Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('EEEE, MMM d').format(workout.scheduledDate),
                        style: AppTextStyles.bodyMedium.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(workout.name,
                      style: AppTextStyles.h1.copyWith(
                          color: Theme.of(context).colorScheme.onSurface)),
                  const SizedBox(height: 12),

                  // Ash Description Bubble
                  AshChatBubble(
                    text: workout.description ??
                        'No description provided for this workout.',
                  ),

                  // Strength Exercises Section
                  if (workout.strengthExercises != null &&
                      workout.strengthExercises!.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    Text('STRENGTH ROUTINE',
                        style: (Theme.of(context).textTheme.labelLarge ??
                                const TextStyle())
                            .copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                          fontSize: 14,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w800,
                        )),
                    const SizedBox(height: 16),
                    ...workout.strengthExercises!.map((exercise) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AshCard(
                            padding: const EdgeInsets.all(16),
                            borderRadius: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name,
                                  style: AppTextStyles.h4.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    _buildExerciseDetail(
                                        context, '${exercise.sets} sets'),
                                    const SizedBox(width: 16),
                                    _buildExerciseDetail(
                                        context, '${exercise.reps} reps'),
                                    const SizedBox(width: 16),
                                    _buildExerciseDetail(
                                        context, 'RPE ${exercise.rpe}'),
                                  ],
                                ),
                                if (exercise.notes != null &&
                                    exercise.notes!.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    exercise.notes!,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        )),
                  ],

                  // Mobility Sequence Section
                  if (workout.mobilitySequence != null &&
                      workout.mobilitySequence!.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    Text('MOBILITY FLOW',
                        style: (Theme.of(context).textTheme.labelLarge ??
                                const TextStyle())
                            .copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                          fontSize: 14,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w800,
                        )),
                    const SizedBox(height: 16),
                    ...workout.mobilitySequence!.map((module) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AshCard(
                            padding: const EdgeInsets.all(16),
                            borderRadius: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        module.exerciseName,
                                        style: AppTextStyles.h4.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color:
                                            typeColor.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color:
                                              typeColor.withValues(alpha: 0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        module.targetJoint,
                                        style:
                                            AppTextStyles.labelSmall.copyWith(
                                          color: typeColor.computeLuminance() >
                                                  0.5
                                              ? HSLColor.fromColor(typeColor)
                                                  .withLightness(0.2)
                                                  .toColor()
                                              : typeColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Setup: ${module.setupInstructions}',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${module.totalCycles} cycles',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ...module.phases.map((phase) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            margin: const EdgeInsets.only(
                                                top: 6, right: 8),
                                            decoration: BoxDecoration(
                                              color: typeColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      phase.phaseType
                                                          .toUpperCase(),
                                                      style: AppTextStyles
                                                          .labelSmall
                                                          .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        letterSpacing: 1.0,
                                                      ),
                                                    ),
                                                    if (phase.durationSeconds !=
                                                        null) ...[
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        '${phase.durationSeconds}s',
                                                        style: AppTextStyles
                                                            .bodySmall
                                                            .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onSurfaceVariant,
                                                        ),
                                                      ),
                                                    ],
                                                    if (phase.irradiationPct !=
                                                        null) ...[
                                                      const SizedBox(width: 8),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 6,
                                                                vertical: 2),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: typeColor
                                                              .withValues(
                                                                  alpha: 0.15),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: Text(
                                                          '${phase.irradiationPct}% tension',
                                                          style: AppTextStyles
                                                              .labelSmall
                                                              .copyWith(
                                                            color: typeColor,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                                if (phase.instruction !=
                                                    null) ...[
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    phase.instruction!,
                                                    style: AppTextStyles
                                                        .bodySmall
                                                        .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant,
                                                    ),
                                                  ),
                                                ],
                                                if (phase.intensityNotes !=
                                                    null) ...[
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    '💡 ${phase.intensityNotes}',
                                                    style: AppTextStyles
                                                        .bodySmall
                                                        .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurfaceVariant,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        )),
                  ],

                  const SizedBox(height: 32),

                  // Planned Metrics Section
                  Text('PLANNED TARGETS',
                      style: (Theme.of(context).textTheme.labelLarge ??
                              const TextStyle())
                          .copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.6),
                        fontSize: 14,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w800,
                      )),
                  const SizedBox(height: 16),
                  _buildStatsDashboard(
                      context, workout, isRunning, preferredUnit),

                  const SizedBox(height: 32),

                  // Completion Status
                  if (workout.status == 'completed') ...[
                    Text('ACTUAL PERFORMANCE',
                        style: (Theme.of(context).textTheme.labelLarge ??
                                const TextStyle())
                            .copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                          fontSize: 14,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w800,
                        )),
                    const SizedBox(height: 16),
                    _buildStatsDashboard(
                        context, workout, isRunning, preferredUnit,
                        isActual: true),
                  ] else if (workout.status == 'skipped') ...[
                    Text('STATUS',
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .error
                            .withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .error
                                .withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.block, color: Colors.red),
                          const SizedBox(width: 12),
                          Text(
                            'Workout Skipped',
                            style: AppTextStyles.h4.copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (workout.status == 'skipped')
                    AshButton(
                      label: 'Unskip',
                      variant: AshButtonVariant.secondary,
                      onPressed: () => _unskipWorkout(context, ref, workout),
                    )
                  else if (!isCompleted)
                    AshButton(
                      label: 'Log Workout',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WorkoutLoggingScreen(workout: workout),
                          ),
                        );
                      },
                    )
                  else if (isCompleted)
                    AshButton(
                      label: 'Undo Log',
                      variant: AshButtonVariant.secondary,
                      onPressed: () =>
                          _showUndoConfirmation(context, ref, workout),
                    )
                  else
                    AshButton(
                      label: 'Start Workout',
                      onPressed: null, // Only enabled for today in future
                    ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AshButton(
                          label: 'Adjust',
                          variant: AshButtonVariant.secondary,
                          onPressed: null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AshButton(
                          label: 'Skip',
                          variant: AshButtonVariant.secondary,
                          onPressed: () => _skipWorkout(context, ref, workout),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showUndoConfirmation(
      BuildContext context, WidgetRef ref, Workout workout) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text('Undo Completion?',
            style: AppTextStyles.h3
                .copyWith(color: Theme.of(context).colorScheme.onSurface)),
        content: Text(
          'This will remove your actual stats and mark the workout as incomplete.',
          style: AppTextStyles.bodyMedium
              .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: AppTextStyles.buttonText
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref
                  .read(workoutRepositoryProvider)
                  .unlogWorkout(workout.id);
            },
            child: Text('Undo',
                style: AppTextStyles.buttonText
                    .copyWith(color: Theme.of(context).colorScheme.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsDashboard(BuildContext context, Workout workout,
      bool isRunning, String preferredUnit,
      {bool isActual = false}) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    final primary = theme.colorScheme.primary;

    // Determine if we need to adjust primary for contrast
    final surfaceLuminance = theme.scaffoldBackgroundColor.computeLuminance();
    final primaryLuminance = primary.computeLuminance();

    // If primary has poor contrast against surface, use onSurface for values
    final valueColor =
        (primaryLuminance - surfaceLuminance).abs() > 0.3 ? primary : onSurface;

    // Prepare the stats list
    final stats = <_StatItem>[];

    if (isActual) {
      stats.add(_StatItem(
          'Actual Time', _formatDuration(workout.actualDuration ?? 0)));
      if (workout.actualDistance != null && workout.actualDistance! > 0) {
        stats.add(_StatItem(
            'Actual Distance',
            UnitConverter.formatDistance(
                UnitConverter.convertDistanceFromKm(
                    workout.actualDistance!, preferredUnit),
                preferredUnit)));
      }
      if (workout.rpe != null) {
        stats.add(_StatItem('Final Effort', 'RPE ${workout.rpe}'));
      }
    } else {
      stats
          .add(_StatItem('Duration', _formatDuration(workout.plannedDuration)));
      if (workout.plannedDistance != null && workout.plannedDistance! > 0) {
        stats.add(_StatItem(
            'Distance',
            UnitConverter.formatDistance(
                UnitConverter.convertDistanceFromKm(
                    workout.plannedDistance!, preferredUnit),
                preferredUnit)));
      }
      if (workout.intensity != null) {
        stats.add(_StatItem('Intensity', 'RPE ${workout.intensity}'));
      }
      if (isRunning &&
          workout.plannedDistance != null &&
          workout.plannedDistance! > 0) {
        stats.add(_StatItem(
            'Avg Pace',
            _formatPaceForWorkout(workout.plannedDuration,
                workout.plannedDistance!, preferredUnit)));
      }
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.0,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final item = stats[index];
        return AshCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          borderRadius: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.label.toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTextStyles.labelSmall.copyWith(
                  color: onSurface.withValues(alpha: 0.5),
                  fontSize: 11,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  item.value,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2.copyWith(
                    color: valueColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _skipWorkout(
      BuildContext context, WidgetRef ref, Workout workout) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text('Skip Workout?',
            style: AppTextStyles.h3
                .copyWith(color: Theme.of(context).colorScheme.onSurface)),
        content: Text(
          'This will mark the workout as skipped.',
          style: AppTextStyles.bodyMedium
              .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel',
                style: AppTextStyles.buttonText
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Skip',
                style: AppTextStyles.buttonText
                    .copyWith(color: Theme.of(context).colorScheme.error)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // Optimistic update / fast return
    if (context.mounted) Navigator.pop(context);

    try {
      final skippedWorkout = workout.copyWith(status: 'skipped');
      await ref.read(workoutRepositoryProvider).saveWorkout(skippedWorkout);

      AppLogger.d('DEBUG: Workout skipped. Triggering rescheduling check...');
      await ref.read(trainingAutomationProvider).onWorkoutAction();
      AppLogger.d('DEBUG: Rescheduling check complete.');
    } catch (e) {
      AppLogger.e('DEBUG: Error skipping workout', error: e);
    }
  }

  Future<void> _unskipWorkout(
      BuildContext context, WidgetRef ref, Workout workout) async {
    // Optimistic update / fast return
    Navigator.pop(context);

    try {
      final plannedWorkout = workout.copyWith(status: 'planned');
      await ref.read(workoutRepositoryProvider).saveWorkout(plannedWorkout);
      AppLogger.d('DEBUG: Workout unskipped (reverted to planned).');
    } catch (e) {
      AppLogger.e('DEBUG: Error unskipping workout', error: e);
    }
  }

  String _formatPaceForWorkout(
      int durationSeconds, double distanceKm, String preferredUnit) {
    // Convert distance to user's preferred unit
    final distance =
        UnitConverter.convertDistanceFromKm(distanceKm, preferredUnit);
    // Calculate pace in seconds per unit
    final paceSeconds = UnitConverter.calculatePace(durationSeconds, distance);
    // Format for display
    return UnitConverter.formatPace(paceSeconds, preferredUnit);
  }

  Widget _buildExerciseDetail(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _StatItem {
  final String label;
  final String value;
  _StatItem(this.label, this.value);
}
