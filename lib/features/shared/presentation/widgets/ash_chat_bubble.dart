import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'package:ash_trainer/core/theme/shadows.dart';
import 'package:ash_trainer/core/theme/dimensions.dart';
import 'package:ash_trainer/core/theme/animations.dart';

enum ChatBubbleSender { ash, user }

class AshChatBubble extends StatefulWidget {
  final String text;
  final ChatBubbleSender sender;
  final Widget? icon;
  final bool isThinking;
  final bool showAvatar;
  final bool fast;

  const AshChatBubble({
    super.key,
    required this.text,
    this.sender = ChatBubbleSender.ash,
    this.icon,
    this.isThinking = false,
    this.showAvatar = true,
    this.fast = false,
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
  bool _hasAnimated = false; // Track if we've done the initial animation
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();

    // Initial pop-in animation
    _popController = AnimationController(
      vsync: this,
      duration: AppAnimations.chatBubblePopIn,
    );

    _popAnimation = CurvedAnimation(
      parent: _popController,
      curve: Curves.easeOutBack,
    );

    // Text fade-in animation (happens after bubble grows)
    _textFadeController = AnimationController(
      vsync: this,
      duration: AppAnimations.chatBubbleTextFade,
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
    if (oldWidget.text != widget.text && widget.text.isNotEmpty) {
      // If we've already animated once, just fade the text
      if (_hasAnimated) {
        _textFadeController.forward(from: 0.0);
      } else {
        _startAnimation();
      }
    }
  }

  void _startAnimation() {
    _typingTimer?.cancel();

    // If not Ash, just show the message immediately
    if (widget.sender != ChatBubbleSender.ash) {
      setState(() {
        _isTyping = false;
        _hasAnimated = true;
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

    final delay = widget.fast ? Duration.zero : AppAnimations.typingDelay;

    // After delay, start the growth animation
    _typingTimer = Timer(delay, () {
      if (mounted) {
        // Start growing the bubble to full size
        setState(() {
          _isTyping = false;
        });

        final growthDelay =
            widget.fast ? Duration.zero : AppAnimations.chatBubbleGrowth;

        // After the bubble has grown, fade in the text
        Timer(growthDelay, () {
          if (mounted) {
            _hasAnimated = true;
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
      topLeft: Radius.circular(AppDimensions.chatBubbleRadius),
      topRight: Radius.circular(AppDimensions.chatBubbleRadius),
      bottomLeft: Radius.circular(isAsh
          ? AppDimensions.chatBubbleSmallRadius
          : AppDimensions.chatBubbleRadius),
      bottomRight: Radius.circular(isAsh
          ? AppDimensions.chatBubbleRadius
          : AppDimensions.chatBubbleSmallRadius),
    );

    final borderColor = isDark ? AppColors.retroAccent : Colors.black;
    final boxShadow = isDark ? AppShadows.retroDark : AppShadows.retro;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.spacingXs),
      child: Row(
        mainAxisAlignment:
            isAsh ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isAsh && widget.showAvatar) ...[
            _buildAvatar(context),
            SizedBox(width: AppDimensions.spacingSm),
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
                    duration: AppAnimations.chatBubbleGrowth,
                    curve: AppAnimations.easeOutQuart,
                    alignment:
                        isAsh ? Alignment.bottomLeft : Alignment.bottomRight,
                    clipBehavior: Clip.none,
                    child: Container(
                      padding: AppDimensions.chatBubblePadding,
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
                        duration: AppAnimations.fast,
                        switchInCurve: AppAnimations.easeIn,
                        switchOutCurve: AppAnimations.easeOut,
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
            SizedBox(width: AppDimensions.spacingSm),
            widget.icon ?? const SizedBox.shrink(),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: AppDimensions.avatarMd,
      height: AppDimensions.avatarMd,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark ? AppColors.retroAccent : Colors.black,
          width: 1.5,
        ),
        boxShadow: isDark ? AppShadows.retroDark : AppShadows.retro,
        image: DecorationImage(
          image: AssetImage(widget.isThinking
              ? 'assets/images/ash_red_panda_thinking.png'
              : 'assets/images/ash_red_panda.png'),
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
      duration: AppAnimations.typingCycle,
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
      width: AppDimensions.typingIndicatorWidth,
      height: AppDimensions.typingIndicatorHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDot(0),
          SizedBox(width: AppDimensions.typingDotSpacing),
          _buildDot(1),
          SizedBox(width: AppDimensions.typingDotSpacing),
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
        final bounce = sin(progress * 2 * pi) * -AppDimensions.typingDotBounce;

        return Transform.translate(
          offset: Offset(0, bounce),
          child: Container(
            width: AppDimensions.typingDotSize,
            height: AppDimensions.typingDotSize,
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
