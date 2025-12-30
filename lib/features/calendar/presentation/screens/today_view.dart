import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../shared/presentation/widgets/workout_card.dart';
import '../providers/calendar_provider.dart';
import '../widgets/recovery_widget.dart';
import 'package:intl/intl.dart';

class TodayView extends ConsumerWidget {
  const TodayView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayWorkoutAsync = ref.watch(todayWorkoutProvider);
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, MMM d').format(now);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateStr,
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 24),

          // Check-In Card (Mocked)
          _mockCheckInCard(),
          const SizedBox(height: 16),

          Text('Today\'s Workout', style: AppTextStyles.h4),
          const SizedBox(height: 8),
          todayWorkoutAsync.when(
            data: (workout) {
              if (workout == null) {
                return _restDayCard();
              }
              return WorkoutCard(workout: workout);
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error loading workout: $err'),
          ),

          const SizedBox(height: 24),
          const RecoveryWidget(),
          const SizedBox(height: 24),

          // Goal Progress Widget (Mocked)
          _mockGoalProgressWidget(),
        ],
      ),
    );
  }

  Widget _mockCheckInCard() {
    return AshCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good morning! How are you feeling today?',
            style:
                AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Quick Check-In'),
          ),
        ],
      ),
    );
  }

  Widget _mockGoalProgressWidget() {
    return AshCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Goal Progress', style: AppTextStyles.h4),
              Text('85%',
                  style: AppTextStyles.h4.copyWith(color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 8),
          const LinearProgressIndicator(
            value: 0.85,
            backgroundColor: AppColors.divider,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          const SizedBox(height: 12),
          Text(
            'Training for: Madison Marathon',
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _restDayCard() {
    return AshCard(
      child: Row(
        children: [
          const Icon(Icons.self_improvement,
              size: 48, color: AppColors.textSecondary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rest Day 🧘', style: AppTextStyles.h3),
                const SizedBox(height: 4),
                Text(
                  'Enjoy your recovery and focus on mobility.',
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
