import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../../core/utils/logger.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../../data/providers/repository_providers.dart';
import '../../../training/presentation/providers/automation_provider.dart';

class WorkoutLoggingScreen extends ConsumerStatefulWidget {
  final Workout workout;

  const WorkoutLoggingScreen({super.key, required this.workout});

  @override
  ConsumerState<WorkoutLoggingScreen> createState() =>
      _WorkoutLoggingScreenState();
}

class _WorkoutLoggingScreenState extends ConsumerState<WorkoutLoggingScreen> {
  late int _durationMinutes;
  late double? _distance;
  int _rpe = 5;
  bool _isSubmitting = false;

  // Controllers to fix input field behavior
  late final TextEditingController _durationController;
  late final TextEditingController _distanceController;

  @override
  void initState() {
    super.initState();
    _durationMinutes = widget.workout.plannedDuration ~/ 60;
    _distance = widget.workout.plannedDistance;

    _durationController =
        TextEditingController(text: _durationMinutes.toString());
    _distanceController =
        TextEditingController(text: _distance?.toString() ?? '');
  }

  @override
  void dispose() {
    _durationController.dispose();
    _distanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = widget.workout.type.contains('run');
    // Use workout-specific theme instead of global app theme
    final workoutTheme = ref.watch(workoutThemeProvider(widget.workout));
    print(
        'DEBUG: Workout logging screen theme primary: ${workoutTheme.colorScheme.primary}');

    return Theme(
      data: workoutTheme,
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: AppColors.textPrimary),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('Log Workout', style: AppTextStyles.h3),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.workout.name, style: AppTextStyles.h2),
                const SizedBox(height: 8),
                Text(
                  'How did it go? Enter your actuals below.',
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 32),

                // Duration Input
                Text('DURATION (MINUTES)',
                    style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 12),
                TextField(
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  style: AppTextStyles.h1
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                  decoration: const InputDecoration(
                    hintText: '0',
                    suffixText: 'min',
                  ),
                  onChanged: (val) {
                    setState(() => _durationMinutes = int.tryParse(val) ?? 0);
                  },
                ),

                const SizedBox(height: 32),

                // Distance Input (Conditional)
                if (isRunning) ...[
                  Text('DISTANCE (KM)',
                      style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _distanceController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: AppTextStyles.h1
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                    decoration: const InputDecoration(
                      hintText: '0.0',
                      suffixText: 'km',
                    ),
                    onChanged: (val) {
                      setState(() => _distance = double.tryParse(val));
                    },
                  ),
                  const SizedBox(height: 32),
                ],

                // RPE Picker
                Text('EFFORT (RPE 1-10)',
                    style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                Text(
                  _getRpeDescription(_rpe),
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 16),
                Slider(
                  value: _rpe.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveColor: AppColors.surfaceDark,
                  onChanged: (val) => setState(() => _rpe = val.round()),
                ),
                // Slider labels - using Stack for precise alignment
                SizedBox(
                  height: 20,
                  child: Stack(
                    children: List.generate(
                      10,
                      (i) {
                        final totalWidth =
                            MediaQuery.of(context).size.width - 48;
                        final usableWidth = totalWidth - 40;
                        final position = 20 + (usableWidth / 9) * i;

                        return Positioned(
                          left: position,
                          child: Transform.translate(
                            offset: const Offset(-5, 0),
                            child: Text(
                              '${i + 1}',
                              style: AppTextStyles.labelSmall,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 48),

                AshButton(
                  label: _isSubmitting ? 'Saving...' : 'Complete Workout',
                  onPressed: _isSubmitting ? null : _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getRpeDescription(int rpe) {
    if (rpe <= 2) {
      return 'Very Light - Easy to breathe and talk';
    }
    if (rpe <= 4) {
      return 'Light - Moderate breathing, can hold conversation';
    }
    if (rpe <= 6) {
      return 'Moderate - Heavy breathing, can speak in short sentences';
    }
    if (rpe <= 8) {
      return 'Hard - Very heavy breathing, can only say a few words';
    }
    return 'Max Effort - Gasping for air, cannot talk';
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);

    final updatedWorkout = widget.workout.copyWith(
      status: 'completed',
      actualDuration: _durationMinutes * 60,
      actualDistance: _distance,
      rpe: _rpe,
      completedAt: DateTime.now(),
      syncedFrom: 'manual',
    );

    try {
      await ref.read(workoutRepositoryProvider).logWorkout(updatedWorkout);

      // Trigger automation
      await ref.read(trainingAutomationProvider).onWorkoutAction();

      if (mounted) {
        Navigator.pop(context); // Close logging screen
        Navigator.pop(context); // Close detail screen to show updated status
      }
    } catch (e, stack) {
      AppLogger.error('Failed to log workout', e, stack);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save workout: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
