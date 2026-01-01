import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../calendar/presentation/screens/today_view.dart';
import '../../../calendar/presentation/screens/weekly_view.dart';
import '../../../calendar/presentation/screens/monthly_view.dart';

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
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide.none,
        ),
      ),
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
          IconButton(
            icon: Icon(
              Icons.notifications_none_rounded,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
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
        style: AppTextStyles.h4.copyWith(
          color: isSelected
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          fontSize: 18,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 4,
              width: isSelected ? 24 : 0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(2),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Theme.of(context)
                              .primaryColor
                              .withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
