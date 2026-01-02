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
import '../../../shared/presentation/widgets/ash_text_field.dart';
import '../../../shared/presentation/widgets/ash_option_slider.dart';

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

    _gender = state.gender ?? 'Other';
    _weightUnit = state.preferredWeightUnit;
    _heightUnit = state.preferredHeightUnit;

    if (state.height != null) {
      if (_heightUnit == 'cm') {
        _heightController.text = state.height.toString();
      } else {
        final totalInches = state.height!;
        final feet = (totalInches / 12).floor();
        final inches = totalInches % 12;
        _feetController.text = feet.toString();
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
        final cmProfile = double.tryParse(_heightController.text);
        if (cmProfile != null) {
          final totalInches = cmProfile / 2.54;
          final feet = (totalInches / 12).floor();
          final inches = totalInches % 12;
          _feetController.text = feet.toString();
          _inchesController.text =
              inches.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
        } else {
          _feetController.clear();
          _inchesController.clear();
        }
      } else {
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
                  currentStep: 4,
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
                        AshTextField(
                          label: 'Age',
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          placeholder: 'How many candle-blows?',
                        ),
                        const SizedBox(height: 24),

                        // Gender
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4, bottom: 8),
                              child: Text(
                                'GENDER',
                                style: AppTextStyles.label
                                    .copyWith(fontSize: 11, letterSpacing: 1.5),
                              ),
                            ),
                            AshOptionSlider(
                              value: _gender ?? 'Other',
                              options: const ['Male', 'Female', 'Other'],
                              onChanged: (val) => setState(() => _gender = val),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Weight
                        AshTextField(
                          label: 'Weight',
                          controller: _weightController,
                          showPrefixIcon: false,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*')),
                          ],
                          placeholder: 'Current weight',
                          suffix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AshOptionSlider(
                              value: _weightUnit,
                              options: const ['kg', 'lb'],
                              onChanged: (val) =>
                                  setState(() => _weightUnit = val),
                              width: 100,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Height
                        if (_heightUnit == 'cm')
                          AshTextField(
                            label: 'Height',
                            controller: _heightController,
                            showPrefixIcon: false,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*')),
                            ],
                            placeholder: 'Your height (cm)',
                            suffix: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AshOptionSlider(
                                value: _heightUnit,
                                options: const ['cm', 'in'],
                                onChanged: _updateHeightUnit,
                                width: 100,
                              ),
                            ),
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, bottom: 8),
                                child: Text(
                                  'HEIGHT',
                                  style: AppTextStyles.label.copyWith(
                                      fontSize: 11, letterSpacing: 1.5),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: AshTextField(
                                      label: '',
                                      hideLabel: true,
                                      showPrefixIcon: false,
                                      controller: _feetController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      placeholder: 'Feet',
                                      suffix: Container(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        alignment: Alignment.centerRight,
                                        width: 40,
                                        child: Text('ft',
                                            style: AppTextStyles.bodyMedium
                                                .copyWith(
                                                    color:
                                                        AppColors.textMuted)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: AshTextField(
                                      label: '',
                                      hideLabel: true,
                                      showPrefixIcon: false,
                                      controller: _inchesController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d*')),
                                      ],
                                      placeholder: 'Inches',
                                      suffix: Container(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        alignment: Alignment.centerRight,
                                        width: 40,
                                        child: Text('in',
                                            style: AppTextStyles.bodyMedium
                                                .copyWith(
                                                    color:
                                                        AppColors.textMuted)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  AshOptionSlider(
                                    value: _heightUnit,
                                    options: const ['cm', 'in'],
                                    onChanged: _updateHeightUnit,
                                    width: 100,
                                  ),
                                ],
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
}
