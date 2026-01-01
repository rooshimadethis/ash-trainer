import 'package:flutter/material.dart';
import '../../../../core/utils/haptics.dart';
import 'package:ash_trainer/core/theme/shadows.dart';

class AshCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;

  const AshCard({
    super.key,
    required this.child,
    this.onTap,
    this.isSelected = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.backgroundColor,
  });

  @override
  State<AshCard> createState() => _AshCardState();
}

class _AshCardState extends State<AshCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap != null
          ? () {
              AshHaptics.mediumImpact();
              widget.onTap!();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        transform: Matrix4.translationValues(
          _isPressed ? 2.0 : 0.0,
          _isPressed ? 2.0 : 0.0,
          0.0,
        ),
        decoration: BoxDecoration(
          color: (widget.backgroundColor ?? theme.colorScheme.surface)
              .withValues(alpha: 1.0),
          borderRadius: BorderRadius.circular(24), // Slightly tighter for retro
          border: Border.all(
            color: isDark ? const Color(0xFFFF4D8C) : Colors.black,
            width: 2.0,
          ),
          boxShadow: _isPressed
              ? AppShadows.retroHover
              : (isDark ? AppShadows.retroDark : AppShadows.retro),
        ),
        child: widget.child,
      ),
    );
  }
}
