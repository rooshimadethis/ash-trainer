import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../providers/goal_setup_provider.dart';
import '../widgets/onboarding_navigation.dart';
import '../widgets/onboarding_progress.dart';
import 'constraints_screen.dart';

class AvailabilityScreen extends ConsumerWidget {
  const AvailabilityScreen({super.key});

  static const List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(goalSetupProvider);
    final notifier = ref.read(goalSetupProvider.notifier);

    final unavailableCount = state.unavailableDays.length;
    final availableCount = _days.length - unavailableCount;

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
                  label: 'Availability',
                ),
                const SizedBox(height: 24),
                Text(
                  'When are you NOT available to train?',
                  style: AppTextStyles.h2,
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap any days that are off-limits (work, family time, Netflix binges... we get it)',
                  style: AppTextStyles.bodyLarge,
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 120),
                    itemCount: _days.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final day = _days[index];
                      final isUnavailable = state.unavailableDays.contains(day);
                      return _DaySelector(
                        day: day,
                        isSelected: isUnavailable,
                        onTap: () {
                          final currentDays =
                              List<String>.from(state.unavailableDays);
                          if (isUnavailable) {
                            currentDays.remove(day);
                          } else {
                            currentDays.add(day);
                          }
                          notifier.setUnavailableDays(currentDays);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (availableCount == 1)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, left: 24, right: 24),
                    child: Text(
                      '⚠ Only 1 training day available. We recommend at least 2-3.',
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.accentOrange),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (availableCount == 0)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0, left: 24, right: 24),
                    child: Text(
                      '❌ You need at least one day available for training.',
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                OnboardingNavigation(
                  onNext: availableCount > 0
                      ? () {
                          notifier.nextStep();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ConstraintsScreen(),
                            ),
                          );
                        }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DaySelector extends StatelessWidget {
  final String day;
  final bool isSelected;
  final VoidCallback onTap;

  const _DaySelector({
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceHighlight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                day,
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.white : AppColors.textSecondary,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.white),
          ],
        ),
      ),
    );
  }
}
