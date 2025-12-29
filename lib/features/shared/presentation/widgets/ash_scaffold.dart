import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';

class AshScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;

  const AshScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // Top glow effect
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 600,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.2),
                      AppColors.primary.withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(child: body),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
