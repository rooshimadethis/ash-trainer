import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../providers/goal_setup_provider.dart';
import '../widgets/onboarding_navigation.dart';
import '../widgets/onboarding_progress.dart';
import 'availability_screen.dart';

class PersonalDetailsScreen extends ConsumerStatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  ConsumerState<PersonalDetailsScreen> createState() =>
      _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends ConsumerState<PersonalDetailsScreen> {
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  // New controllers for split input
  final _feetController = TextEditingController();
  final _inchesController = TextEditingController();

  String? _gender;
  String _weightUnit = 'kg';
  String _heightUnit = 'cm';

  @override
  void initState() {
    super.initState();
    final state = ref.read(goalSetupProvider);
    if (state.age != null) _ageController.text = state.age.toString();
    if (state.weight != null) _weightController.text = state.weight.toString();

    _gender = state.gender;
    _weightUnit = state.preferredWeightUnit;
    _heightUnit = state.preferredHeightUnit;

    // Handle height initialization
    if (state.height != null) {
      if (_heightUnit == 'cm') {
        _heightController.text = state.height.toString();
      } else {
        // Convert stored total inches to feet/inches
        // Assuming state.height is stored in the preferred unit (inches) if unit is 'in'
        final totalInches = state.height!;
        final feet = (totalInches / 12).floor();
        final inches = totalInches % 12;
        _feetController.text = feet.toString();
        // Show inches with optional decimal, but usually 0 decimal for height is fine
        // Using toStringAsFixed(0) or similar logic if integer preferred
        _inchesController.text = inches == inches.roundToDouble()
            ? inches.toInt().toString()
            : inches.toString();
      }
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _feetController.dispose();
    _inchesController.dispose();
    super.dispose();
  }

  void _updateHeightUnit(String newUnit) {
    if (_heightUnit == newUnit) return;

    setState(() {
      if (newUnit == 'in') {
        // Convert FROM cm TO feet/inches
        final cmProfile = double.tryParse(_heightController.text);
        if (cmProfile != null) {
          final totalInches = cmProfile / 2.54;
          final feet = (totalInches / 12).floor();
          final inches = totalInches % 12;

          _feetController.text = feet.toString();
          // Keep max 1 decimal place for cleaner UI
          _inchesController.text =
              inches.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
        } else {
          _feetController.clear();
          _inchesController.clear();
        }
      } else {
        // Convert FROM feet/inches TO cm
        final feet = int.tryParse(_feetController.text) ?? 0;
        final inches = double.tryParse(_inchesController.text) ?? 0.0;

        if (feet > 0 || inches > 0) {
          final totalInches = (feet * 12) + inches;
          final cm = totalInches * 2.54;
          _heightController.text =
              cm.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
        } else {
          _heightController.clear();
        }
      }
      _heightUnit = newUnit;
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
                  currentStep: 3,
                  label: 'Personal Details',
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'A bit about you...',
                          style: AppTextStyles.h2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This helps me personalize your training and understand your body better.',
                          style: AppTextStyles.bodyLarge,
                        ),
                        const SizedBox(height: 32),

                        // Age
                        _buildLabel('Age'),
                        TextField(
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: AppTextStyles.bodyLarge
                              .copyWith(color: AppColors.white),
                          decoration:
                              _buildInputDecoration('How many candle-blows?'),
                        ),
                        const SizedBox(height: 24),

                        // Gender
                        _buildLabel('Gender'),
                        Row(
                          children: [
                            _buildGenderChip('Male'),
                            const SizedBox(width: 8),
                            _buildGenderChip('Female'),
                            const SizedBox(width: 8),
                            _buildGenderChip('Other'),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Weight
                        _buildLabel('Weight'),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _weightController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*')),
                                ],
                                style: AppTextStyles.bodyLarge
                                    .copyWith(color: AppColors.white),
                                decoration:
                                    _buildInputDecoration('Current weight'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.surfaceHighlight,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.divider),
                              ),
                              child: Row(
                                children: [
                                  _buildUnitButton('kg'),
                                  _buildUnitButton('lb'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Height
                        _buildLabel('Height'),
                        Row(
                          children: [
                            Expanded(
                              child: _heightUnit == 'cm'
                                  ? TextField(
                                      controller: _heightController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d*')),
                                      ],
                                      style: AppTextStyles.bodyLarge
                                          .copyWith(color: AppColors.white),
                                      decoration:
                                          _buildInputDecoration('Your height'),
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: _feetController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: AppTextStyles.bodyLarge
                                                .copyWith(
                                                    color: AppColors.white),
                                            decoration:
                                                _buildInputDecoration('Feet')
                                                    .copyWith(suffixText: "ft"),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: TextField(
                                            controller: _inchesController,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d*\.?\d*')),
                                            ],
                                            style: AppTextStyles.bodyLarge
                                                .copyWith(
                                                    color: AppColors.white),
                                            decoration:
                                                _buildInputDecoration('Inches')
                                                    .copyWith(suffixText: "in"),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.surfaceHighlight,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.divider),
                              ),
                              child: Row(
                                children: [
                                  _buildHeightUnitButton('cm'),
                                  _buildHeightUnitButton('in'),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                final age = int.tryParse(_ageController.text);
                final weight = double.tryParse(_weightController.text);

                double? height;
                if (_heightUnit == 'cm') {
                  height = double.tryParse(_heightController.text);
                } else {
                  final feet = double.tryParse(_feetController.text) ?? 0;
                  final inches = double.tryParse(_inchesController.text) ?? 0;
                  // Only save if at least one value is entered to avoid saving 0.0 for empty form
                  if (feet > 0 || inches > 0) {
                    height = (feet * 12) + inches;
                  }
                }

                ref.read(goalSetupProvider.notifier).setPersonalDetails(
                      age: age,
                      gender: _gender,
                      weight: weight,
                      weightUnit: _weightUnit,
                      height: height,
                      heightUnit: _heightUnit,
                    );

                ref.read(goalSetupProvider.notifier).nextStep();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AvailabilityScreen()),
                );
              },
            ),
          ),
        ],
      ),
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

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle:
          TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.5)),
      filled: true,
      fillColor: AppColors.surfaceHighlight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    );
  }

  Widget _buildGenderChip(String label) {
    final isSelected = _gender == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _gender = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surfaceHighlight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.divider,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isSelected ? AppColors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnitButton(String unit) {
    final isSelected = _weightUnit == unit;
    return GestureDetector(
      onTap: () => setState(() => _weightUnit = unit),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          unit,
          style: AppTextStyles.bodySmall.copyWith(
            color: isSelected ? AppColors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildHeightUnitButton(String unit) {
    final isSelected = _heightUnit == unit;
    return GestureDetector(
      // Use the new update method
      onTap: () => _updateHeightUnit(unit),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          unit,
          style: AppTextStyles.bodySmall.copyWith(
            color: isSelected ? AppColors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
