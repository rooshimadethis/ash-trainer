import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class AshTextField extends StatelessWidget {
  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;

  const AshTextField({
    super.key,
    required this.label,
    this.placeholder,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLines = 1,
    this.inputFormatters,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label.toUpperCase(),
            style: AppTextStyles.label,
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          style: AppTextStyles.bodyLarge,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
                color: AppColors.textSecondary.withValues(alpha: 0.5)),
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            suffixIcon: suffix, // Using suffixIcon for the widget
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
