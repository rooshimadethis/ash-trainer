import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/animations.dart';
import '../../../shared/domain/entities/time_off_entry.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/entities/training/training_block.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../shared/presentation/widgets/workout_card.dart';
import '../../../shared/presentation/widgets/animated_entry.dart';
import '../providers/time_off_provider.dart';
import '../screens/workout_detail_screen.dart';
import 'package:collection/collection.dart';

/// Displays the workout list for a selected day, including training block info.
///
/// This widget is shared between WeeklyView and MonthlyView to ensure
/// consistent presentation of daily workout details.
class SelectedDayWorkoutList extends ConsumerWidget {
  final DateTime selectedDate;
  final List<Workout> allWorkouts;
  final List<TrainingBlock> blocks;
  final List<TimeOffEntry>? timeOffs;

  const SelectedDayWorkoutList({
    super.key,
    required this.selectedDate,
    required this.allWorkouts,
    required this.blocks,
    this.timeOffs,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayWorkouts = allWorkouts
        .where((w) => DateUtils.isSameDay(w.scheduledDate, selectedDate))
        .toList();

    // Check for Time Off on this day
    final timeOffEntry = timeOffs?.firstWhereOrNull((t) {
      final isStart = DateUtils.isSameDay(selectedDate, t.startDate);
      final isEnd = DateUtils.isSameDay(selectedDate, t.endDate);
      final isBetween =
          selectedDate.isAfter(t.startDate) && selectedDate.isBefore(t.endDate);
      return isStart || isEnd || isBetween;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const SizedBox(height: 24),
        if (timeOffEntry != null) ...[
          _buildTimeOffCard(context, ref, timeOffEntry),
          if (dayWorkouts.isNotEmpty) const SizedBox(height: 16),
        ],
        if (dayWorkouts.isEmpty && timeOffEntry == null)
          _buildEmptyState()
        else
          AnimatedSwitcher(
            duration: AppAnimations.normal,
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: _buildWorkoutCards(context, dayWorkouts),
          ),
      ],
    );
  }

  Widget _buildTimeOffCard(
      BuildContext context, WidgetRef ref, TimeOffEntry entry) {
    // Check if entry spans multiple days
    final isMultiDay = !DateUtils.isSameDay(entry.startDate, entry.endDate);

    return AshCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      backgroundColor: const Color(0xFF111111),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.pause_circle_outline_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time Off'.toUpperCase(),
                  style: AppTextStyles.labelLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                if (entry.reason != null && entry.reason!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      entry.reason!,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                if (isMultiDay)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${DateFormat('MMM d').format(entry.startDate)} - ${DateFormat('MMM d').format(entry.endDate)}',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 10,
                          color: Colors.white.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () =>
                _handleDeleteTimeOff(context, ref, entry, isMultiDay),
            icon: Icon(
              Icons.delete_outline_rounded,
              color: Colors.white.withValues(alpha: 0.4),
              size: 20,
            ),
            tooltip: 'Remove Time Off',
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleDeleteTimeOff(BuildContext context, WidgetRef ref,
      TimeOffEntry entry, bool isMultiDay) async {
    final controller = ref.read(timeOffControllerProvider.notifier);

    if (!isMultiDay) {
      // Simple delete for single day
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Remove Time Off?', style: AppTextStyles.h3),
          content: Text(
            'This will remove the time off entry for this day.',
            style: AppTextStyles.body,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('CANCEL',
                  style: AppTextStyles.buttonText
                      .copyWith(color: AppColors.textMuted)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('REMOVE',
                  style: AppTextStyles.buttonText.copyWith(color: Colors.red)),
            ),
          ],
        ),
      );

      if (confirm == true) {
        await controller.deleteTimeOff(entry.id);
      }
    } else {
      // Options for multi-day
      await showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit Time Off',
                  style: AppTextStyles.h3,
                ),
                const SizedBox(height: 8),
                Text(
                  'This day is part of a longer time off period (${DateFormat('MMM d').format(entry.startDate)} - ${DateFormat('MMM d').format(entry.endDate)}).',
                  style:
                      AppTextStyles.body.copyWith(color: AppColors.textMuted),
                ),
                const SizedBox(height: 24),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.today_rounded),
                  title: const Text('Remove Only This Day'),
                  subtitle: Text(
                      'Split the time off to exclude ${DateFormat('MMM d').format(selectedDate)}'),
                  onTap: () async {
                    Navigator.pop(context);
                    await controller.removeDayFromTimeOff(entry, selectedDate);
                  },
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading:
                      const Icon(Icons.delete_sweep_rounded, color: Colors.red),
                  title: const Text('Delete Entire Period',
                      style: TextStyle(color: Colors.red)),
                  subtitle:
                      const Text('Remove time off for all days in this range'),
                  onTap: () async {
                    Navigator.pop(context);
                    await controller.deleteTimeOff(entry.id);
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('CANCEL', style: AppTextStyles.buttonText),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
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
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.nightlight_round,
              size: 48,
              color: AppColors.textMuted.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No workouts scheduled',
              style:
                  AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutCards(BuildContext context, List<Workout> workouts) {
    // Unique key that changes when workouts change significantly
    final contentHash = workouts.fold(
        '',
        (prev, w) =>
            '$prev${w.id}${w.status}${w.scheduledDate.millisecondsSinceEpoch}');

    return Column(
      key: ValueKey(
          'workouts_${selectedDate.millisecondsSinceEpoch}_$contentHash'),
      children: List.generate(workouts.length, (index) {
        final workout = workouts[index];
        return Padding(
          padding:
              EdgeInsets.only(bottom: index == workouts.length - 1 ? 0 : 16),
          child: AnimatedEntry(
            index: index,
            child: WorkoutCard(
              workout: workout,
              useWorkoutColor: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutDetailScreen(workout: workout),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
