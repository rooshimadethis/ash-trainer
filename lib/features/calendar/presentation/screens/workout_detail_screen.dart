import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../../core/theme/text_styles.dart';
import 'package:ash_trainer/core/theme/shadows.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/constants/workout_types.dart';
import '../../../../core/utils/unit_converter.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../workout_logging/presentation/screens/workout_logging_screen.dart';
import '../providers/calendar_provider.dart';
import '../../../../data/providers/repository_providers.dart';
import '../../../training/presentation/providers/automation_provider.dart';
import '../../../shared/presentation/providers/user_provider.dart';

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
    final isToday = _isToday(workout.scheduledDate);
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
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Text(
                          WorkoutTypes.getDisplayName(workout.type)
                              .toUpperCase(),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
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

                  // Title & Description
                  Text(workout.name, style: AppTextStyles.h1),
                  const SizedBox(height: 12),
                  Text(
                    workout.description ??
                        'No description provided for this workout.',
                    style: AppTextStyles.bodyLarge.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),

                  const SizedBox(height: 32),

                  // Planned Metrics Section
                  Text('PLANNED TARGETS',
                      style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFFFF4D8C)
                            : Colors.black,
                        width: 2.0,
                      ),
                      boxShadow: Theme.of(context).brightness == Brightness.dark
                          ? AppShadows.retroDark
                          : AppShadows.retro,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 32,
                          runSpacing: 16,
                          children: [
                            _metricItem(
                                context,
                                Icons.timer_outlined,
                                _formatDuration(workout.plannedDuration),
                                'Duration'),
                            if (workout.plannedDistance != null &&
                                workout.plannedDistance! > 0)
                              _metricItem(
                                  context,
                                  Icons.straighten_outlined,
                                  UnitConverter.formatDistance(
                                      UnitConverter.convertDistanceFromKm(
                                          workout.plannedDistance!,
                                          preferredUnit),
                                      preferredUnit),
                                  'Distance'),
                            if (workout.intensity != null)
                              _metricItem(context, Icons.speed_outlined,
                                  'RPE ${workout.intensity}', 'Intensity'),
                          ],
                        ),
                        // Show pace for running workouts with distance
                        if (isRunning &&
                            workout.plannedDistance != null &&
                            workout.plannedDistance! > 0) ...[
                          const SizedBox(height: 12),
                          const Divider(),
                          _metricItem(
                            context,
                            Icons.speed,
                            _formatPaceForWorkout(workout.plannedDuration,
                                workout.plannedDistance!, preferredUnit),
                            'Avg Pace',
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Completion Status
                  if (isCompleted) ...[
                    Text('COMPLETED ACTUALS',
                        style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFFFF4D8C)
                              : Colors.black,
                          width: 2.0,
                        ),
                        boxShadow:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppShadows.retroDark
                                : AppShadows.retro,
                      ),
                      child: Wrap(
                        spacing: 32,
                        runSpacing: 16,
                        children: [
                          _metricItem(
                              context,
                              Icons.check_circle_outline,
                              _formatDuration(workout.actualDuration ?? 0),
                              'Actual Time'),
                          if (workout.actualDistance != null &&
                              workout.actualDistance! > 0)
                            _metricItem(
                                context,
                                Icons.straighten_outlined,
                                UnitConverter.formatDistance(
                                    UnitConverter.convertDistanceFromKm(
                                        workout.actualDistance!, preferredUnit),
                                    preferredUnit),
                                'Actual Distance'),
                          if (workout.rpe != null)
                            _metricItem(context, Icons.psychology_outlined,
                                'RPE ${workout.rpe}', 'Effort'),
                        ],
                      ),
                    ),
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

  Widget _metricItem(
      BuildContext context, IconData icon, String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 4),
            Text(label,
                style: AppTextStyles.labelSmall.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.h4),
      ],
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

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
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

      print('DEBUG: Workout skipped. Triggering rescheduling check...');
      await ref.read(trainingAutomationProvider).onWorkoutAction();
      print('DEBUG: Rescheduling check complete.');
    } catch (e) {
      print('DEBUG: Error skipping workout: $e');
    }
  }

  Future<void> _unskipWorkout(
      BuildContext context, WidgetRef ref, Workout workout) async {
    // Optimistic update / fast return
    Navigator.pop(context);

    try {
      final plannedWorkout = workout.copyWith(status: 'planned');
      await ref.read(workoutRepositoryProvider).saveWorkout(plannedWorkout);
      print('DEBUG: Workout unskipped (reverted to planned).');
    } catch (e) {
      print('DEBUG: Error unskipping workout: $e');
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
}
