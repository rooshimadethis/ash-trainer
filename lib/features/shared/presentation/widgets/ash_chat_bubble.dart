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
          if (isAsh) _buildAvatar(),
          const SizedBox(width: 12),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: isAsh ? ashBubbleColor : userBubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(32),
                  topRight: const Radius.circular(32),
                  bottomLeft: Radius.circular(isAsh ? 8 : 32),
                  bottomRight: Radius.circular(isAsh ? 32 : 8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withValues(alpha: AppColors.glassShadowOpacity),
                    offset: const Offset(0, 8),
                    blurRadius: 16,
                    spreadRadius: -4,
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(
                        alpha: isDark
                            ? AppColors.glassHighlightDarkOpacity
                            : AppColors.glassHighlightLightOpacity),
                    offset: const Offset(0, 1),
                    blurRadius: 0,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Text(
                text,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isAsh ? ashTextColor : userTextColor,
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
