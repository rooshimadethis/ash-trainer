import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'ash_card.dart';

class AshSelectionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget leading; // Can be Text(emoji) or Icon(iconData)
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
                  ? AppColors.primary.withValues(alpha: 0.2)
                  : AppColors.surfaceHighlight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.05),
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
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: isSelected
                        ? const Color(0xFFFFCCBC)
                        : AppColors.white, // Light orange when selected
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isSelected
                          ? const Color(0xFFFFAB91).withValues(alpha: 0.7)
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
              color: isSelected ? AppColors.primary : AppColors.backgroundDark,
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : Colors.grey.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check, size: 16, color: AppColors.white)
                : null,
          ),
        ],
      ),
    );
  }
}
