import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/entities/training/training_block.dart';
import '../../../shared/presentation/widgets/workout_card.dart';
import '../screens/workout_detail_screen.dart';

/// Displays the workout list for a selected day, including training block info.
///
/// This widget is shared between WeeklyView and MonthlyView to ensure
/// consistent presentation of daily workout details.
class SelectedDayWorkoutList extends StatelessWidget {
  final DateTime selectedDate;
  final List<Workout> allWorkouts;
  final List<TrainingBlock> blocks;

  const SelectedDayWorkoutList({
    super.key,
    required this.selectedDate,
    required this.allWorkouts,
    required this.blocks,
  });

  @override
  Widget build(BuildContext context) {
    final dayWorkouts = allWorkouts
        .where((w) => DateUtils.isSameDay(w.scheduledDate, selectedDate))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const SizedBox(height: 24),
        dayWorkouts.isEmpty
            ? _buildEmptyState()
            : _buildWorkoutCards(context, dayWorkouts),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          DateFormat('EEEE, MMM d').format(selectedDate),
          style: AppTextStyles.h3,
        ),
        if (DateUtils.isSameDay(selectedDate, DateTime.now())) ...[
          const SizedBox(width: 8),
          Text(
            '• Today',
            style: AppTextStyles.label.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.nightlight_round,
              size: 48,
              color: AppColors.textMuted.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No workouts scheduled',
              style:
                  AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCards(BuildContext context, List<Workout> workouts) {
    return Column(
      children: List.generate(workouts.length, (index) {
        final workout = workouts[index];
        return Padding(
          padding:
              EdgeInsets.only(bottom: index == workouts.length - 1 ? 0 : 16),
          child: WorkoutCard(
            workout: workout,
            useWorkoutColor: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutDetailScreen(workout: workout),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
