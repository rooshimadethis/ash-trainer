import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/training/workout.dart';
import 'ash_card.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/workout_types.dart';
import '../../../../core/utils/unit_converter.dart';
import '../providers/user_provider.dart';

class WorkoutCard extends ConsumerWidget {
  final Workout workout;
  final VoidCallback? onTap;
  final bool useWorkoutColor;

  const WorkoutCard({
    super.key,
    required this.workout,
    this.onTap,
    this.useWorkoutColor = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeColor = WorkoutTypes.getColor(workout.type);
    final preferredUnit = ref.watch(preferredDistanceUnitProvider);

    // Simplified: Always white on tinted backgrounds as requested
    final Color contentColor = useWorkoutColor
        ? Colors.white
        : Theme.of(context).colorScheme.onSurface;

    final secondaryContentColor = useWorkoutColor
        ? Colors.white.withValues(alpha: 0.7)
        : Theme.of(context).colorScheme.onSurfaceVariant;

    return AshCard(
      onTap: onTap,
      borderWidth: 1.0,
      borderColor: useWorkoutColor
          ? typeColor.withValues(alpha: 0.3)
          : Theme.of(context).colorScheme.outline,
      backgroundColor: useWorkoutColor
          ? typeColor // Use the strong color as requested
          : Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: contentColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: contentColor.withValues(alpha: 0.15), width: 1.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      WorkoutTypes.getIcon(workout.type),
                      size: 14,
                      color: contentColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      WorkoutTypes.getDisplayName(workout.type).toUpperCase(),
                      style: AppTextStyles.labelLarge.copyWith(
                        color: contentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: workout.status == 'completed' ||
                          workout.status == 'skipped'
                      ? contentColor.withValues(alpha: 0.2)
                      : Colors.transparent,
                  border: Border.all(
                    color: contentColor.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: workout.status == 'completed'
                    ? Icon(
                        Icons.check_rounded,
                        color: contentColor,
                        size: 18,
                      )
                    : workout.status == 'skipped'
                        ? Icon(
                            Icons.close_rounded,
                            color: contentColor,
                            size: 18,
                          )
                        : null,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            workout.name,
            style: AppTextStyles.h3.copyWith(
              height: 1.2,
              color: contentColor,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _infoTile(
                context,
                Icons.schedule_rounded,
                _formatDuration(workout.plannedDuration),
                secondaryContentColor,
              ),
              if (workout.plannedDistance != null &&
                  workout.plannedDistance! > 0)
                _infoTile(
                  context,
                  Icons.route_rounded,
                  UnitConverter.formatDistance(
                      UnitConverter.convertDistanceFromKm(
                          workout.plannedDistance!, preferredUnit),
                      preferredUnit),
                  secondaryContentColor,
                ),
              if (workout.intensity != null)
                _infoTile(
                  context,
                  Icons.bolt_rounded,
                  'RPE ${workout.intensity}',
                  secondaryContentColor,
                ),
            ],
          ),
          if (workout.description != null &&
              workout.description!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              workout.description!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: secondaryContentColor,
                height: 1.5,
                fontWeight: useWorkoutColor ? FontWeight.w600 : FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoTile(
      BuildContext context, IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.bodySmall.copyWith(color: color),
        ),
      ],
    );
  }

  String _formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
