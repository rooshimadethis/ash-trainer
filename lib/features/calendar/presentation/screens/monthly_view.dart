import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/entities/training/training_block.dart';
import '../../../shared/presentation/widgets/ash_chat_bubble.dart';
import '../providers/calendar_provider.dart';
import 'package:intl/intl.dart';
import '../widgets/calendar_nav_button.dart';
import '../widgets/calendar_day_cell.dart';
import '../widgets/calendar_progress_summary.dart';
import '../widgets/selected_day_workout_list.dart';

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
          _buildHeader(context, ref, focusedMonth),
          if (!DateUtils.isSameMonth(focusedMonth, DateTime.now())) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                final now = DateTime.now();
                ref.read(monthlyMonthProvider.notifier).state =
                    DateTime(now.year, now.month, 1);
              },
              child: Center(
                child: Text(
                  'BACK TO TODAY',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],

          const SizedBox(height: 20),

          // Ash context bubble
          monthlyWorkoutsAsync.when(
            data: (workouts) => _buildContextBubble(workouts, focusedMonth),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 20),

          // Progress summary cards
          monthlyWorkoutsAsync.when(
            data: (workouts) => CalendarProgressSummary(
              workouts: workouts,
              periodLabel: 'This Month',
            ),
            loading: () => const SizedBox(height: 80),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 24),

          // Month grid
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: monthlyWorkoutsAsync.when(
              data: (workouts) => monthlyBlocksAsync.when(
                data: (blocks) => _buildMonthlyGrid(
                  startOfRange,
                  focusedMonth,
                  workouts,
                  blocks,
                  selectedDate,
                ),
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

          // Selected day workout list
          monthlyWorkoutsAsync.when(
            data: (workouts) => monthlyBlocksAsync.when(
              data: (blocks) => SelectedDayWorkoutList(
                selectedDate: selectedDate,
                allWorkouts: workouts,
                blocks: blocks,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildContextBubble(List<Workout> workouts, DateTime focusedMonth) {
    final completed = workouts.where((w) => w.status == 'completed').length;
    final total = workouts.length;

    // Check if this is current month
    final now = DateTime.now();
    final isCurrentMonth =
        now.month == focusedMonth.month && now.year == focusedMonth.year;

    // Get month name
    final monthName = DateFormat('MMMM').format(focusedMonth);

    String message;
    if (total == 0) {
      message =
          "No workouts planned for $monthName. Time to set some goals! 🎯";
    } else if (completed == total) {
      message =
          "You completed every workout in $monthName! Incredible consistency! 🏆";
    } else if (isCurrentMonth) {
      final progress = ((completed / total) * 100).round();
      if (progress == 0) {
        message =
            "$total workouts planned for $monthName. Let's build that momentum! 🚀";
      } else if (progress >= 75) {
        message =
            "$progress% complete! You're crushing $monthName! Keep it up! 💪";
      } else if (progress >= 50) {
        message =
            "Halfway through! $completed of $total workouts done. Strong progress! 🔥";
      } else {
        message =
            "$completed workouts down, ${total - completed} to go this month. You've got this!";
      }
    } else {
      final successRate = total > 0 ? ((completed / total) * 100).round() : 0;
      if (successRate >= 80) {
        message =
            "Great month! You hit $successRate% of your workouts in $monthName. 🌟";
      } else if (successRate >= 50) {
        message =
            "Solid effort in $monthName - $completed of $total workouts completed.";
      } else {
        message =
            "$monthName had $total planned workouts. Every step counts! 🏃";
      }
    }

    return AshChatBubble(text: message);
  }

  Widget _buildHeader(
      BuildContext context, WidgetRef ref, DateTime focusedMonth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CalendarNavButton(
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
        CalendarNavButton(
          icon: Icons.chevron_right_rounded,
          onPressed: () {
            ref
                .read(monthlyMonthProvider.notifier)
                .update((date) => DateTime(date.year, date.month + 1, 1));
          },
        ),
      ],
    );
  }

  Widget _buildMonthlyGrid(
    DateTime startOfRange,
    DateTime focusedMonth,
    List<Workout> workouts,
    List<TrainingBlock> blocks,
    DateTime selectedDate,
  ) {
    // Calculate total weeks needed for this month
    final lastDay = DateTime(focusedMonth.year, focusedMonth.month + 1, 0).day;
    final offset = focusedMonth.weekday - 1;
    final totalWeeks = ((offset + lastDay) / 7).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
          );
        }),
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

  const _WeekRow({
    required this.weekStart,
    required this.focusedMonth,
    required this.workouts,
    required this.blocks,
    required this.selectedDate,
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
                child: SizedBox(height: 78),
              ),
            );
          }

          final dayWorkouts = workouts
              .where((w) => DateUtils.isSameDay(w.scheduledDate, day))
              .toList();
          final isSelected = DateUtils.isSameDay(day, selectedDate);

          // Find block for this day
          final dayBlock = _findBlockForDay(day);

          return Expanded(
            child: CalendarDayCell(
              day: day,
              workouts: dayWorkouts,
              block: dayBlock,
              isSelected: isSelected,
              style: CalendarDayCellStyle.compact,
              height: 78,
            ),
          );
        }),
      ),
    );
  }

  TrainingBlock? _findBlockForDay(DateTime day) {
    return blocks.cast<TrainingBlock?>().firstWhere(
      (b) {
        if (b == null || b.startDate == null || b.endDate == null) {
          return false;
        }
        final start =
            DateTime(b.startDate!.year, b.startDate!.month, b.startDate!.day);
        final end = DateTime(b.endDate!.year, b.endDate!.month, b.endDate!.day)
            .add(const Duration(days: 1));
        final d = DateTime(day.year, day.month, day.day);
        return (d.isAtSameMomentAs(start) || d.isAfter(start)) &&
            d.isBefore(end);
      },
      orElse: () => null,
    );
  }
}
