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

          const SizedBox(height: 24),

          // Ash context bubble
          weeklyWorkoutsAsync.when(
            data: (workouts) => weeklyBlocksAsync.when(
              data: (blocks) =>
                  _buildContextBubble(workouts, blocks, selectedDate),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
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

  Widget _buildContextBubble(List<Workout> workouts, List<TrainingBlock> blocks,
      DateTime selectedDate) {
    final currentBlock = _findBlockForDay(selectedDate, blocks);

    String message;
    if (currentBlock != null) {
      final intent = currentBlock.intent.toLowerCase();
      if (intent.contains('base')) {
        message =
            "We're in a Base phase. Focus on building an aerobic foundation with steady, easy efforts. 🏃‍♂️";
      } else if (intent.contains('build')) {
        message =
            "It's the Build phase! We're increasing volume and adding some intensity to sharpen your fitness. 🔥";
      } else if (intent.contains('peak')) {
        message =
            "Peak week! This is where we push the limits. Trust your training and stay focused. 🏆";
      } else if (intent.contains('taper')) {
        message =
            "Taper time. We're cutting back volume so you're fresh and ready for race day. ⚡";
      } else if (intent.contains('recover')) {
        message =
            "Recovery week. Prioritize sleep, mobility, and let your body absorb the hard work. 🧘";
      } else {
        message =
            "Currently in the ${currentBlock.intent} block. Let's stay consistent and stick to the plan! 💪";
      }
    } else {
      message =
          "No specific training block active right now. Let's keep moving and stay healthy! 🏃";
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
