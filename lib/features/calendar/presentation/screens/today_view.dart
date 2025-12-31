import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../shared/presentation/widgets/ash_glass_card.dart';
import '../../../shared/presentation/widgets/workout_card.dart';
import '../providers/calendar_provider.dart';
import 'package:ash_trainer/features/dashboard/presentation/widgets/recovery_widget.dart';
import 'package:intl/intl.dart';
import 'workout_detail_screen.dart';
import 'package:ash_trainer/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:ash_trainer/features/dashboard/presentation/widgets/countdown_card.dart';

import 'package:ash_trainer/features/training/presentation/providers/automation_provider.dart';

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
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, MMM d').format(now);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TODAY',
                      style: AppTextStyles.label.copyWith(
                        letterSpacing: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateStr,
                      style: AppTextStyles.h2,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceLighter,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                ),
                child: const IconButton(
                  onPressed: null, // Open profile or settings
                  icon: Icon(Icons.person_outline_rounded,
                      color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _checkInCard(),
          const SizedBox(height: 32),
          Text('Workout', style: AppTextStyles.h3),
          const SizedBox(height: 12),
          todayWorkoutAsync.when(
            data: (workout) {
              if (workout == null) {
                return _restDayCard();
              }
              return WorkoutCard(
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
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error loading workout: $err'),
          ),
          const SizedBox(height: 32),
          const RecoveryWidget(),
          const SizedBox(height: 32),
          Text('Progress', style: AppTextStyles.h3),
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
                loading: () => const SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, __) => const SizedBox.shrink(),
              ),
        ],
      ),
    );
  }

  Widget _checkInCard() {
    return AshGlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.wb_sunny_rounded,
                  color: AppColors.warning, size: 20),
              const SizedBox(width: 10),
              Text(
                'Good morning!',
                style: AppTextStyles.h4,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Ready to tackle today? How are you feeling?',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Quick Check-In'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _restDayCard() {
    return AshCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.mobility.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.self_improvement_rounded,
              size: 28,
              color: AppColors.mobility,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rest Day', style: AppTextStyles.h3),
                const SizedBox(height: 4),
                Text(
                  'Listen to your body. Focus on mobility and hydration.',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
