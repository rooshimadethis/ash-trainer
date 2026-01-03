import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../shared/presentation/widgets/workout_card.dart';
import '../../../shared/domain/entities/training/training_block.dart';
import '../providers/calendar_provider.dart';
import 'package:ash_trainer/features/dashboard/presentation/widgets/recovery_widget.dart';
import 'package:intl/intl.dart';
import 'workout_detail_screen.dart';
import 'package:ash_trainer/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:ash_trainer/features/dashboard/presentation/widgets/countdown_card.dart';

import 'package:ash_trainer/features/training/presentation/providers/automation_provider.dart';
import '../../../workout_logging/presentation/screens/workout_logging_screen.dart';
import '../../../shared/presentation/widgets/ash_chat_bubble.dart';
import '../../../shared/domain/services/health_service.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/animations.dart';
import '../../../shared/presentation/widgets/animated_entry.dart';
import '../widgets/workout_list_skeleton.dart';
import '../../../developer/presentation/providers/debug_providers.dart';
import '../../../shared/presentation/widgets/shimmer_widget.dart';
import '../../../../core/theme/borders.dart';
import 'package:ash_trainer/features/shared/presentation/providers/ash_status_provider.dart';

class TodayView extends ConsumerStatefulWidget {
  const TodayView({super.key});

  @override
  ConsumerState<TodayView> createState() => _TodayViewState();
}

class _TodayViewState extends ConsumerState<TodayView> {
  @override
  void initState() {
    super.initState();
    // Run automation check after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trainingAutomationProvider).checkAndReschedule();
    });
  }

  @override
  Widget build(BuildContext context) {
    final todayWorkoutAsync = ref.watch(todayWorkoutProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, MMM d').format(now);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (ref.watch(isAshThinkingProvider) ||
              ref.watch(debugShowShimmerSkeletonProvider))
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: AshChatBubble(text: "Thinking...", isThinking: true),
            ),
          Center(
            child: Column(
              children: [
                Text(
                  'TODAY',
                  style: AppTextStyles.label.copyWith(
                    letterSpacing: 2.5,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  dateStr,
                  style: AppTextStyles.h2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _checkInCard(),
          const SizedBox(height: 48),
          Row(
            children: [
              const Icon(Icons.directions_run_rounded,
                  color: AppColors.rose,
                  size: 20), // Rose for workout intensity
              const SizedBox(width: 8),
              Text('Workout', style: AppTextStyles.h4),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedSwitcher(
            duration: AppAnimations.normal,
            child: (ref.watch(debugShowShimmerSkeletonProvider) ||
                    ref.watch(isAshThinkingProvider))
                ? const WorkoutListSkeleton(
                    key: ValueKey('loading'),
                    cardCount: 1,
                  )
                : todayWorkoutAsync.when(
                    data: (workout) {
                      final block = ref.watch(todayBlockProvider).valueOrNull;
                      if (workout == null) {
                        return _restDayCard(block);
                      }
                      return AnimatedEntry(
                        key: ValueKey(
                            'today_workout_${workout.id}_${workout.status}'),
                        child: WorkoutCard(
                          workout: workout,
                          useWorkoutColor: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    WorkoutDetailScreen(workout: workout),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    loading: () => const WorkoutListSkeleton(
                      key: ValueKey('loading'),
                      cardCount: 1,
                    ),
                    error: (err, stack) => Text(
                      'Error loading workout: $err',
                      key: const ValueKey('error'),
                    ),
                  ),
          ),
          const SizedBox(height: 48),
          const RecoveryWidget(),
          const SizedBox(height: 48),
          Row(
            children: [
              const Icon(Icons.analytics_outlined,
                  color: AppColors.blue,
                  size: 20), // Blue for progress/analytics
              const SizedBox(width: 8),
              Text('Progress', style: AppTextStyles.h4),
            ],
          ),
          const SizedBox(height: 12),
          ref.watch(activeGoalProvider).when(
                data: (goal) {
                  if (goal == null || goal.targetDate == null) {
                    return const SizedBox.shrink();
                  }
                  return CountdownCard(
                    goalName: goal.name,
                    targetDate: goal.targetDate!,
                    createdAt: goal.createdAt,
                  );
                },
                loading: () => ShimmerWidget(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white10 : Colors.black12,
                      borderRadius: BorderRadius.circular(AppBorders.radiusLg),
                    ),
                  ),
                ),
                error: (_, __) => const SizedBox.shrink(),
              ),
          const SizedBox(height: 48),
          _detectedWorkoutsSection(ref),
        ],
      ),
    );
  }

  void _onMatchWorkout(
      BuildContext context, WidgetRef ref, ExternalWorkout extWorkout) async {
    final todayWorkout = await ref.read(todayWorkoutProvider.future);

    if (todayWorkout == null) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No planned workout to match against today.')));
      return;
    }

    if (!context.mounted) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Match Workout?'),
        content: Text(
            'Do you want to use data from your ${extWorkout.sourceName} workout for "${todayWorkout.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Match & Log'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      final filledWorkout = todayWorkout.copyWith(
        actualDuration: extWorkout.durationSeconds,
        actualDistance: extWorkout.distanceKm,
        syncedFrom: extWorkout.sourceName,
      );

      if (!context.mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutLoggingScreen(workout: filledWorkout),
        ),
      );
    }
  }

  Widget _detectedWorkoutsSection(WidgetRef ref) {
    final todayWorkout = ref.watch(todayWorkoutProvider).valueOrNull;

    if (todayWorkout != null && todayWorkout.status == 'completed') {
      return const SizedBox.shrink();
    }

    final externalWorkoutsAsync = ref.watch(todaysExternalWorkoutsProvider);

    return externalWorkoutsAsync.when(
      data: (workouts) {
        if (workouts.isEmpty) return const SizedBox.shrink();

        final validWorkouts =
            workouts.where((w) => w.durationSeconds > 300).toList();

        if (validWorkouts.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.watch_rounded,
                  color: Theme.of(ref.context).colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text('Detected Workouts', style: AppTextStyles.h4),
            ]),
            const SizedBox(height: 12),
            ...validWorkouts.asMap().entries.map((entry) {
              final index = entry.key;
              final w = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AnimatedEntry(
                  index: index,
                  child: AshCard(
                    onTap: () => _onMatchWorkout(ref.context, ref, w),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.2),
                              width: 1.5,
                            ),
                          ),
                          child: Icon(Icons.check_circle_outline,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(w.type, style: AppTextStyles.h4),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    '${(w.durationSeconds / 60).round()} min',
                                    style: AppTextStyles.bodySmall,
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outline
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      w.sourceName.toUpperCase(),
                                      style: AppTextStyles.labelSmall.copyWith(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.3)),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 32),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (e, s) => const SizedBox.shrink(),
    );
  }

  Widget _checkInCard() {
    final block = ref.watch(todayBlockProvider).valueOrNull;
    final intent = block?.intent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AshChatBubble(
          text: intent != null && intent.isNotEmpty
              ? intent
              : 'Good morning! Ready to tackle today? How are you feeling?',
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const SizedBox(width: 52), // Offset for Ash's avatar
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _moodChip('Good 👍'),
                  _moodChip('Tired 🥱'),
                  _moodChip('Sore 🤕'),
                  _moodChip('Sick 😷'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _moodChip(String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AshCard(
      onTap: () {},
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      backgroundColor: isDark ? AppColors.surface : AppColors.surfaceLight,
      borderColor: isDark ? AppColors.retroAccent : Colors.black,
      borderWidth: 1.5,
      child: Text(
        label,
        style: AppTextStyles.label.copyWith(
          color:
              isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _restDayCard(TrainingBlock? block) {
    // The intent is already shown in the check-in bubble at the top.
    // This card serves as a placeholder in the workout list to indicate Rest Day.
    return AshCard(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.spa_rounded,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Rest Day',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: 8),
            Text(
              'Active recovery & hydration',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
