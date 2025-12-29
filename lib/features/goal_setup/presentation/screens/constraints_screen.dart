import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../shared/presentation/widgets/ash_text_field.dart';
import '../providers/goal_setup_provider.dart';
import 'goal_type_selection_screen.dart';

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
      appBar: AppBar(
        title: const Text('Constraints'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            const Spacer(),
            AshButton(
              label: 'Next',
              onPressed: () {
                notifier.nextStep();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const GoalTypeSelectionScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  notifier.setConstraints(null); // Clear if skipped
                  notifier.nextStep();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const GoalTypeSelectionScreen(),
                    ),
                  );
                },
                child: Text('Skip',
                    style: AppTextStyles.body
                        .copyWith(color: AppColors.textSecondary)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
