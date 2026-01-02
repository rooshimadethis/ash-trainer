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
import 'package:ash_trainer/core/theme/shadows.dart';
import 'workout_detail_screen.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../shared/presentation/widgets/ash_surface_card.dart';

class MonthlyView extends ConsumerWidget {
  const MonthlyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyWorkoutsAsync = ref.watch(monthlyWorkoutsProvider);
    final monthlyBlocksAsync = ref.watch(monthlyBlocksProvider);
    final focusedMonth = ref.watch(monthlyMonthProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    // Calculate start of range: Monday of the week containing the first of the month
    final startOfRange =
        focusedMonth.subtract(Duration(days: focusedMonth.weekday - 1));

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navButton(
                context,
                icon: Icons.chevron_left_rounded,
                onPressed: () {
                  ref
                      .read(monthlyMonthProvider.notifier)
                      .update((date) => DateTime(date.year, date.month - 1, 1));
                },
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'MONTHLY',
                      style: AppTextStyles.label.copyWith(
                        letterSpacing: 2.5,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('MMMM yyyy').format(focusedMonth),
                      style: AppTextStyles.h2,
                    ),
                  ],
                ),
              ),
              _navButton(
                context,
                icon: Icons.chevron_right_rounded,
                onPressed: () {
                  ref
                      .read(monthlyMonthProvider.notifier)
                      .update((date) => DateTime(date.year, date.month + 1, 1));
                },
              ),
            ],
          ),
          if (!DateUtils.isSameMonth(focusedMonth, DateTime.now())) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                final now = DateTime.now();
                ref.read(monthlyMonthProvider.notifier).state =
                    DateTime(now.year, now.month, 1);
              },
              child: Text(
                'BACK TO TODAY',
                style: AppTextStyles.labelSmall.copyWith(
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: monthlyWorkoutsAsync.when(
              data: (workouts) => monthlyBlocksAsync.when(
                data: (blocks) => _buildMonthlyGrid(startOfRange, focusedMonth,
                    workouts, blocks, selectedDate, ref),
                loading: () => const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator())),
                error: (err, stack) => SizedBox(
                    height: 200, child: Center(child: Text('Error: $err'))),
              ),
              loading: () => const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator())),
              error: (err, stack) => SizedBox(
                  height: 200, child: Center(child: Text('Error: $err'))),
            ),
          ),
          const SizedBox(height: 32),
          monthlyWorkoutsAsync.when(
            data: (workouts) => monthlyBlocksAsync.when(
              data: (blocks) =>
                  _buildWorkoutList(context, selectedDate, workouts, blocks),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
          const SizedBox(height: 32), // Bottom padding for scrollability
        ],
      ),
    );
  }

  Widget _buildMonthlyGrid(
      DateTime startOfRange,
      DateTime focusedMonth,
      List<Workout> workouts,
      List<TrainingBlock> blocks,
      DateTime selectedDate,
      WidgetRef ref) {
    // Calculate total weeks needed for this month
    final lastDay = DateTime(focusedMonth.year, focusedMonth.month + 1, 0).day;
    final offset = focusedMonth.weekday - 1;
    final totalWeeks = ((offset + lastDay) / 7).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(totalWeeks, (weekIndex) {
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
            focusedMonth: focusedMonth,
            workouts: weekWorkouts,
            blocks: blocks,
            selectedDate: selectedDate,
            ref: ref,
          );
        }),
      ),
    );
  }

  Widget _buildWorkoutList(BuildContext context, DateTime selectedDate,
      List<Workout> allWorkouts, List<TrainingBlock> blocks) {
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
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
        if (dayBlock != null) ...[
          const SizedBox(height: 16),
          AshSurfaceCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: BlockUtils.getColorForIntent(
                            dayBlock.intent, dayBlock.blockNumber)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: BlockUtils.getColorForIntent(
                              dayBlock.intent, dayBlock.blockNumber)
                          .withValues(alpha: 0.2),
                      width: 1.2,
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
                      const SizedBox(width: 6),
                      Text(
                        'TRAINING BLOCK',
                        style: AppTextStyles.label.copyWith(
                          color: BlockUtils.getColorForIntent(
                              dayBlock.intent, dayBlock.blockNumber),
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
                  dayBlock.intent.toUpperCase(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 24),
        dayWorkouts.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: Center(
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
                ),
              )
            : Column(
                children: List.generate(dayWorkouts.length, (index) {
                  final workout = dayWorkouts[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: index == dayWorkouts.length - 1 ? 0 : 16),
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
                }),
              ),
      ],
    );
  }

  Widget _navButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return AshCard(
      onTap: onPressed,
      padding: EdgeInsets.zero,
      borderRadius: 100,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
          size: 24,
        ),
      ),
    );
  }
}

class _WeekRow extends StatelessWidget {
  final DateTime weekStart;
  final DateTime focusedMonth;
  final List<Workout> workouts;
  final List<TrainingBlock> blocks;
  final DateTime selectedDate;
  final WidgetRef ref;

  const _WeekRow({
    required this.weekStart,
    required this.focusedMonth,
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
          final isSameMonth = day.month == focusedMonth.month;

          if (!isSameMonth) {
            return const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child: SizedBox(height: 72),
              ),
            );
          }

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
              blockColor?.withValues(alpha: 0.15) ?? Colors.transparent;
          final isDark = Theme.of(context).brightness == Brightness.dark;

          final Color baseBackground = isDark
              ? AppColors.surface.withValues(alpha: 0.4)
              : AppColors.surfaceLightSecondary.withValues(alpha: 0.6);

          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(selectedDateProvider.notifier).state = day,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                height: 78,
                decoration: BoxDecoration(
                  color: Color.alphaBlend(blockTint, baseBackground),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? (isDark ? const Color(0xFFFF4D8C) : Colors.black)
                        : (isToday
                            ? Theme.of(context).primaryColor
                            : (isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.black.withValues(alpha: 0.1))),
                    width: isSelected ? 2.5 : 1.5,
                  ),
                  boxShadow: isSelected
                      ? (isDark ? AppShadows.retroDark : AppShadows.retro)
                      : [],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('E').format(day).substring(0, 1),
                              style: AppTextStyles.labelSmall.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.4),
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              day.day.toString(),
                              style: AppTextStyles.h4.copyWith(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w900,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 1),
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
                                    color: isCompleted
                                        ? displayColor
                                        : displayColor.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          displayColor.withValues(alpha: 0.6),
                                      width: 1,
                                    ),
                                  ),
                                  child: isCompleted
                                      ? const Center(
                                          child: Icon(
                                            Icons.check,
                                            size: 6,
                                            color: Colors.white,
                                          ),
                                        )
                                      : null,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
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
