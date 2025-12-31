import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'ash_card.dart';

class AshSelectionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget leading;
  final bool isSelected;
  final VoidCallback onTap;

  const AshSelectionTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.leading,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AshCard(
      isSelected: isSelected,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                  : AppColors.backgroundDark.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor.withValues(alpha: 0.3)
                    : AppColors.divider,
              ),
            ),
            child: Center(child: leading),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? AppColors.white
                        : AppColors.white.withValues(alpha: 0.9),
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isSelected
                          ? AppColors.white.withValues(alpha: 0.7)
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : AppColors.textSecondary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check,
                    size: 16, color: AppColors.backgroundDark)
                : null,
          ),
        ],
      ),
    );
  }
}
