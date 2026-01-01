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
    // Get user's preferred distance unit
    final preferredUnit = ref.watch(preferredDistanceUnitProvider);

    return AshCard(
      onTap: onTap,
      borderWidth: 1.0,
      borderColor: useWorkoutColor
          ? typeColor.withValues(alpha: 0.3)
          : Theme.of(context).colorScheme.outline,
      backgroundColor: useWorkoutColor
          ? typeColor.withValues(alpha: 0.1)
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
                  color: typeColor,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      WorkoutTypes.getIcon(workout.type),
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      WorkoutTypes.getDisplayName(workout.type).toUpperCase(),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
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
                      ? typeColor
                      : Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: workout.status == 'completed'
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 18,
                      )
                    : workout.status == 'skipped'
                        ? const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 18,
                          )
                        : null,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            workout.name,
            style: AppTextStyles.h3.copyWith(height: 1.2),
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
                ),
              if (workout.intensity != null)
                _infoTile(
                  context,
                  Icons.bolt_rounded,
                  'RPE ${workout.intensity}',
                ),
            ],
          ),
          if (workout.description != null &&
              workout.description!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              workout.description!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: useWorkoutColor
                    ? Colors.black.withValues(alpha: 0.7)
                    : Theme.of(context).colorScheme.onSurfaceVariant,
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

  Widget _infoTile(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon,
            size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.bodySmall
              .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
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
