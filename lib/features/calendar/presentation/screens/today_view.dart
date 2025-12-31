import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../shared/presentation/widgets/ash_glass_card.dart';
import '../../../shared/presentation/widgets/workout_card.dart';
import '../providers/calendar_provider.dart';
import '../widgets/recovery_widget.dart';
import 'package:intl/intl.dart';
import 'workout_detail_screen.dart';

class TodayView extends ConsumerWidget {
  const TodayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      style: AppTextStyles.label.copyWith(letterSpacing: 2),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Workout', style: AppTextStyles.h3),
              Text(
                'Plan: Madison Marathon',
                style: AppTextStyles.labelSmall
                    .copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
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
          _goalProgressWidget(),
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
            'Ready to tackle today\'s easy run? How are you feeling?',
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

  Widget _goalProgressWidget() {
    return AshCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '85% OF PHASE COMPLETE',
                style: AppTextStyles.labelSmall.copyWith(letterSpacing: 1),
              ),
              Text(
                '12 workouts to Peak',
                style:
                    AppTextStyles.labelSmall.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.85,
              minHeight: 12,
              backgroundColor: AppColors.surfaceLighter,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.flag_rounded, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 8),
              Text(
                'Milestone: First 20km run in 3 days',
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
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
