import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/shadows.dart';

class AshTextField extends StatefulWidget {
  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final IconData? prefixIcon;
  final bool showPrefixIcon;
  final bool hideLabel;

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
    this.prefixIcon = Icons.edit_note_rounded,
    this.showPrefixIcon = true,
    this.hideLabel = false,
  });

  @override
  State<AshTextField> createState() => _AshTextFieldState();
}

class _AshTextFieldState extends State<AshTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.hideLabel)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              widget.label.toUpperCase(),
              style: AppTextStyles.label.copyWith(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                letterSpacing: 1.5,
                fontSize: 11, // Slightly smaller label to match premium feel
              ),
            ),
          ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surface : AppColors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isFocused
                  ? primaryColor
                  : (isDark ? AppColors.border : AppColors.borderLight),
              width: _isFocused ? 2.0 : 1.5,
            ),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.15),
                      blurRadius: 12,
                      spreadRadius: 2,
                    )
                  ]
                : (isDark ? AppShadows.retroDark : AppShadows.retro),
          ),
          child: TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            inputFormatters: widget.inputFormatters,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: isDark ? AppColors.white : AppColors.black,
            ),
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textMuted.withValues(alpha: 0.6),
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: widget.showPrefixIcon
                  ? Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        widget.prefixIcon,
                        color: _isFocused ? primaryColor : AppColors.textMuted,
                        size: 22,
                      ),
                    )
                  : null,
              suffixIcon: widget.suffix,
              filled: false, // EXPLICITLY REMOVE TINT
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            ),
          ),
        ),
      ],
    );
  }
}
