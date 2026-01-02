import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'ash_card.dart';

class AshDropdown<T> extends StatelessWidget {
  final T? value;
  final List<AshDropdownItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String hint;

  const AshDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              label!.toUpperCase(),
              style: AppTextStyles.label.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
        AshCard(
          padding: EdgeInsets.zero,
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<T>(
                value: value,
                items: items.map((item) {
                  return DropdownMenuItem<T>(
                    value: item.value,
                    child: Text(
                      item.label,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
                hint: Text(
                  hint,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                dropdownColor: isDark ? AppColors.surface : AppColors.white,
                borderRadius: BorderRadius.circular(16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AshDropdownItem<T> {
  final T value;
  final String label;

  const AshDropdownItem({
    required this.value,
    required this.label,
  });
}
