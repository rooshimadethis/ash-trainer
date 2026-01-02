import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/borders.dart';
import '../../../../core/theme/shadows.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/workout_types.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/entities/training/training_block.dart';
import '../providers/calendar_provider.dart';

/// Visual style variant for calendar day cells.
enum CalendarDayCellStyle {
  /// Expanded style for weekly view - shows full day name and workout icons
  expanded,

  /// Compact style for monthly view - shows single letter and workout dots
  compact,
}

/// A configurable day cell widget for calendar views.
///
/// Provides consistent selection/today states and decoration while allowing
/// different visual representations for weekly (expanded) vs monthly (compact) views.
class CalendarDayCell extends ConsumerWidget {
  final DateTime day;
  final List<Workout> workouts;
  final TrainingBlock? block;
  final bool isSelected;
  final CalendarDayCellStyle style;
  final double? height;

  const CalendarDayCell({
    super.key,
    required this.day,
    required this.workouts,
    this.block,
    required this.isSelected,
    this.style = CalendarDayCellStyle.expanded,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isToday = DateUtils.isSameDay(day, DateTime.now());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Background color – always neutral white/surface as per user request
    final Color backgroundColor =
        isDark ? AppColors.surface : AppColors.surfaceLight;

    // Cells are no longer bold colored, so pips/text should use standard colors
    const bool hasBoldColor = false;

    // Border color for selection/today states
    final Color borderColor = isSelected
        ? (isDark ? AppColors.retroAccent : Colors.black)
        : isToday
            ? Theme.of(context).primaryColor
            : (isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.06));

    final double borderWidth = isSelected ? AppBorders.selected : 1.5;

    return GestureDetector(
      onTap: () => ref.read(selectedDateProvider.notifier).state = day,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        height: height,
        padding: style == CalendarDayCellStyle.expanded
            ? const EdgeInsets.symmetric(vertical: 8)
            : const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppBorders.radiusMd),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          boxShadow: isSelected
              ? (isDark ? AppShadows.retroDark : AppShadows.retro)
              : [],
        ),
        child: style == CalendarDayCellStyle.expanded
            ? _buildExpandedContent(context, hasBoldColor)
            : _buildCompactContent(context, hasBoldColor),
      ),
    );
  }

  /// Expanded content for weekly view - full day name, larger number, workout icons
  Widget _buildExpandedContent(BuildContext context, bool hasBoldColor) {
    // Standard themed text colors since background is always neutral
    final textColor = Theme.of(context).colorScheme.onSurface;
    final mutedTextColor =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateFormat('E').format(day).toUpperCase(),
          style: AppTextStyles.labelSmall.copyWith(
            color: mutedTextColor,
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
            color: textColor,
            fontWeight: FontWeight.w900,
            height: 1.1,
          ),
        ),
        if (workouts.isNotEmpty) ...[
          const SizedBox(height: 6),
          ...workouts
              .take(2)
              .map((w) => _buildWorkoutPip(context, w, hasBoldColor)),
        ],
      ],
    );
  }

  /// Compact content for monthly view - single letter, small number, workout dots
  Widget _buildCompactContent(BuildContext context, bool hasBoldColor) {
    // Standard themed text colors since background is always neutral
    final textColor = Theme.of(context).colorScheme.onSurface;
    final mutedTextColor =
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4);

    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('E').format(day).substring(0, 1),
                style: AppTextStyles.labelSmall.copyWith(
                  color: mutedTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                day.day.toString(),
                style: AppTextStyles.h4.copyWith(
                  fontSize: 18,
                  color: textColor,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: workouts
                    .take(3)
                    .map((w) => _buildWorkoutPip(context, w, hasBoldColor))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Solid workout pip with workout type color
  Widget _buildWorkoutPip(
      BuildContext context, Workout workout, bool hasBoldColor) {
    final isCompleted = workout.status == 'completed';
    final pipColor = WorkoutTypes.getColor(workout.type);

    final size = style == CalendarDayCellStyle.expanded ? 18.0 : 8.0;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: style == CalendarDayCellStyle.expanded ? 0 : 1.5,
        vertical: style == CalendarDayCellStyle.expanded ? 2 : 0,
      ),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: pipColor.withValues(alpha: isCompleted ? 1.0 : 0.4),
        shape: BoxShape.circle,
        border: !isCompleted && style == CalendarDayCellStyle.expanded
            ? Border.all(color: pipColor, width: 1.5)
            : null,
      ),
      child: isCompleted && style == CalendarDayCellStyle.expanded
          ? const Center(
              child: Icon(
                Icons.check_rounded,
                size: 10,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
