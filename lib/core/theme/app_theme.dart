import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData lightTheme({Color? primaryColor}) {
    final primary = primaryColor ?? AppColors.primary;
    final primaryContainer = primary.withValues(alpha: 0.1);
    final scaffoldBackground = Color.alphaBlend(
      primary.withValues(alpha: 0.04),
      AppColors.backgroundLight,
    );

    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primary,
      scaffoldBackgroundColor: scaffoldBackground,
      colorScheme: ColorScheme.light(
        primary: primary,
        onPrimary: AppColors.white,
        primaryContainer: primaryContainer,
        onPrimaryContainer: primary,
        secondary: AppColors.primaryLight,
        onSecondary: AppColors.white,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textPrimaryLight,
        outline: AppColors.borderLight,
        error: AppColors.error,
      ),
      fontFamily: AppTextStyles.display.fontFamily,
      textTheme: _buildTextTheme(primary, isDark: false),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackground.withValues(alpha: 0.8),
        elevation: 0,
        centerTitle: false,
        titleTextStyle:
            AppTextStyles.h3.copyWith(color: AppColors.textPrimaryLight),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Brightness.dark, // Dark icons for light theme
          statusBarBrightness: Brightness.light, // For iOS
        ),
      ),
      cardTheme: _buildCardTheme(isDark: false),
      elevatedButtonTheme: _buildElevatedButtonTheme(primary),
      outlinedButtonTheme: _buildOutlinedButtonTheme(isDark: false),
      inputDecorationTheme: _buildInputDecorationTheme(primary, isDark: false),
      sliderTheme: _buildSliderTheme(primary),
      navigationBarTheme: _buildNavigationBarTheme(primary, isDark: false),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderLight,
        thickness: 1,
        space: 24,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme({Color? primaryColor}) {
    final primary = primaryColor ?? AppColors.primary;
    final primaryContainer = primary.withValues(alpha: 0.15);
    final scaffoldBackground = Color.alphaBlend(
      primary.withValues(alpha: 0.06),
      AppColors.background,
    );

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primary,
      scaffoldBackgroundColor: scaffoldBackground,
      colorScheme: ColorScheme.dark(
        primary: primary,
        onPrimary: AppColors.white,
        primaryContainer: primaryContainer,
        onPrimaryContainer: primary.withValues(alpha: 0.9),
        secondary: AppColors.primaryLight,
        onSecondary: AppColors.background,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimaryDark,
        outline: AppColors.border,
        error: AppColors.error,
      ),
      fontFamily: AppTextStyles.display.fontFamily,
      textTheme: _buildTextTheme(primary, isDark: true),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackground.withValues(alpha: 0.8),
        elevation: 0,
        centerTitle: false,
        titleTextStyle:
            AppTextStyles.h3.copyWith(color: AppColors.textPrimaryDark),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Brightness.light, // Light icons for dark theme
          statusBarBrightness: Brightness.dark, // For iOS
        ),
      ),
      cardTheme: _buildCardTheme(isDark: true),
      elevatedButtonTheme: _buildElevatedButtonTheme(primary),
      outlinedButtonTheme: _buildOutlinedButtonTheme(isDark: true),
      inputDecorationTheme: _buildInputDecorationTheme(primary, isDark: true),
      sliderTheme: _buildSliderTheme(primary),
      navigationBarTheme: _buildNavigationBarTheme(primary, isDark: true),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 24,
      ),
      useMaterial3: true,
    );
  }

  static TextTheme _buildTextTheme(Color primary, {required bool isDark}) {
    final baseColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final secondaryColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return TextTheme(
      displayLarge: AppTextStyles.h1.copyWith(color: baseColor),
      displayMedium: AppTextStyles.h2.copyWith(color: baseColor),
      displaySmall: AppTextStyles.h3.copyWith(color: baseColor),
      headlineMedium: AppTextStyles.h2.copyWith(color: baseColor),
      titleLarge: AppTextStyles.h3.copyWith(color: baseColor),
      titleMedium: AppTextStyles.h4.copyWith(color: baseColor),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: secondaryColor),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: secondaryColor),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: primary),
      labelMedium: AppTextStyles.label.copyWith(color: primary),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: secondaryColor),
    );
  }

  static CardThemeData _buildCardTheme({required bool isDark}) {
    return CardThemeData(
      color: isDark ? AppColors.surface : AppColors.surfaceLight,
      elevation: isDark ? 0 : 2,
      shadowColor: AppColors.black.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(
          color: isDark ? AppColors.border : AppColors.borderLight,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 16),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(Color primary) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.surfaceHighlight,
        disabledForegroundColor: AppColors.textSecondaryDark,
        textStyle: AppTextStyles.buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        elevation: 0,
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
      {required bool isDark}) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor:
            isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        side: BorderSide(
            color: isDark ? AppColors.border : AppColors.borderLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(Color primary,
      {required bool isDark}) {
    return InputDecorationTheme(
      filled: true,
      fillColor:
          isDark ? AppColors.surfaceLighter : AppColors.surfaceLightSecondary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
            color: isDark ? AppColors.border : AppColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: primary, width: 1.5),
      ),
      labelStyle: AppTextStyles.bodyMedium.copyWith(color: primary),
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
      contentPadding: const EdgeInsets.all(16),
    );
  }

  static SliderThemeData _buildSliderTheme(Color primary) {
    return SliderThemeData(
      activeTrackColor: primary,
      inactiveTrackColor: Colors.white,
      thumbColor: Colors.white,
      activeTickMarkColor: Colors.transparent,
      inactiveTickMarkColor: Colors.transparent,
      overlayColor: primary.withValues(alpha: 0.2),
      trackHeight: 10, // Slightly thicker as per "thicker" request maybe?
      // User said "custom rpe slider"
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 12,
        elevation: 4,
        pressedElevation: 8,
      ),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
      trackShape: const RoundedRectSliderTrackShape(),
      tickMarkShape: SliderTickMarkShape.noTickMark,
    );
  }

  static NavigationBarThemeData _buildNavigationBarTheme(Color primary,
      {required bool isDark}) {
    return NavigationBarThemeData(
      backgroundColor: isDark ? AppColors.surface : AppColors.surfaceLight,
      indicatorColor: primary.withValues(alpha: 0.1),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final color = states.contains(WidgetState.selected)
            ? primary
            : (isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight);
        return AppTextStyles.labelSmall.copyWith(color: color);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: primary);
        }
        return IconThemeData(
            color: isDark ? AppColors.textMuted : AppColors.textSecondaryLight);
      }),
    );
  }
}
