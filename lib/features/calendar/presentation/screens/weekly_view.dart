import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/block_utils.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/workout_types.dart';
import '../../../shared/presentation/widgets/workout_card.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/entities/training/training_block.dart';
import '../providers/calendar_provider.dart';
import 'package:intl/intl.dart';
import 'workout_detail_screen.dart';

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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _NavIcon(
                  icon: Icons.chevron_left_rounded,
                  onTap: () => ref.read(selectedWeekProvider.notifier).state =
                      startOfWeek.subtract(const Duration(days: 7)),
                ),
                Column(
                  children: [
                    Text(
                      DateFormat('MMMM yyyy').format(startOfWeek),
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                    Text(weekRangeStr, style: AppTextStyles.h4),
                  ],
                ),
                _NavIcon(
                  icon: Icons.chevron_right_rounded,
                  onTap: () => ref.read(selectedWeekProvider.notifier).state =
                      startOfWeek.add(const Duration(days: 7)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 130, // Increased height for better proportions
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 48),
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: BlockUtils.getColorForIntent(
                            dayBlock.intent, dayBlock.blockNumber)
                        .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 12,
                        spreadRadius: -4,
                      ),
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.1),
                        offset: const Offset(0, 1),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: BlockUtils.getColorForIntent(
                                  dayBlock.intent, dayBlock.blockNumber)
                              .withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.layers_rounded,
                          size: 14,
                          color: BlockUtils.getColorForIntent(
                              dayBlock.intent, dayBlock.blockNumber),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          dayBlock.intent.toUpperCase(),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: BlockUtils.getColorForIntent(
                                dayBlock.intent, dayBlock.blockNumber),
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 8),
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
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
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
    final blockColor = block != null
        ? BlockUtils.getColorForIntent(block!.intent, block!.blockNumber)
        : null;

    // Background tint logic for blocks (subtle)
    final Color blockTint =
        blockColor?.withValues(alpha: 0.05) ?? Colors.transparent;
    final Color baseBackground = isToday
        ? Theme.of(context).primaryColor.withValues(alpha: 0.05)
        : Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.5);

    return GestureDetector(
      onTap: () => ref.read(selectedDateProvider.notifier).state = day,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: Color.alphaBlend(blockTint, baseBackground),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                blurRadius: 12,
                spreadRadius: 2,
              )
            else ...[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                offset: const Offset(0, 4),
                blurRadius: 8,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: isToday ? 0.05 : 0.02),
                offset: const Offset(0, 1),
                blurRadius: 0,
              ),
            ],
          ],
          border: null, // Removed border as color change is enough
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      DateFormat('E').format(day).toUpperCase(),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isToday
                            ? Theme.of(context).primaryColor
                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.5),
                        fontSize: 9,
                        fontWeight: isToday ? FontWeight.w800 : FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      day.day.toString(),
                      style: AppTextStyles.h4.copyWith(
                        fontSize: 16,
                        color: isToday
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: isToday ? FontWeight.w800 : FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: workouts.map((w) {
                            final isCompleted = w.status == 'completed';
                            final displayColor = WorkoutTypes.getColor(w.type);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Container(
                                width: 22,
                                height: 22,
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
                                    size: 11,
                                    color: displayColor,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (blockColor != null)
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: blockColor,
                    boxShadow: [
                      BoxShadow(
                        color: blockColor.withValues(alpha: 0.4),
                        blurRadius: 4,
                        offset: const Offset(0, -1),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: -2,
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 0,
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 24),
      ),
    );
  }
}
