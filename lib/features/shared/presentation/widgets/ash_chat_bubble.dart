import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'package:ash_trainer/core/theme/shadows.dart';

enum ChatBubbleSender { ash, user }

class AshChatBubble extends StatefulWidget {
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
  State<AshChatBubble> createState() => _AshChatBubbleState();
}

class _AshChatBubbleState extends State<AshChatBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _characterCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    _setupAnimation();
  }

  @override
  void didUpdateWidget(AshChatBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _setupAnimation();
    }
  }

  void _setupAnimation() {
    // Calculate duration based on text length: ~30ms per character
    final duration =
        Duration(milliseconds: (widget.text.length * 15).clamp(400, 3000));
    _controller.duration = duration;

    _characterCount = StepTween(begin: 0, end: widget.text.length).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAsh = widget.sender == ChatBubbleSender.ash;
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
                  color: isDark ? AppColors.retroAccent : Colors.black,
                  width: 1.5,
                ),
                boxShadow: isDark ? AppShadows.retroDark : AppShadows.retro,
              ),
              child: AnimatedBuilder(
                animation: _characterCount,
                builder: (context, child) {
                  final textToShow =
                      widget.text.substring(0, _characterCount.value);
                  return Text(
                    textToShow,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isAsh ? ashTextColor : userTextColor,
                      fontWeight: isAsh ? FontWeight.w500 : FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          if (!isAsh) widget.icon ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark ? AppColors.retroAccent : Colors.black,
          width: 1.5,
        ),
        boxShadow: isDark ? AppShadows.retroDark : AppShadows.retro,
        image: const DecorationImage(
          image: AssetImage('assets/images/ash_red_panda.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
