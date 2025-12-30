import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/workout_types.dart';
import '../../../shared/presentation/widgets/workout_card.dart';
import '../providers/calendar_provider.dart';
import 'package:intl/intl.dart';

class MonthlyView extends ConsumerWidget {
  const MonthlyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthlyWorkoutsAsync = ref.watch(monthlyWorkoutsProvider);
    final selectedDate = ref.watch(selectedDateProvider);
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
        SizedBox(
          height: 380, // Adjust height to fit 4 weeks
          child: monthlyWorkoutsAsync.when(
            data: (workouts) =>
                _build4WeekGrid(startOfRange, workouts, selectedDate, ref),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
        const Divider(color: Colors.white12, height: 32),
        Expanded(
          child: monthlyWorkoutsAsync.when(
            data: (workouts) => _buildWorkoutList(selectedDate, workouts),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
      ],
    );
  }

  Widget _build4WeekGrid(DateTime startOfRange, List<dynamic> workouts,
      DateTime selectedDate, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
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
          weekStart: weekStart,
          workouts: weekWorkouts,
          selectedDate: selectedDate,
          ref: ref,
        );
      },
    );
  }

  Widget _buildWorkoutList(DateTime selectedDate, List<dynamic> allWorkouts) {
    final dayWorkouts = allWorkouts
        .where((w) => DateUtils.isSameDay(w.scheduledDate, selectedDate))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            DateFormat('EEEE, MMM d').format(selectedDate),
            style: AppTextStyles.h4.copyWith(color: AppColors.primary),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: dayWorkouts.isEmpty
              ? const Center(
                  child: Text('Rest Day',
                      style: TextStyle(color: AppColors.textSecondary)))
              : ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

class _WeekRow extends StatelessWidget {
  final DateTime weekStart;
  final List<dynamic> workouts;
  final DateTime selectedDate;
  final WidgetRef ref;

  const _WeekRow({
    required this.weekStart,
    required this.workouts,
    required this.selectedDate,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) {
          final day = weekStart.add(Duration(days: index));
          final dayWorkouts = workouts
              .where((w) => DateUtils.isSameDay(w.scheduledDate, day))
              .toList();
          final isSelected = DateUtils.isSameDay(day, selectedDate);
          final isToday = DateUtils.isSameDay(day, DateTime.now());

          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(selectedDateProvider.notifier).state = day,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 80,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.2)
                      : isToday
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : AppColors.surfaceHighlight.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : isToday
                            ? AppColors.primary.withValues(alpha: 0.3)
                            : AppColors.divider,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('E').format(day).substring(0, 1),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isSelected || isToday
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: isSelected || isToday
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 4),
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
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: dayWorkouts
                          .take(3)
                          .map((w) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: Icon(
                                  WorkoutTypes.getIcon(w.type),
                                  size: 10,
                                  color: WorkoutTypes.getColor(w.type),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
