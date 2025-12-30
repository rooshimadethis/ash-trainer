import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../providers/calendar_provider.dart';
import '../widgets/workout_badge.dart';
import '../widgets/week_summary_card.dart';
import 'package:intl/intl.dart';

class WeeklyView extends ConsumerWidget {
  const WeeklyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startOfWeek = ref.watch(selectedWeekProvider);
    final weeklyWorkoutsAsync = ref.watch(weeklyWorkoutsProvider);

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
              Column(
                children: [
                  Text(weekRangeStr, style: AppTextStyles.h4),
                  Text('Week 3 of 12',
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.textSecondary)),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: AppColors.primary),
                onPressed: () => ref.read(selectedWeekProvider.notifier).state =
                    startOfWeek.add(const Duration(days: 7)),
              ),
            ],
          ),
        ),
        Expanded(
          child: weeklyWorkoutsAsync.when(
            data: (workouts) => _buildWeekGrid(startOfWeek, workouts),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: weeklyWorkoutsAsync.when(
            data: (workouts) => _buildSummary(workouts),
            loading: () => const SizedBox.shrink(),
            error: (err, stack) => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekGrid(DateTime startOfWeek, List<dynamic> workouts) {
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

          return Expanded(
            child: _DayColumn(day: day, workouts: dayWorkouts),
          );
        }),
      ),
    );
  }

  Widget _buildSummary(List<dynamic> workouts) {
    double totalKm = 0;
    int totalSeconds = 0;
    int completed = 0;

    for (var w in workouts) {
      if (w.plannedDistance != null) {
        totalKm += (w.plannedDistance as num).toDouble();
      }
      totalSeconds += (w.plannedDuration as num).toInt();
      if (w.status == 'completed') {
        completed++;
      }
    }

    return WeekSummaryCard(
      totalDistance: totalKm,
      totalDuration: Duration(seconds: totalSeconds),
      completedWorkouts: completed,
      totalWorkouts: workouts.length,
    );
  }
}

class _DayColumn extends StatelessWidget {
  final DateTime day;
  final List<dynamic> workouts;

  const _DayColumn({required this.day, required this.workouts});

  @override
  Widget build(BuildContext context) {
    final isToday = DateUtils.isSameDay(day, DateTime.now());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isToday
            ? AppColors.primary.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isToday
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.3))
            : null,
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            DateFormat('E').format(day).toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: isToday ? AppColors.primary : AppColors.textSecondary,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            day.day.toString(),
            style: AppTextStyles.bodyMedium.copyWith(
              color: isToday ? AppColors.primary : Colors.white,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Column(
              children: workouts.isEmpty
                  ? [
                      const Text('—',
                          style: TextStyle(color: AppColors.textSecondary))
                    ]
                  : workouts
                      .map((w) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: WorkoutBadge(type: w.type, size: 10),
                          ))
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
