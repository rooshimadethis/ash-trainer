import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment:
            isAsh ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isAsh) _buildAvatar(),
          const SizedBox(width: 12),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: isAsh ? AppColors.ashMessage : AppColors.userMessage,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(24),
                  topRight: const Radius.circular(24),
                  bottomLeft: Radius.circular(isAsh ? 4 : 24),
                  bottomRight: Radius.circular(isAsh ? 24 : 4),
                ),
                border: isAsh
                    ? Border.all(color: AppColors.border, width: 1)
                    : null,
              ),
              child: Text(
                text,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isAsh ? AppColors.textPrimary : AppColors.white,
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

  Widget _buildAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Center(
        child: Text(
          'A',
          style: AppTextStyles.label.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
