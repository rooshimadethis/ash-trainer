import 'package:flutter/material.dart';
import '../theme/ash_colors.dart';
import '../theme/ash_text_styles.dart';
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
                  ? AshColors.primary.withOpacity(0.2)
                  : AshColors.surfaceHighlight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AshColors.primary.withOpacity(0.3)
                    : Colors.white.withOpacity(0.05),
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
                  style: AshTextStyles.body.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: isSelected
                        ? const Color(0xFFFFCCBC)
                        : AshColors.white, // Light orange when selected
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: AshTextStyles.bodyMedium.copyWith(
                      color: isSelected
                          ? const Color(0xFFFFAB91).withOpacity(0.7)
                          : AshColors.textSecondary,
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
              color: isSelected ? AshColors.primary : AshColors.backgroundDark,
              border: Border.all(
                color: isSelected
                    ? AshColors.primary
                    : Colors.grey.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check, size: 16, color: AshColors.white)
                : null,
          ),
        ],
      ),
    );
  }
}
