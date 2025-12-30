import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/block_utils.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/workout_types.dart';
import '../../../shared/presentation/widgets/workout_card.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/entities/training/training_block.dart';
import '../providers/calendar_provider.dart';
import 'package:intl/intl.dart';

class MonthlyView extends ConsumerWidget {
  const MonthlyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyWorkoutsAsync = ref.watch(monthlyWorkoutsProvider);
    final monthlyBlocksAsync = ref.watch(monthlyBlocksProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startOfRange = today.subtract(Duration(days: today.weekday - 1 + 7));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat('MMMM yyyy').format(now),
                  style: AppTextStyles.h2),
              const Icon(Icons.calendar_month, color: AppColors.primary),
            ],
          ),
        ),
        SizedBox(
          height: 380, // Adjust height to fit 4 weeks
          child: monthlyWorkoutsAsync.when(
            data: (workouts) => monthlyBlocksAsync.when(
              data: (blocks) => _build4WeekGrid(
                  startOfRange, workouts, blocks, selectedDate, ref),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
        const Divider(color: Colors.white12, height: 32),
        Expanded(
          child: monthlyWorkoutsAsync.when(
            data: (workouts) => monthlyBlocksAsync.when(
              data: (blocks) =>
                  _buildWorkoutList(selectedDate, workouts, blocks),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
      ],
    );
  }

  Widget _build4WeekGrid(DateTime startOfRange, List<Workout> workouts,
      List<TrainingBlock> blocks, DateTime selectedDate, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, weekIndex) {
        final weekStart = startOfRange.add(Duration(days: weekIndex * 7));
        final weekEnd = weekStart.add(const Duration(days: 6));

        final weekWorkouts = workouts
            .where((w) =>
                w.scheduledDate
                    .isAfter(weekStart.subtract(const Duration(seconds: 1))) &&
                w.scheduledDate.isBefore(weekEnd.add(const Duration(days: 1))))
            .toList();

        return _WeekRow(
          weekStart: weekStart,
          workouts: weekWorkouts,
          blocks: blocks,
          selectedDate: selectedDate,
          ref: ref,
        );
      },
    );
  }

  Widget _buildWorkoutList(DateTime selectedDate, List<Workout> allWorkouts,
      List<TrainingBlock> blocks) {
    final dayWorkouts = allWorkouts
        .where((w) => DateUtils.isSameDay(w.scheduledDate, selectedDate))
        .toList();

    // Find block for selected date to show context
    final dayBlock = blocks.cast<TrainingBlock?>().firstWhere(
      (b) {
        if (b == null || b.startDate == null || b.endDate == null) return false;
        final start =
            DateTime(b.startDate!.year, b.startDate!.month, b.startDate!.day);
        final end = DateTime(b.endDate!.year, b.endDate!.month, b.endDate!.day)
            .add(const Duration(days: 1));
        final d =
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        return (d.isAtSameMomentAs(start) || d.isAfter(start)) &&
            d.isBefore(end);
      },
      orElse: () => null,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEEE, MMM d').format(selectedDate),
                style: AppTextStyles.h4.copyWith(color: AppColors.primary),
              ),
              if (dayBlock != null) ...[
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: BlockUtils.getColorForIntent(
                            dayBlock.intent, dayBlock.blockNumber)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: BlockUtils.getColorForIntent(
                              dayBlock.intent, dayBlock.blockNumber)
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    dayBlock.intent.toUpperCase(),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: BlockUtils.getColorForIntent(
                          dayBlock.intent, dayBlock.blockNumber),
                      fontSize: 10,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: dayWorkouts.isEmpty
              ? const Center(
                  child: Text('Rest Day',
                      style: TextStyle(color: AppColors.textSecondary)))
              : ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: dayWorkouts.length,
                  itemBuilder: (context, index) =>
                      WorkoutCard(workout: dayWorkouts[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                ),
        ),
      ],
    );
  }
}

class _WeekRow extends StatelessWidget {
  final DateTime weekStart;
  final List<Workout> workouts;
  final List<TrainingBlock> blocks;
  final DateTime selectedDate;
  final WidgetRef ref;

  const _WeekRow({
    required this.weekStart,
    required this.workouts,
    required this.blocks,
    required this.selectedDate,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          final day = weekStart.add(Duration(days: index));
          final dayWorkouts = workouts
              .where((w) => DateUtils.isSameDay(w.scheduledDate, day))
              .toList();
          final isSelected = DateUtils.isSameDay(day, selectedDate);
          final isToday = DateUtils.isSameDay(day, DateTime.now());

          // Find block for this day
          final dayBlock = blocks.cast<TrainingBlock?>().firstWhere(
            (b) {
              if (b == null || b.startDate == null || b.endDate == null) {
                return false;
              }
              final start = DateTime(
                  b.startDate!.year, b.startDate!.month, b.startDate!.day);
              final end =
                  DateTime(b.endDate!.year, b.endDate!.month, b.endDate!.day)
                      .add(const Duration(days: 1));
              final d = DateTime(day.year, day.month, day.day);
              return (d.isAtSameMomentAs(start) || d.isAfter(start)) &&
                  d.isBefore(end);
            },
            orElse: () => null,
          );

          final blockColor = BlockUtils.getColorForIntent(
              dayBlock?.intent, dayBlock?.blockNumber ?? 1);

          // Neutral Background Logic
          Color backgroundColor = AppColors.surfaceHighlight
              .withValues(alpha: 0.3); // Default for monthly
          if (isSelected) {
            backgroundColor = AppColors.white.withValues(alpha: 0.15);
          } else if (isToday) {
            backgroundColor = AppColors.white.withValues(alpha: 0.1);
          }

          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(selectedDateProvider.notifier).state = day,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 80,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected
                      ? Border.all(
                          color: AppColors.white.withValues(alpha: 0.5),
                          width: 1)
                      : Border.all(
                          color: AppColors.divider,
                          width: 1), // Default faint border
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('E').format(day).substring(0, 1),
                              style: AppTextStyles.labelSmall.copyWith(
                                color: isSelected || isToday
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                fontWeight: isSelected || isToday
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              day.day.toString(),
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isSelected || isToday
                                    ? AppColors.primary
                                    : Colors.white,
                                fontWeight: isSelected || isToday
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: dayWorkouts
                                  .take(3)
                                  .map((w) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        child: Icon(
                                          WorkoutTypes.getIcon(w.type),
                                          size: 10,
                                          color: WorkoutTypes.getColor(w.type),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      if (dayBlock != null)
                        Container(
                          height: 4,
                          color: blockColor,
                          width: double.infinity,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
