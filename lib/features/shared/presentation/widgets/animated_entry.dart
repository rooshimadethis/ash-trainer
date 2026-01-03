import 'package:flutter/material.dart';
import '../../../../core/theme/animations.dart';

class AnimatedEntry extends StatelessWidget {
  final Widget child;
  final int index;
  final Duration delay;
  final Offset offset;

  const AnimatedEntry({
    super.key,
    required this.child,
    this.index = 0,
    this.delay = const Duration(milliseconds: 50),
    this.offset = const Offset(0, 0.25),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: AppAnimations.workoutEntry,
      curve: AppAnimations.entryCurve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: offset * (1.0 - value) * 100,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
