import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/logger.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../providers/goal_setup_provider.dart';
import 'plan_review_screen.dart';
import 'package:ash_trainer/features/shared/presentation/widgets/ash_chat_bubble.dart';

class PlanGenerationScreen extends ConsumerStatefulWidget {
  const PlanGenerationScreen({super.key});

  @override
  ConsumerState<PlanGenerationScreen> createState() =>
      _PlanGenerationScreenState();
}

class _PlanGenerationScreenState extends ConsumerState<PlanGenerationScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late AnimationController _thumpController;
  late AnimationController _scanController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _thumpAnimation;
  late Animation<double> _scanAnimation;

  int _messageIndex = 0;
  late Timer _messageTimer;

  final List<String> _messages = [
    'Building your future. This could take a minute or two... I\'m building something special.',
    'Analyzing your biological signatures... (No, I\'m not looking at your browser history.)',
    'Crunching volume thresholds. Science is heavy.',
    'Arguing with the algorithm about your rest days. I won.',
    'Synchronizing strength protocols. Gravity is the enemy.',
    'Optimizing recovery windows. Nap time is serious business.',
    'Bribing the running gods for favorable weather...',
    'Painting your masterpiece in mileage. Almost there.',
    'Polishing the final roadmap. It looks... intense. You\'ll love it.',
  ];

  @override
  void initState() {
    super.initState();

    // Smooth idle pulse
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Orbital rotation
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Impact thump for message changes
    _thumpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _thumpAnimation = CurvedAnimation(
      parent: _thumpController,
      curve: Curves.easeOutCubic,
    );

    // Constant scanning effect
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scanController, curve: Curves.easeOut),
    );

    _messageTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _messageIndex = (_messageIndex + 1) % _messages.length;
        });
        _thumpController.forward(from: 0.0);
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    _thumpController.dispose();
    _scanController.dispose();
    _messageTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ref.listen(goalSetupProvider, (previous, next) {
      if ((previous?.isGenerating ?? false) && !next.isGenerating) {
        if (next.error == null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const PlanReviewScreen()),
          );
        } else {
          AppLogger.e('Plan generation failed',
              error: next.error!, stackTrace: null);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${next.error}')),
          );
        }
      }
    });

    return AshScaffold(
      body: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildOrbitalAnimation(),
                const SizedBox(height: 64),
                ScaleTransition(
                  scale: _thumpAnimation.drive(Tween(begin: 1.0, end: 1.03)),
                  child: Text(
                    'BUILDING YOUR FUTURE',
                    style: AppTextStyles.h2.copyWith(
                      letterSpacing: 4.0,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 120, // Increased height for bubble
                  child: AshChatBubble(
                    key: ValueKey<int>(_messageIndex),
                    text: _messages[_messageIndex],
                    showAvatar: false,
                    fast: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrbitalAnimation() {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: Listenable.merge([
        _pulseController,
        _rotationController,
        _thumpController,
        _scanController,
      ]),
      builder: (context, child) {
        return SizedBox(
          width: 260,
          height: 260,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Rotating scanning ring
              Transform.rotate(
                angle: _scanAnimation.value * pi,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      width: 10,
                    ),
                  ),
                ),
              ),
              // Expanding sonar pulse
              Opacity(
                opacity: 1.0 - _scanAnimation.value,
                child: Transform.scale(
                  scale: 1.0 + (_scanAnimation.value * 0.5),
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              // Inner Glow
              Container(
                width: 150 * _pulseAnimation.value,
                height: 150 * _pulseAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.2),
                      AppColors.primary.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
              // Main Core with Thump
              Transform.scale(
                scale: _pulseAnimation.value + (_thumpAnimation.value * 0.08),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.surface,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary
                            .withValues(alpha: 0.3 * _pulseAnimation.value),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/ash_red_panda_thinking.png',
                      width: 75 + (_thumpAnimation.value * 5),
                      height: 75 + (_thumpAnimation.value * 5),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // Particle Orbitals
              ...List.generate(3, (index) {
                final angle =
                    (_rotationController.value * 2 * pi) + (index * 2 * pi / 3);
                final color = [
                  AppColors.emerald,
                  AppColors.violet,
                  AppColors.cyan
                ][index];

                return Transform.translate(
                  offset: Offset(cos(angle) * 100, sin(angle) * 100),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.6),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
