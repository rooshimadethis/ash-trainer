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
import 'workout_detail_screen.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(now),
                style: AppTextStyles.h2,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 380,
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(height: 48),
        ),
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
                DateUtils.isSameDay(w.scheduledDate, weekStart) ||
                (w.scheduledDate.isAfter(weekStart) &&
                    w.scheduledDate
                        .isBefore(weekEnd.add(const Duration(days: 1)))))
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
              if (dayBlock != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: BlockUtils.getColorForIntent(
                            dayBlock.intent, dayBlock.blockNumber)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: BlockUtils.getColorForIntent(
                              dayBlock.intent, dayBlock.blockNumber)
                          .withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.layers_rounded,
                        size: 14,
                        color: BlockUtils.getColorForIntent(
                            dayBlock.intent, dayBlock.blockNumber),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          dayBlock.intent.toUpperCase(),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: BlockUtils.getColorForIntent(
                                dayBlock.intent, dayBlock.blockNumber),
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: dayWorkouts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.nightlight_round,
                          size: 48,
                          color: AppColors.textMuted.withValues(alpha: 0.5)),
                      const SizedBox(height: 16),
                      Text('No workouts scheduled',
                          style: AppTextStyles.bodyLarge
                              .copyWith(color: AppColors.textMuted)),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: dayWorkouts.length,
                  itemBuilder: (context, index) {
                    final workout = dayWorkouts[index];
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
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
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
      padding: const EdgeInsets.only(bottom: 6),
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

          final blockColor = dayBlock != null
              ? BlockUtils.getColorForIntent(
                  dayBlock.intent, dayBlock.blockNumber)
              : null;

          // Background tint logic
          final Color blockTint =
              blockColor?.withValues(alpha: 0.05) ?? Colors.transparent;
          final Color baseBackground = isToday
              ? AppColors.primary.withValues(alpha: 0.05)
              : AppColors.surfaceLighter.withValues(alpha: 0.5);

          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(selectedDateProvider.notifier).state = day,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 72,
                decoration: BoxDecoration(
                  color: Color.alphaBlend(blockTint, baseBackground),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.white
                        : isToday
                            ? AppColors.primary.withValues(alpha: 0.3)
                            : AppColors.border.withValues(alpha: 0.5),
                    width: isSelected ? 2.0 : 1.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('E').format(day).substring(0, 1),
                              style: AppTextStyles.labelSmall.copyWith(
                                color: isToday
                                    ? AppColors.primary
                                    : AppColors.textMuted,
                                fontSize: 9,
                                fontWeight:
                                    isToday ? FontWeight.w800 : FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              day.day.toString(),
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isToday
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                                fontWeight:
                                    isToday ? FontWeight.w800 : FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: dayWorkouts.take(3).map((w) {
                                final isCompleted = w.status == 'completed';
                                final displayColor =
                                    WorkoutTypes.getColor(w.type);
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 1.5),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: displayColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: isCompleted
                                      ? const Center(
                                          child: Icon(
                                            Icons.check,
                                            size: 6,
                                            color: AppColors.white,
                                          ),
                                        )
                                      : null,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      if (blockColor != null)
                        Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: blockColor,
                          ),
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
