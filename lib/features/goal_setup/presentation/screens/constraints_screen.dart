import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../shared/presentation/widgets/ash_text_field.dart';
import '../providers/goal_setup_provider.dart';
import '../widgets/onboarding_navigation.dart';
import '../widgets/onboarding_progress.dart';
import 'health_permissions_screen.dart';

class ConstraintsScreen extends ConsumerStatefulWidget {
  const ConstraintsScreen({super.key});

  @override
  ConsumerState<ConstraintsScreen> createState() => _ConstraintsScreenState();
}

class _ConstraintsScreenState extends ConsumerState<ConstraintsScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initialValue = ref.read(goalSetupProvider).constraints;
    _controller = TextEditingController(text: initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(goalSetupProvider.notifier);

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
                  currentStep: 5,
                  label: 'Constraints',
                ),
                const SizedBox(height: 24),
                Text(
                  'Anything I should know?',
                  style: AppTextStyles.h2,
                ),
                const SizedBox(height: 8),
                Text(
                  'Injuries, time limits, or specific preferences. This helps me keep you healthy.',
                  style: AppTextStyles.bodyLarge,
                ),
                const SizedBox(height: 32),
                AshTextField(
                  label: 'Constraints (Optional)',
                  placeholder:
                      'e.g. "Knee pain after 5km", "Max 45 mins on Tuesdays"',
                  maxLines: 5,
                  controller: _controller,
                  onChanged: (val) {
                    notifier.setConstraints(val);
                  },
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
                notifier.nextStep();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const HealthPermissionsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
