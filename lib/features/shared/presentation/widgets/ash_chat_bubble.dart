import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'package:ash_trainer/core/theme/shadows.dart';

enum ChatBubbleSender { ash, user }

class AshChatBubble extends StatelessWidget {
  final String text;
  final ChatBubbleSender sender;
  final Widget? icon;

  const AshChatBubble({
    super.key,
    required this.text,
    this.sender = ChatBubbleSender.ash,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isAsh = sender == ChatBubbleSender.ash;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final ashBubbleColor =
        isDark ? AppColors.ashMessageDark : AppColors.ashMessageLight;
    final userBubbleColor = AppColors.userMessage;

    final ashTextColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final userTextColor = AppColors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment:
            isAsh ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isAsh) _buildAvatar(context),
          const SizedBox(width: 12),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: (isAsh ? ashBubbleColor : userBubbleColor)
                    .withValues(alpha: 1.0),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isAsh ? 4 : 20),
                  bottomRight: Radius.circular(isAsh ? 20 : 4),
                ),
                border: Border.all(
                  color: isDark ? const Color(0xFFFF4D8C) : Colors.black,
                  width: 1.5,
                ),
                boxShadow: isDark ? AppShadows.retroDark : AppShadows.retro,
              ),
              child: Text(
                text,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isAsh ? ashTextColor : userTextColor,
                  fontWeight: isAsh ? FontWeight.w500 : FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          if (!isAsh) icon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark ? const Color(0xFFFF4D8C) : Colors.black,
          width: 1.5,
        ),
        boxShadow: isDark ? AppShadows.retroDark : AppShadows.retro,
      ),
      child: Center(
        child: Text(
          'A',
          style: AppTextStyles.label.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
