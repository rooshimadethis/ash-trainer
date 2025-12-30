import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/workout_types.dart';
import '../../../shared/presentation/widgets/workout_card.dart';
import '../providers/calendar_provider.dart';
import 'package:intl/intl.dart';

class WeeklyView extends ConsumerWidget {
  const WeeklyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startOfWeek = ref.watch(selectedWeekProvider);
    final selectedDate = ref.watch(selectedDateProvider);
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
        const SizedBox(height: 16),
        SizedBox(
          height: 120, // Height for the day columns
          child: weeklyWorkoutsAsync.when(
            data: (workouts) =>
                _buildWeekGrid(startOfWeek, workouts, selectedDate),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
        const Divider(color: Colors.white12, height: 32),
        Expanded(
          child: weeklyWorkoutsAsync.when(
            data: (workouts) => _buildWorkoutList(selectedDate, workouts),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekGrid(
      DateTime startOfWeek, List<dynamic> workouts, DateTime selectedDate) {
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
            child: _DayColumn(
              day: day,
              workouts: dayWorkouts,
              isSelected: DateUtils.isSameDay(day, selectedDate),
            ),
          );
        }),
      ),
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
                  padding: const EdgeInsets.all(16),
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

class _DayColumn extends ConsumerWidget {
  final DateTime day;
  final List<dynamic> workouts;
  final bool isSelected;

  const _DayColumn({
    required this.day,
    required this.workouts,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isToday = DateUtils.isSameDay(day, DateTime.now());

    return GestureDetector(
      onTap: () => ref.read(selectedDateProvider.notifier).state = day,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.2)
              : isToday
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 2)
              : isToday
                  ? Border.all(color: AppColors.primary.withValues(alpha: 0.3))
                  : null,
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text(
              DateFormat('E').format(day).toUpperCase(),
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected || isToday
                    ? AppColors.primary
                    : AppColors.textSecondary,
                fontWeight:
                    isSelected || isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              day.day.toString(),
              style: AppTextStyles.bodyMedium.copyWith(
                color: isSelected || isToday ? AppColors.primary : Colors.white,
                fontWeight:
                    isSelected || isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                children: workouts
                    .map((w) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: WorkoutTypes.getColor(w.type)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: WorkoutTypes.getColor(w.type)
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Icon(
                              WorkoutTypes.getIcon(w.type),
                              size: 10,
                              color: WorkoutTypes.getColor(w.type),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
