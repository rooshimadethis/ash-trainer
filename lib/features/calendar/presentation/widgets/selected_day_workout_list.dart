import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/block_utils.dart';
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

    final dayBlock = _findBlockForDate(selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        if (dayBlock != null) ...[
          const SizedBox(height: 16),
          _buildTrainingBlockCard(context, dayBlock),
        ],
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

  Widget _buildTrainingBlockCard(BuildContext context, TrainingBlock block) {
    final blockColor =
        BlockUtils.getColorForIntent(block.intent, block.blockNumber);

    return Container(
      decoration: BoxDecoration(
        // Bold full color background
        color: blockColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.15),
          width: 1.5,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Decorative icon in corner
          Positioned(
            right: -15,
            bottom: -15,
            child: Icon(
              Icons.layers_rounded,
              size: 80,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pill tag - white outline style
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.layers_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'TRAINING BLOCK',
                        style: AppTextStyles.label.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _toSentenceCase(block.intent),
                  style: AppTextStyles.h4.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  TrainingBlock? _findBlockForDate(DateTime date) {
    return blocks.cast<TrainingBlock?>().firstWhere(
      (b) {
        if (b == null || b.startDate == null || b.endDate == null) {
          return false;
        }
        final start =
            DateTime(b.startDate!.year, b.startDate!.month, b.startDate!.day);
        final end = DateTime(b.endDate!.year, b.endDate!.month, b.endDate!.day)
            .add(const Duration(days: 1));
        final d = DateTime(date.year, date.month, date.day);
        return (d.isAtSameMomentAs(start) || d.isAfter(start)) &&
            d.isBefore(end);
      },
      orElse: () => null,
    );
  }

  /// Converts text to sentence case (first letter uppercase, rest lowercase)
  String _toSentenceCase(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
