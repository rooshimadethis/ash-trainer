import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../calendar/presentation/screens/today_view.dart';
import '../../../calendar/presentation/screens/weekly_view.dart';
import '../../../calendar/presentation/screens/monthly_view.dart';
import '../../../../core/theme/shadows.dart';
import '../../../developer/presentation/widgets/debug_overlay.dart';
import 'package:flutter/foundation.dart';
import '../../../shared/presentation/widgets/ash_bottom_action_bar.dart';
import '../../../../core/theme/colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      useSafeArea: false,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: const [
                TodayView(),
                WeeklyView(),
                MonthlyView(),
              ],
            ),
          ),
        ],
      ),
      bottomAppBar: _buildBottomActionBar(),
    );
  }

  Widget _buildHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: isDark ? AppShadows.retroDark : AppShadows.retro,
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _headerTab('Today', 0),
                  const SizedBox(width: 20),
                  _headerTab('Weekly', 1),
                  const SizedBox(width: 20),
                  _headerTab('Monthly', 2),
                ],
              ),
              Row(
                children: [
                  if (kDebugMode) ...[
                    _topActionButton(
                      context,
                      icon: Icons.bug_report,
                      color: Colors.redAccent,
                      onPressed: () {
                        final navigatorKey =
                            Navigator.of(context, rootNavigator: true)
                                .widget
                                .key as GlobalKey<NavigatorState>?;
                        if (navigatorKey != null) {
                          DebugOverlay.showDebugMenu(context, navigatorKey);
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                  _topActionButton(
                    context,
                    icon: Icons.person_outline_rounded,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topActionButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color ?? Theme.of(context).colorScheme.onSurface,
        size: 24,
      ),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      splashRadius: 24,
    );
  }

  Widget _headerTab(String title, int index) {
    final isSelected = _currentPage == index;
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic, // Smoother curve
        );
      },
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: AppTextStyles.h3.copyWith(
          // Using h3 for punchier tabs
          color: isSelected
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
          fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 4, // Thicker indicator
              width: isSelected ? 20 : 0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(100), // Pill indicator
                border: isSelected
                    ? Border.all(color: Colors.black, width: 1)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return AshBottomActionBar(
      actions: [
        ActionBarItem(
          icon: Icons.add_circle_outline,
          label: 'Log Custom Workout',
          color: AppColors.primary,
          onTap: () {
            // TODO: Navigate to add workout screen
          },
        ),
        ActionBarItem(
          icon: Icons.event_busy_outlined,
          label: 'Add Time Off',
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          onTap: () {
            // TODO: Navigate to time off screen
          },
        ),
      ],
    );
  }
}
