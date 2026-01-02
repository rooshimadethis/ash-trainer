import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'ash_card.dart';

class AshDatePicker extends StatelessWidget {
  final DateTime? value;
  final String label;
  final String hint;
  final VoidCallback onTap;

  const AshDatePicker({
    super.key,
    this.value,
    required this.label,
    required this.hint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label.toUpperCase(),
            style: AppTextStyles.label.copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
              letterSpacing: 1.5,
              fontSize: 11,
            ),
          ),
        ),
        AshCard(
          onTap: onTap,
          backgroundColor: isDark ? AppColors.surface : AppColors.white,
          borderRadius: 24,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value == null
                      ? hint
                      : DateFormat('MMMM d, yyyy').format(value!),
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight:
                        value == null ? FontWeight.w400 : FontWeight.w600,
                    color: value == null
                        ? AppColors.textMuted.withValues(alpha: 0.6)
                        : (isDark ? AppColors.white : AppColors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
