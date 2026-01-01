import 'package:flutter/material.dart';
import '../../domain/entities/training/workout.dart';
import 'ash_card.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/workout_types.dart';

class WorkoutCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final typeColor = WorkoutTypes.getColor(workout.type);

    return AshCard(
      onTap: onTap,
      borderWidth: 1.0,
      borderColor:
          useWorkoutColor ? typeColor.withValues(alpha: 0.3) : AppColors.border,
      backgroundColor: useWorkoutColor
          ? typeColor.withValues(alpha: 0.1)
          : AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: typeColor.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      WorkoutTypes.getIcon(workout.type),
                      size: 14,
                      color: typeColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      WorkoutTypes.getDisplayName(workout.type).toUpperCase(),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: typeColor,
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
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: workout.status == 'completed' ||
                          workout.status == 'skipped'
                      ? typeColor
                      : Colors.transparent,
                  border: Border.all(
                    color: workout.status == 'completed' ||
                            workout.status == 'skipped'
                        ? typeColor
                        : AppColors.textSecondary.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: workout.status == 'completed'
                    ? const Icon(
                        Icons.check,
                        color: AppColors.backgroundDark,
                        size: 16,
                      )
                    : workout.status == 'skipped'
                        ? const Icon(
                            Icons.close,
                            color: AppColors.backgroundDark,
                            size: 16,
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
                Icons.schedule_rounded,
                _formatDuration(workout.plannedDuration),
              ),
              if (workout.plannedDistance != null)
                _infoTile(
                  Icons.route_rounded,
                  '${workout.plannedDistance} km',
                ),
              if (workout.intensity != null)
                _infoTile(
                  Icons.bolt_rounded,
                  workout.intensity!,
                ),
            ],
          ),
          if (workout.description != null &&
              workout.description!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              workout.description!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style:
              AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
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
