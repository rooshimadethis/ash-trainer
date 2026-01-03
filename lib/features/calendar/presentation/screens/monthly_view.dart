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
import '../../../shared/domain/entities/time_off_entry.dart';
import '../providers/time_off_provider.dart';
import 'package:collection/collection.dart';
import '../widgets/calendar_grid_skeleton.dart';
import '../widgets/workout_list_skeleton.dart';
import '../../../developer/presentation/providers/debug_providers.dart';
import 'package:ash_trainer/features/shared/presentation/providers/ash_status_provider.dart';

class MonthlyView extends ConsumerWidget {
  const MonthlyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyWorkoutsAsync = ref.watch(monthlyWorkoutsProvider);
    final monthlyBlocksAsync = ref.watch(monthlyBlocksProvider);
    final focusedMonth = ref.watch(monthlyMonthProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final timeOffAsync = ref.watch(timeOffControllerProvider);

    // Calculate start of range: Monday of the week containing the first of the month
    final startOfRange =
        focusedMonth.subtract(Duration(days: focusedMonth.weekday - 1));

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          ref.refresh(monthlyWorkoutsProvider.future),
          ref.refresh(monthlyBlocksProvider.future),
          ref.refresh(timeOffControllerProvider.future),
        ]);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
              child: (ref.watch(debugShowShimmerSkeletonProvider) ||
                      ref.watch(isAshThinkingProvider))
                  ? const SizedBox(
                      height: 200, child: CalendarGridSkeleton(isWeekly: false))
                  : monthlyWorkoutsAsync.when(
                      data: (workouts) => monthlyBlocksAsync.when(
                        data: (blocks) => timeOffAsync.when(
                          data: (timeOffs) => _buildMonthlyGrid(
                            startOfRange,
                            focusedMonth,
                            workouts,
                            blocks,
                            timeOffs,
                            selectedDate,
                          ),
                          loading: () => const SizedBox(
                              height: 200,
                              child: CalendarGridSkeleton(isWeekly: false)),
                          error: (err, stack) => SizedBox(
                              height: 200,
                              child: Center(child: Text('Error: $err'))),
                        ),
                        loading: () => const SizedBox(
                            height: 200,
                            child: CalendarGridSkeleton(isWeekly: false)),
                        error: (err, stack) => SizedBox(
                            height: 200,
                            child: Center(child: Text('Error: $err'))),
                      ),
                      loading: () => const SizedBox(
                          height: 200,
                          child: CalendarGridSkeleton(isWeekly: false)),
                      error: (err, stack) => SizedBox(
                          height: 200,
                          child: Center(child: Text('Error: $err'))),
                    ),
            ),

            const SizedBox(height: 12),

            // Ash context bubble
            (ref.watch(debugShowShimmerSkeletonProvider) ||
                    ref.watch(isAshThinkingProvider))
                ? const AshChatBubble(text: "Thinking...", isThinking: true)
                : monthlyWorkoutsAsync.when(
                    data: (workouts) => monthlyBlocksAsync.when(
                      data: (blocks) =>
                          _buildContextBubble(workouts, blocks, selectedDate),
                      loading: () => const AshChatBubble(
                          text: "Thinking...", isThinking: true),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                    loading: () => const AshChatBubble(
                        text: "Thinking...", isThinking: true),
                    error: (_, __) => const SizedBox.shrink(),
                  ),

            const SizedBox(height: 32),

            // Selected day workout list
            (ref.watch(debugShowShimmerSkeletonProvider) ||
                    ref.watch(isAshThinkingProvider))
                ? const WorkoutListSkeleton()
                : monthlyWorkoutsAsync.when(
                    data: (workouts) => monthlyBlocksAsync.when(
                      data: (blocks) => timeOffAsync.when(
                        data: (timeOffs) => SelectedDayWorkoutList(
                          selectedDate: selectedDate,
                          allWorkouts: workouts,
                          blocks: blocks,
                          timeOffs: timeOffs,
                        ),
                        loading: () => const WorkoutListSkeleton(),
                        error: (err, stack) =>
                            Center(child: Text('Error: $err')),
                      ),
                      loading: () => const WorkoutListSkeleton(),
                      error: (err, stack) => Center(child: Text('Error: $err')),
                    ),
                    loading: () => const WorkoutListSkeleton(),
                    error: (err, stack) => Center(child: Text('Error: $err')),
                  ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildContextBubble(List<Workout> workouts, List<TrainingBlock> blocks,
      DateTime selectedDate) {
    final currentBlock = _findBlockForDay(selectedDate, blocks);

    String message;
    if (currentBlock != null && currentBlock.intent.isNotEmpty) {
      // Show the direct intent from the AI (which is now conversational)
      message = currentBlock.intent;
    } else {
      // Use the consistent motivational fallback string
      message =
          "No specific training block active right now. Let's keep moving and stay healthy! 🏃";
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
    List<TimeOffEntry> timeOffs,
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
            timeOffs: timeOffs,
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
  final List<TimeOffEntry> timeOffs;
  final DateTime selectedDate;

  const _WeekRow({
    required this.weekStart,
    required this.focusedMonth,
    required this.workouts,
    required this.blocks,
    required this.timeOffs,
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

          // Find time off for this day
          final dayTimeOff = timeOffs.firstWhereOrNull((t) {
            final isStart = DateUtils.isSameDay(day, t.startDate);
            final isEnd = DateUtils.isSameDay(day, t.endDate);
            final isBetween =
                day.isAfter(t.startDate) && day.isBefore(t.endDate);
            return isStart || isEnd || isBetween;
          });

          return Expanded(
            child: CalendarDayCell(
              day: day,
              workouts: dayWorkouts,
              block: dayBlock,
              timeOff: dayTimeOff,
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
