import 'package:flutter/material.dart';
import '../theme/ash_colors.dart';
import '../theme/ash_text_styles.dart';
import 'ash_glass_card.dart';

class AshTextField extends StatelessWidget {
  final String placeholder;
  final int maxLines;
  final TextEditingController? controller;

  const AshTextField({
    super.key,
    required this.placeholder,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AshGlassCard(
      padding: EdgeInsets.zero,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: AshTextStyles.body.copyWith(color: AshColors.white),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: AshTextStyles.body.copyWith(
            color: AshColors.textSecondary,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        cursorColor: AshColors.primary,
      ),
    );
  }
}
