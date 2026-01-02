import 'dart:async';
import 'dart:math';
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
    with TickerProviderStateMixin {
  late AnimationController _popController;
  late AnimationController _textFadeController;
  late Animation<double> _popAnimation;
  late Animation<double> _textFadeAnimation;
  bool _isTyping = true;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();

    // Initial pop-in animation
    _popController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _popAnimation = CurvedAnimation(
      parent: _popController,
      curve: Curves.easeOutBack,
    );

    // Text fade-in animation (happens after bubble grows)
    _textFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _textFadeAnimation = CurvedAnimation(
      parent: _textFadeController,
      curve: Curves.easeIn,
    );

    _startAnimation();
  }

  @override
  void didUpdateWidget(AshChatBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    _typingTimer?.cancel();

    // If not Ash, just show the message immediately
    if (widget.sender != ChatBubbleSender.ash) {
      setState(() {
        _isTyping = false;
        _popController.value = 1.0;
        _textFadeController.value = 1.0;
      });
      return;
    }

    // Reset state
    setState(() {
      _isTyping = true;
    });

    // Initial pop-in with typing indicator
    _popController.forward(from: 0.0);
    _textFadeController.value = 0.0;

    // After 1 second, start the growth animation
    _typingTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        // Start growing the bubble to full size
        setState(() {
          _isTyping = false;
        });

        // After the bubble has grown (400ms for AnimatedSize), fade in the text
        Timer(const Duration(milliseconds: 400), () {
          if (mounted) {
            _textFadeController.forward(from: 0.0);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _popController.dispose();
    _textFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAsh = widget.sender == ChatBubbleSender.ash;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final ashBubbleColor = Colors.white;
    final userBubbleColor = AppColors.userMessage;

    final ashTextColor = AppColors.textPrimaryLight;
    final userTextColor = AppColors.white;

    final textStyle = AppTextStyles.bodyMedium.copyWith(
      color: isAsh ? ashTextColor : userTextColor,
      fontWeight: isAsh ? FontWeight.w500 : FontWeight.w600,
    );

    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: Radius.circular(isAsh ? 4 : 20),
      bottomRight: Radius.circular(isAsh ? 20 : 4),
    );

    final borderColor = isDark ? AppColors.retroAccent : Colors.black;
    final boxShadow = isDark ? AppShadows.retroDark : AppShadows.retro;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isAsh ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isAsh) ...[
            _buildAvatar(context),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Align(
              alignment: isAsh ? Alignment.bottomLeft : Alignment.bottomRight,
              child: ScaleTransition(
                scale: _popAnimation,
                alignment: isAsh ? Alignment.bottomLeft : Alignment.bottomRight,
                child: FadeTransition(
                  opacity: _popAnimation,
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuart,
                    alignment:
                        isAsh ? Alignment.bottomLeft : Alignment.bottomRight,
                    clipBehavior: Clip.none,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isAsh ? ashBubbleColor : userBubbleColor,
                        borderRadius: borderRadius,
                        border: Border.all(
                          color: borderColor,
                          width: 1.5,
                        ),
                        boxShadow: boxShadow,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        layoutBuilder: (Widget? currentChild,
                            List<Widget> previousChildren) {
                          return Stack(
                            alignment: isAsh
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            children: <Widget>[
                              ...previousChildren,
                              if (currentChild != null) currentChild,
                            ],
                          );
                        },
                        child: _isTyping
                            ? _TypingIndicator(
                                key: const ValueKey('typing'),
                                style: textStyle,
                              )
                            : FadeTransition(
                                opacity: _textFadeAnimation,
                                child: Text(
                                  widget.text,
                                  key: const ValueKey('text'),
                                  style: textStyle,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (!isAsh) ...[
            const SizedBox(width: 8),
            widget.icon ?? const SizedBox.shrink(),
          ],
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

class _TypingIndicator extends StatefulWidget {
  final TextStyle style;
  const _TypingIndicator({super.key, required this.style});

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDot(0),
          const SizedBox(width: 4),
          _buildDot(1),
          const SizedBox(width: 4),
          _buildDot(2),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Stagger the animation for each dot
        final delay = index * 0.15;
        final progress = (_controller.value + delay) % 1.0;

        // Use sine wave for smooth up and down motion
        final bounce = sin(progress * 2 * pi) * -4;

        return Transform.translate(
          offset: Offset(0, bounce),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: widget.style.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
