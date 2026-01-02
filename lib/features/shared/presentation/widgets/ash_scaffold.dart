import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AshScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? bottomAppBar;
  final PreferredSizeWidget? appBar;
  final bool useSafeArea;
  final Widget? floatingActionButton;

  const AshScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.bottomAppBar,
    this.appBar,
    this.useSafeArea = true,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        appBar: appBar != null
            ? PreferredSize(
                preferredSize: appBar!.preferredSize,
                child: Theme(
                  data: theme.copyWith(
                    appBarTheme: theme.appBarTheme.copyWith(
                      elevation: 0,
                      surfaceTintColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  child: appBar!,
                ),
              )
            : null,
        backgroundColor: theme.scaffoldBackgroundColor,
        body: useSafeArea ? SafeArea(child: body) : body,
        bottomNavigationBar: bottomAppBar ?? bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
