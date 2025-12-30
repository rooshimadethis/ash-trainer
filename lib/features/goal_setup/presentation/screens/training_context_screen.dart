import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../shared/presentation/widgets/ash_text_field.dart';
import '../providers/goal_setup_provider.dart';
import '../widgets/onboarding_navigation.dart';
import '../widgets/onboarding_progress.dart';
import 'personal_details_screen.dart';

class TrainingContextScreen extends ConsumerStatefulWidget {
  const TrainingContextScreen({super.key});

  @override
  ConsumerState<TrainingContextScreen> createState() =>
      _TrainingContextScreenState();
}

class _TrainingContextScreenState extends ConsumerState<TrainingContextScreen> {
  final _frequencyController = TextEditingController();
  final _volumeController = TextEditingController();

  String _runningPriority = 'Medium';
  String _strengthPriority = 'Medium';
  String _mobilityPriority = 'Medium';
  String _selectedUnit = 'km';

  @override
  void initState() {
    super.initState();
    final state = ref.read(goalSetupProvider);
    if (state.trainingFrequency != null) {
      _frequencyController.text = state.trainingFrequency.toString();
    }
    if (state.currentWeeklyVolume != null) {
      _volumeController.text = state.currentWeeklyVolume.toString();
    }
    _runningPriority = state.runningPriority ?? 'Medium';
    _strengthPriority = state.strengthPriority ?? 'Medium';
    _mobilityPriority = state.mobilityPriority ?? 'Medium';
    _selectedUnit = state.preferredDistanceUnit;
  }

  @override
  void dispose() {
    _frequencyController.dispose();
    _volumeController.dispose();
    super.dispose();
  }

  void _updatePriority(String pillar, String priority) {
    setState(() {
      // If setting to High, downgrade any other High to Medium
      if (priority == 'High') {
        if (pillar != 'Running' && _runningPriority == 'High') {
          _runningPriority = 'Medium';
        }
        if (pillar != 'Strength' && _strengthPriority == 'High') {
          _strengthPriority = 'Medium';
        }
        if (pillar != 'Mobility' && _mobilityPriority == 'High') {
          _mobilityPriority = 'Medium';
        }
      }

      switch (pillar) {
        case 'Running':
          _runningPriority = priority;
          break;
        case 'Strength':
          _strengthPriority = priority;
          break;
        case 'Mobility':
          _mobilityPriority = priority;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                const OnboardingProgress(
                  currentStep: 3, // Logic: Goal Details was 2, this is 3
                  label: 'Training Context',
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How are you training?',
                          style: AppTextStyles.h2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Help me understand your current load and priorities.',
                          style: AppTextStyles.bodyLarge,
                        ),
                        const SizedBox(height: 32),
                        _buildHistorySection(),
                        const SizedBox(height: 32),
                        _buildPrioritiesSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: OnboardingNavigation(
              onNext: () {
                ref.read(goalSetupProvider.notifier)
                  ..setTrainingContext(
                    frequency: int.tryParse(_frequencyController.text),
                    volume: double.tryParse(_volumeController.text),
                    distanceUnit: _selectedUnit,
                  )
                  ..setPillarPriorities(
                    running: _runningPriority,
                    strength: _strengthPriority,
                    mobility: _mobilityPriority,
                  )
                  ..nextStep();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PersonalDetailsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('TRAINING HISTORY', style: AppTextStyles.label),
        const SizedBox(height: 16),
        AshTextField(
          label: 'Days per week (avg)',
          controller: _frequencyController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          placeholder: 'e.g. 3',
        ),
        const SizedBox(height: 16),
        AshTextField(
          label: 'Weekly Volume',
          controller: _volumeController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          placeholder: 'e.g. 25',
          suffix: _buildUnitToggle(),
        ),
      ],
    );
  }

  Widget _buildPrioritiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PILLAR PRIORITIES (MAX 1 HIGH)', style: AppTextStyles.label),
        const SizedBox(height: 16),
        _buildPriorityRow('Running', _runningPriority, Icons.directions_run),
        const SizedBox(height: 12),
        _buildPriorityRow('Strength', _strengthPriority, Icons.fitness_center),
        const SizedBox(height: 12),
        _buildPriorityRow(
            'Mobility', _mobilityPriority, Icons.self_improvement),
      ],
    );
  }

  Widget _buildPriorityRow(
      String pillar, String currentPriority, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceHighlight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(pillar, style: AppTextStyles.h3.copyWith(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: ['Low', 'Medium', 'High'].map((priority) {
              final isSelected = currentPriority == priority;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GestureDetector(
                    onTap: () => _updatePriority(pillar, priority),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? _getPriorityColor(priority)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? _getPriorityColor(priority)
                              : AppColors.divider,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          priority,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.textSecondary,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return AppColors.primary; // Or a specific "High" color if we have one
      case 'Low':
        return AppColors.textSecondary; // Or a muted color
      default:
        return AppColors.primary.withValues(alpha: 0.7);
    }
  }

  Widget _buildUnitToggle() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: ['km', 'mi'].map((unit) {
          final isSelected = _selectedUnit == unit;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedUnit = unit;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                unit.toUpperCase(),
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
