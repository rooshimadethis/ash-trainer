import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/block_utils.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'package:ash_trainer/core/theme/shadows.dart';
import '../../../../core/constants/workout_types.dart';
import '../../../shared/presentation/widgets/workout_card.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/entities/training/training_block.dart';
import '../providers/calendar_provider.dart';
import 'package:intl/intl.dart';
import 'workout_detail_screen.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../shared/presentation/widgets/ash_surface_card.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navButton(
                context,
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
              _navButton(
                context,
                icon: Icons.chevron_right_rounded,
                onPressed: () => ref.read(selectedWeekProvider.notifier).state =
                    startOfWeek.add(const Duration(days: 7)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SizedBox(height: 12),
          SizedBox(
            height: 120, // Reduced height for better proportions
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
          weeklyWorkoutsAsync.when(
            data: (workouts) => weeklyBlocksAsync.when(
              data: (blocks) =>
                  _buildWorkoutList(context, selectedDate, workouts, blocks),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
          const SizedBox(height: 32), // Add padding for bottom
        ],
      ),
    );
  }

  Widget _buildWeekGrid(DateTime startOfWeek, List<Workout> workouts,
      List<TrainingBlock> blocks, DateTime selectedDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final day = startOfWeek.add(Duration(days: index));
        final dayWorkouts = workouts
            .where((w) => DateUtils.isSameDay(w.scheduledDate, day))
            .toList();

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

        return Expanded(
          child: _DayColumn(
            day: day,
            workouts: dayWorkouts,
            block: dayBlock,
            isSelected: DateUtils.isSameDay(day, selectedDate),
          ),
        );
      }),
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
}

class _DayColumn extends ConsumerWidget {
  final DateTime day;
  final List<Workout> workouts;
  final TrainingBlock? block;
  final bool isSelected;

  const _DayColumn({
    required this.day,
    required this.workouts,
    this.block,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isToday = DateUtils.isSameDay(day, DateTime.now());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final blockColor = block != null
        ? BlockUtils.getColorForIntent(block!.intent, block!.blockNumber)
        : null;

    // Background tint logic for blocks (subtle)
    final Color blockTint =
        blockColor?.withValues(alpha: 0.15) ?? Colors.transparent;
    final Color baseBackground = isDark
        ? AppColors.surface.withValues(alpha: 0.4)
        : AppColors.surfaceLightSecondary.withValues(alpha: 0.6);

    return GestureDetector(
      onTap: () => ref.read(selectedDateProvider.notifier).state = day,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(vertical: 8),
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('E').format(day).toUpperCase(),
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
            const SizedBox(height: 2),
            Text(
              day.day.toString(),
              style: AppTextStyles.h4.copyWith(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),
            if (workouts.isNotEmpty) ...[
              const SizedBox(height: 6),
              ...workouts.take(2).map((w) {
                final isCompleted = w.status == 'completed';
                final displayColor = WorkoutTypes.getColor(w.type);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: displayColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: displayColor.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        isCompleted
                            ? Icons.check_rounded
                            : WorkoutTypes.getIcon(w.type),
                        size: 10,
                        color: displayColor,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
