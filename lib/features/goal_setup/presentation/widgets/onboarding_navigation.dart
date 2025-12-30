import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../shared/presentation/widgets/ash_button.dart';

class OnboardingNavigation extends StatelessWidget {
  final String nextLabel;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final bool showBack;

  const OnboardingNavigation({
    super.key,
    this.nextLabel = 'Next',
    this.onNext,
    this.onBack,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Gradient Fade
        Container(
          height: 32,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                AppColors.backgroundDark.withValues(alpha: 0.8),
                AppColors.backgroundDark,
              ],
            ),
          ),
        ),
        // Buttons Container
        Container(
          color: AppColors.backgroundDark,
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 32,
            top: 8,
          ),
          child: Row(
            children: [
              if (showBack) ...[
                SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: onBack ?? () => Navigator.of(context).pop(),
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: AshButton(
                  label: nextLabel,
                  onPressed: onNext,
                  icon: Icons.arrow_forward,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
