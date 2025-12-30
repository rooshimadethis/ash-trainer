import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/domain/entities/goal.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../shared/presentation/widgets/ash_text_field.dart';
import '../providers/goal_setup_provider.dart';
import '../widgets/onboarding_navigation.dart';
import '../widgets/onboarding_progress.dart';
import 'personal_details_screen.dart';

class GoalDetailsScreen extends ConsumerStatefulWidget {
  const GoalDetailsScreen({super.key});

  @override
  ConsumerState<GoalDetailsScreen> createState() => _GoalDetailsScreenState();
}

class _GoalDetailsScreenState extends ConsumerState<GoalDetailsScreen> {
  // Common Controllers
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _customDistanceController =
      TextEditingController();
  final TextEditingController _targetTimeController = TextEditingController();
  final TextEditingController _currentBestTimeController =
      TextEditingController();

  // Local state for temporary values before pushing to provider
  double? _selectedDistance;
  DateTime? _selectedDate;
  int? _maintenanceFreq;
  int? _maintenanceDuration;

  @override
  void initState() {
    super.initState();
    // Initialize state from provider if available (for back navigation)
    final state = ref.read(goalSetupProvider);
    _eventNameController.text = state.eventName ?? '';

    // Handle distance initialization (check if it's a standard one or custom)
    if (state.targetDistance != null) {
      const standardDistances = [5.0, 10.0, 21.1, 42.2];
      if (standardDistances.contains(state.targetDistance)) {
        _selectedDistance = state.targetDistance;
      } else {
        _selectedDistance = -1.0; // Custom
        _customDistanceController.text = state.targetDistance.toString();
      }
    }

    _selectedDate = state.targetDate ?? state.eventDate ?? state.endDate;

    if (state.targetTime != null) {
      _targetTimeController.text = _formatDuration(state.targetTime!);
    }

    if (state.currentBestTime != null) {
      _currentBestTimeController.text = _formatDuration(state.currentBestTime!);
    }

    _maintenanceFreq = state.maintenanceFrequency;
    _maintenanceDuration = state.maintenanceDuration;
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _customDistanceController.dispose();
    _targetTimeController.dispose();
    _currentBestTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(goalSetupProvider);

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
                  currentStep: 2,
                  label: 'Goal Details',
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: _buildFormBody(context, state.selectedGoalType!),
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
                _saveState(state.selectedGoalType!);
                ref.read(goalSetupProvider.notifier).nextStep();
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

  String _getTitle(GoalType? type) {
    switch (type) {
      case GoalType.distanceMilestone:
        return 'Distance Goal';
      case GoalType.timePerformance:
        return 'Time Goal';
      case GoalType.event:
        return 'Event Details';
      case GoalType.maintenance:
        return 'Maintenance';
      default:
        return 'Goal Details';
    }
  }

  Widget _buildFormBody(BuildContext context, GoalType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getTitle(type),
          style: AppTextStyles.h2,
        ),
        const SizedBox(height: 24),
        _buildContent(type),
      ],
    );
  }

  Widget _buildContent(GoalType type) {
    switch (type) {
      case GoalType.distanceMilestone:
        return _buildDistanceForm();
      case GoalType.timePerformance:
        return _buildTimeForm();
      case GoalType.event:
        return _buildEventForm();
      case GoalType.maintenance:
        return _buildMaintenanceForm();
    }
  }

  Widget _buildDistanceForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What distance are we conquering?', style: AppTextStyles.h3),
        const SizedBox(height: 16),
        _buildDistanceDropdown(),
        if (_selectedDistance == -1.0) ...[
          const SizedBox(height: 16),
          AshTextField(
            label: 'Custom Distance (km)',
            controller: _customDistanceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            placeholder: 'e.g. 15.5',
          ),
        ],
        const SizedBox(height: 24),
        Text('Target Date (Optional)', style: AppTextStyles.h3),
        const SizedBox(height: 8),
        _buildDatePicker(GoalType.distanceMilestone,
            distance: _selectedDistance),
      ],
    );
  }

  Widget _buildTimeForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What time are we chasing?', style: AppTextStyles.h3),
        const SizedBox(height: 16),
        _buildDistanceDropdown(),
        if (_selectedDistance == -1.0) ...[
          const SizedBox(height: 16),
          AshTextField(
            label: 'Custom Distance (km)',
            controller: _customDistanceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            placeholder: 'e.g. 5.0',
          ),
        ],
        const SizedBox(height: 16),
        AshTextField(
          label: 'Target Time (HH:MM:SS)',
          controller: _targetTimeController,
          placeholder: 'e.g. 00:25:00',
        ),
        const SizedBox(height: 16),
        AshTextField(
          label: 'Current Best (Optional)',
          controller: _currentBestTimeController,
          placeholder: 'e.g. 00:28:30',
        ),
      ],
    );
  }

  Widget _buildEventForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tell me about this race!', style: AppTextStyles.h3),
        const SizedBox(height: 16),
        AshTextField(
          label: 'Event Name',
          controller: _eventNameController,
          placeholder: 'e.g. Austin Marathon',
        ),
        const SizedBox(height: 16),
        _buildLabel('Race Date'),
        _buildDatePicker(GoalType.event, distance: _selectedDistance),
        const SizedBox(height: 16),
        _buildDistanceDropdown(),
        if (_selectedDistance == -1.0) ...[
          const SizedBox(height: 16),
          AshTextField(
            label: 'Custom Distance (km)',
            controller: _customDistanceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            placeholder: 'e.g. 21.1',
          ),
        ],
        const SizedBox(height: 16),
        AshTextField(
          label: 'Target Time (Optional)',
          controller: _targetTimeController,
          placeholder: 'e.g. 03:45:00',
        ),
      ],
    );
  }

  Widget _buildMaintenanceForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Maintenance Plan', style: AppTextStyles.h3),
        const SizedBox(height: 16),
        Text('Runs per week: ${_maintenanceFreq ?? 3}',
            style: AppTextStyles.body),
        Slider(
          value: (_maintenanceFreq ?? 3).toDouble(),
          min: 1,
          max: 7,
          divisions: 6,
          label: '${_maintenanceFreq ?? 3}',
          onChanged: (val) => setState(() => _maintenanceFreq = val.round()),
        ),
        const SizedBox(height: 16),
        Slider(
          value: (_maintenanceDuration ?? 30).toDouble(),
          min: 15,
          max: 90,
          divisions: 15,
          label: '${_maintenanceDuration ?? 30}',
          onChanged: (val) =>
              setState(() => _maintenanceDuration = val.round()),
        ),
        const SizedBox(height: 16),
        _buildLabel('Maintaining until (Optional)'),
        _buildDatePicker(GoalType.maintenance),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.label,
      ),
    );
  }

  Widget _buildDatePicker(GoalType type, {double? distance}) {
    return GestureDetector(
      onTap: () async {
        final now = DateTime.now();
        final defaultFutureDate =
            _getDefaultDateForType(type, now, distance: distance);

        final date = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? defaultFutureDate,
          firstDate: now,
          lastDate: now.add(const Duration(days: 365 * 2)),
        );
        if (date != null) setState(() => _selectedDate = date);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(12),
          color: AppColors.surfaceHighlight,
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today,
                color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 12),
            Text(
              _selectedDate == null
                  ? 'Select Date'
                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              style: AppTextStyles.body.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    required String hint,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceHighlight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          hint: Text(hint, style: TextStyle(color: AppColors.textSecondary)),
          dropdownColor: AppColors.surfaceHighlight,
          style: AppTextStyles.body.copyWith(color: AppColors.white),
          isExpanded: true,
        ),
      ),
    );
  }

  Widget _buildDistanceDropdown() {
    return _buildDropdown<double>(
      value: _selectedDistance,
      items: const [
        DropdownMenuItem(value: 5.0, child: Text('5K (3.1 mi)')),
        DropdownMenuItem(value: 10.0, child: Text('10K (6.2 mi)')),
        DropdownMenuItem(value: 21.1, child: Text('Half Marathon (13.1 mi)')),
        DropdownMenuItem(value: 42.2, child: Text('Marathon (26.2 mi)')),
        DropdownMenuItem(value: -1.0, child: Text('Custom Distance')),
      ],
      onChanged: (val) => setState(() => _selectedDistance = val),
      hint: 'Select Distance',
    );
  }

  void _saveState(GoalType type) {
    final notifier = ref.read(goalSetupProvider.notifier);

    switch (type) {
      case GoalType.distanceMilestone:
        notifier.setDistanceMilestoneDetails(
          distance: _selectedDistance == -1.0
              ? double.tryParse(_customDistanceController.text)
              : _selectedDistance,
          date: _selectedDate,
        );
        break;
      case GoalType.timePerformance:
        notifier.setTimePerformanceDetails(
          distance: _selectedDistance == -1.0
              ? double.tryParse(_customDistanceController.text)
              : _selectedDistance,
          time: _parseDuration(_targetTimeController.text),
          currentBest: _parseDuration(_currentBestTimeController.text),
        );
        break;
      case GoalType.event:
        notifier.setEventDetails(
          name: _eventNameController.text,
          date: _selectedDate,
          distance: _selectedDistance == -1.0
              ? double.tryParse(_customDistanceController.text)
              : _selectedDistance,
          time: _parseDuration(_targetTimeController.text),
        );
        break;
      case GoalType.maintenance:
        notifier.setMaintenanceDetails(
          frequency: _maintenanceFreq,
          duration: _maintenanceDuration,
          end: _selectedDate,
        );
        break;
    }
  }

  int? _parseDuration(String text) {
    if (text.isEmpty) return null;
    try {
      final parts = text.split(':');
      if (parts.length == 3) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        final seconds = int.parse(parts[2]);
        return hours * 3600 + minutes * 60 + seconds;
      }
      if (parts.length == 2) {
        final minutes = int.parse(parts[0]);
        final seconds = int.parse(parts[1]);
        return minutes * 60 + seconds;
      }
      if (parts.length == 1) {
        return int.parse(parts[0]) * 60;
      }
    } catch (_) {}
    return null;
  }

  String _formatDuration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  DateTime _getDefaultDateForType(GoalType type, DateTime now,
      {double? distance}) {
    switch (type) {
      case GoalType.event:
      case GoalType.distanceMilestone:
      case GoalType.timePerformance:
        int weeks = 12;
        if (distance != null && distance > 0) {
          if (distance <= 5.0) {
            weeks = 8;
          } else if (distance <= 10.0) {
            weeks = 12;
          } else if (distance <= 21.1) {
            weeks = 16;
          } else {
            weeks = 20;
          }
        } else if (type == GoalType.event) {
          weeks = 16;
        }
        return now.add(Duration(days: 7 * weeks));

      case GoalType.maintenance:
        return now.add(const Duration(days: 7 * 8));
    }
  }
}
