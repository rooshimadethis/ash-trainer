import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/entities/training/training_block.dart';
import '../../../shared/presentation/widgets/ash_chat_bubble.dart';
import '../providers/calendar_provider.dart';
import 'package:intl/intl.dart';
import '../widgets/calendar_nav_button.dart';
import '../widgets/calendar_day_cell.dart';
import '../widgets/calendar_progress_summary.dart';
import '../widgets/selected_day_workout_list.dart';

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

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, ref, startOfWeek, weekRangeStr),
          const SizedBox(height: 20),

          // Ash context bubble
          weeklyWorkoutsAsync.when(
            data: (workouts) => _buildContextBubble(workouts, startOfWeek),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 20),

          // Progress summary cards
          weeklyWorkoutsAsync.when(
            data: (workouts) => CalendarProgressSummary(
              workouts: workouts,
              periodLabel: 'This Week',
            ),
            loading: () => const SizedBox(height: 80),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 24),

          // Week grid
          SizedBox(
            height: 120,
            child: weeklyWorkoutsAsync.when(
              data: (workouts) => weeklyBlocksAsync.when(
                data: (blocks) =>
                    _buildWeekGrid(startOfWeek, workouts, blocks, selectedDate),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
          const SizedBox(height: 32),

          // Selected day workout list
          weeklyWorkoutsAsync.when(
            data: (workouts) => weeklyBlocksAsync.when(
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

  Widget _buildContextBubble(List<Workout> workouts, DateTime startOfWeek) {
    final completed = workouts.where((w) => w.status == 'completed').length;
    final total = workouts.length;
    final remaining = total - completed;

    // Check if this is current week
    final now = DateTime.now();
    final isCurrentWeek =
        now.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            now.isBefore(startOfWeek.add(const Duration(days: 7)));

    String message;
    if (total == 0) {
      message = "Looks like a recovery week! Focus on rest and mobility. 🧘";
    } else if (completed == total) {
      message = "Amazing work! You crushed every workout this week! 🏆";
    } else if (isCurrentWeek) {
      if (remaining == 1) {
        message = "Just 1 workout left this week. You've got this! 💪";
      } else if (remaining == total) {
        message = "$total workouts planned this week. Let's make it count! 🔥";
      } else {
        message = "$completed done, $remaining to go. Keep the momentum! 🚀";
      }
    } else {
      if (completed == 0 && total > 0) {
        message =
            "This week had $total workouts planned. Check out the details below!";
      } else {
        message =
            "You completed $completed of $total workouts this week. Nice effort!";
      }
    }

    return AshChatBubble(text: message);
  }

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    DateTime startOfWeek,
    String weekRangeStr,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CalendarNavButton(
          icon: Icons.chevron_left_rounded,
          onPressed: () => ref.read(selectedWeekProvider.notifier).state =
              startOfWeek.subtract(const Duration(days: 7)),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'WEEKLY',
                style: AppTextStyles.label.copyWith(
                  letterSpacing: 2.5,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat('MMMM yyyy').format(startOfWeek),
                style: AppTextStyles.h2,
              ),
              const SizedBox(height: 4),
              Text(
                weekRangeStr.toUpperCase(),
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textMuted,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        CalendarNavButton(
          icon: Icons.chevron_right_rounded,
          onPressed: () => ref.read(selectedWeekProvider.notifier).state =
              startOfWeek.add(const Duration(days: 7)),
        ),
      ],
    );
  }

  Widget _buildWeekGrid(
    DateTime startOfWeek,
    List<Workout> workouts,
    List<TrainingBlock> blocks,
    DateTime selectedDate,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final day = startOfWeek.add(Duration(days: index));
        final dayWorkouts = workouts
            .where((w) => DateUtils.isSameDay(w.scheduledDate, day))
            .toList();

        // Find block for this day
        final dayBlock = _findBlockForDay(day, blocks);

        return Expanded(
          child: CalendarDayCell(
            day: day,
            workouts: dayWorkouts,
            block: dayBlock,
            isSelected: DateUtils.isSameDay(day, selectedDate),
            style: CalendarDayCellStyle.expanded,
          ),
        );
      }),
    );
  }

  TrainingBlock? _findBlockForDay(DateTime day, List<TrainingBlock> blocks) {
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
