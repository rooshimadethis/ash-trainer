import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class AshCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? borderColor;

  const AshCard({
    super.key,
    required this.child,
    this.onTap,
    this.isSelected = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (borderColor ?? AppColors.borderDark.withValues(alpha: 0.5)),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 25,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: child,
      ),
    );
  }
}
