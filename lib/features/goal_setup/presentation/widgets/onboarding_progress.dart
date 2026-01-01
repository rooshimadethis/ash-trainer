import 'package:flutter/material.dart';

class OnboardingProgress extends StatefulWidget {
  final int currentStep;
  final int totalSteps;
  final String label;

  const OnboardingProgress({
    super.key,
    required this.currentStep,
    this.totalSteps = 7,
    required this.label,
  });

  @override
  State<OnboardingProgress> createState() => _OnboardingProgressState();
}

class _OnboardingProgressState extends State<OnboardingProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),
        // Segmented Progress Bar
        Row(
          children: List.generate(widget.totalSteps, (index) {
            final stepIndex = index + 1;
            final isCompleted = stepIndex < widget.currentStep;
            final isActive = stepIndex == widget.currentStep;

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == widget.totalSteps - 1 ? 0 : 8.0,
                ),
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: isCompleted || isActive
                        ? Theme.of(context).primaryColor
                        : Theme.of(context)
                            .colorScheme
                            .outline
                            .withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: isActive
                      ? AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.white.withValues(
                                  alpha: 0.2 * _pulseController.value,
                                ),
                              ),
                            );
                          },
                        )
                      : null,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
