import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../providers/calendar_provider.dart';
import '../widgets/workout_badge.dart';
import '../../../shared/presentation/widgets/ash_glass_card.dart';
import 'package:intl/intl.dart';

class MonthlyView extends ConsumerWidget {
  const MonthlyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyWorkoutsAsync = ref.watch(monthlyWorkoutsProvider);
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
        Expanded(
          child: monthlyWorkoutsAsync.when(
            data: (workouts) => _build4WeekGrid(startOfRange, workouts),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: monthlyWorkoutsAsync.when(
            data: (workouts) => _buildMonthlyStats(workouts),
            loading: () => const SizedBox.shrink(),
            error: (err, stack) => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Widget _build4WeekGrid(DateTime startOfRange, List<dynamic> workouts) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
          weekNumber: 3 + weekIndex, // Mocked week numbering
          weekStart: weekStart,
          workouts: weekWorkouts,
        );
      },
    );
  }

  Widget _buildMonthlyStats(List<dynamic> workouts) {
    double totalKm = 0;
    int completed = 0;

    for (var w in workouts) {
      if (w.plannedDistance != null) {
        totalKm += (w.plannedDistance as num).toDouble();
      }
      if (w.status == 'completed') {
        completed++;
      }
    }

    return AshGlassCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('${totalKm.toInt()}K', 'Distance'),
          _statItem('$completed', 'Completed'),
          _statItem('88%', 'Avg. Adherence'), // Mocked
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h4),
        Text(label,
            style: AppTextStyles.labelSmall
                .copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}

class _WeekRow extends StatelessWidget {
  final int weekNumber;
  final DateTime weekStart;
  final List<dynamic> workouts;

  const _WeekRow({
    required this.weekNumber,
    required this.weekStart,
    required this.workouts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceHighlight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('WEEK',
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.textSecondary)),
                Text('$weekNumber', style: AppTextStyles.h3),
              ],
            ),
          ),
          const VerticalDivider(color: AppColors.divider),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                final day = weekStart.add(Duration(days: index));
                final dayWorkouts = workouts
                    .where((w) => DateUtils.isSameDay(w.scheduledDate, day))
                    .toList();

                return Column(
                  children: [
                    Text(
                      DateFormat('E').format(day).substring(0, 1),
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    dayWorkouts.isEmpty
                        ? const SizedBox(height: 10, width: 10)
                        : WorkoutBadge(type: dayWorkouts.first.type, size: 10),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(width: 8),
          _adherenceIndicator(workouts),
        ],
      ),
    );
  }

  Widget _adherenceIndicator(List<dynamic> workouts) {
    if (workouts.isEmpty) return const SizedBox.shrink();

    final completed = workouts.where((w) => w.status == 'completed').length;
    final ratio = completed / workouts.length;

    Color color = Colors.red;
    if (ratio > 0.8) {
      color = Colors.green;
    } else if (ratio > 0.6) {
      color = Colors.yellow;
    }

    return Container(
      width: 4,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
