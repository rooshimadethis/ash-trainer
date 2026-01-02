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

          const SizedBox(height: 24),

          // Ash context bubble
          monthlyWorkoutsAsync.when(
            data: (workouts) => monthlyBlocksAsync.when(
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

  Widget _buildContextBubble(List<Workout> workouts, List<TrainingBlock> blocks,
      DateTime selectedDate) {
    final currentBlock = _findBlockForDay(selectedDate, blocks);

    // Get month name
    final monthName = DateFormat('MMMM').format(selectedDate);

    String message;
    if (currentBlock != null) {
      final intent = currentBlock.intent.toLowerCase();
      if (intent.contains('base')) {
        message =
            "For $monthName, we're focusing on the Base phase. Steady aerobic miles to build your foundation. 🏃‍♂️";
      } else if (intent.contains('build')) {
        message =
            "$monthName is a Build phase. We're ramping up volume and intensity to take your fitness to the next level. 🔥";
      } else if (intent.contains('peak')) {
        message =
            "It's the Peak phase in $monthName! Things will get tough, but this is where the biggest gains happen. 🏆";
      } else if (intent.contains('taper')) {
        message =
            "We're in the Taper phase for $monthName. Sharpening up and resting for peak performance. ⚡";
      } else if (intent.contains('recover')) {
        message =
            "$monthName includes a Recovery phase. Essential rest to make sure your body is absorbing all your training. 🧘";
      } else {
        message =
            "In $monthName, we're currently in the ${currentBlock.intent} block. Stick to the process! 💪";
      }
    } else {
      message =
          "No specific training block defined for $monthName yet. Let's keep a consistent routine! 🏃";
    }

    return AshChatBubble(text: message);
  }

  /// Helper to find block for a day - duplicated from _WeekRow but needed for context bubble
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
