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

class WeeklyView extends ConsumerWidget {
  const WeeklyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startOfWeek = ref.watch(selectedWeekProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final weeklyWorkoutsAsync = ref.watch(weeklyWorkoutsProvider);
    final weeklyBlocksAsync = ref.watch(weeklyBlocksProvider);

    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final weekRangeStr =
        '${DateFormat('MMM d').format(startOfWeek)} - ${DateFormat('MMM d').format(endOfWeek)}';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: AppColors.primary),
                onPressed: () => ref.read(selectedWeekProvider.notifier).state =
                    startOfWeek.subtract(const Duration(days: 7)),
              ),
              Text(weekRangeStr, style: AppTextStyles.h4),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: AppColors.primary),
                onPressed: () => ref.read(selectedWeekProvider.notifier).state =
                    startOfWeek.add(const Duration(days: 7)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120, // Height for the day columns
          child: weeklyWorkoutsAsync.when(
            data: (workouts) => weeklyBlocksAsync.when(
              data: (blocks) =>
                  _buildWeekGrid(startOfWeek, workouts, blocks, selectedDate),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error details: $err')),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
        const Divider(color: Colors.white12, height: 32),
        Expanded(
          child: weeklyWorkoutsAsync.when(
            data: (workouts) => weeklyBlocksAsync.when(
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

  Widget _buildWeekGrid(DateTime startOfWeek, List<Workout> workouts,
      List<TrainingBlock> blocks, DateTime selectedDate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(7, (index) {
          final day = startOfWeek.add(Duration(days: index));
          final dayWorkouts = workouts
              .where((w) =>
                  w.scheduledDate.year == day.year &&
                  w.scheduledDate.month == day.month &&
                  w.scheduledDate.day == day.day)
              .toList();

          // Find block for this day
          final dayBlock = blocks.cast<TrainingBlock?>().firstWhere(
            (b) {
              if (b == null || b.startDate == null || b.endDate == null) {
                return false;
              }
              // Check if day is within start/end (inclusive)
              // Normalize dates to remove time for comparison
              final start = DateTime(
                  b.startDate!.year, b.startDate!.month, b.startDate!.day);
              final end = DateTime(
                      b.endDate!.year, b.endDate!.month, b.endDate!.day)
                  .add(const Duration(days: 1)); // exclusive end for comparison
              final d = DateTime(day.year, day.month, day.day);
              return (d.isAtSameMomentAs(start) || d.isAfter(start)) &&
                  d.isBefore(end);
            },
            orElse: () => null,
          );

          return Expanded(
            child: _DayColumn(
              day: day,
              workouts: dayWorkouts,
              block: dayBlock,
              isSelected: DateUtils.isSameDay(day, selectedDate),
            ),
          );
        }),
      ),
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
        if (b == null || b.startDate == null || b.endDate == null) {
          return false;
        }
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
                  padding: const EdgeInsets.all(16),
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

class _DayColumn extends ConsumerWidget {
  final DateTime day;
  final List<Workout> workouts;
  final TrainingBlock? block;
  final bool isSelected;

  const _DayColumn({
    required this.day,
    required this.workouts,
    this.block,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isToday = DateUtils.isSameDay(day, DateTime.now());
    final blockColor =
        BlockUtils.getColorForIntent(block?.intent, block?.blockNumber ?? 1);

    // Neutral Background Logic
    Color backgroundColor = Colors.transparent;
    if (isSelected) {
      backgroundColor = AppColors.white.withValues(alpha: 0.1);
    } else if (isToday) {
      backgroundColor = AppColors.white.withValues(alpha: 0.05);
    }

    // Ribbon Logic
    // We can't use non-uniform borders with borderRadius.
    // Instead, we use a ClipRRect and a Column to render the ribbon at the bottom.

    return GestureDetector(
      onTap: () => ref.read(selectedDateProvider.notifier).state = day,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(
                  color: AppColors.white.withValues(alpha: 0.5), width: 1)
              : Border.all(color: AppColors.divider, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('E').format(day).toUpperCase(),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isSelected || isToday
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: isSelected || isToday
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
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
                    const SizedBox(height: 8),
                    Expanded(
                      child: Column(
                        children: workouts
                            .map((w) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: WorkoutTypes.getColor(w.type)
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: WorkoutTypes.getColor(w.type)
                                            .withValues(alpha: 0.3),
                                      ),
                                    ),
                                    child: Icon(
                                      WorkoutTypes.getIcon(w.type),
                                      size: 10,
                                      color: WorkoutTypes.getColor(w.type),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              if (block != null)
                Container(
                  height: 4,
                  color: blockColor,
                  width: double.infinity,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
