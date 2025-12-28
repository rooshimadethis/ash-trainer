import 'package:flutter/material.dart';
import 'ash_colors.dart';
import 'ash_text_styles.dart';

class AshTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AshColors.primary,
      scaffoldBackgroundColor: AshColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AshColors.primary,
        secondary: AshColors.primary,
        surface: AshColors.surfaceDark,
        onPrimary: AshColors.white,
        onSurface: AshColors.white,
      ),
      fontFamily: AshTextStyles.body.fontFamily,
      textTheme: TextTheme(
        displayLarge: AshTextStyles.h1,
        displayMedium: AshTextStyles.h2,
        displaySmall: AshTextStyles.h3,
        bodyLarge: AshTextStyles.bodyLarge,
        bodyMedium: AshTextStyles.bodyMedium,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AshColors.primary,
        inactiveTrackColor: AshColors.borderDark,
        thumbColor: AshColors.primary,
        overlayColor: AshColors.primary.withOpacity(0.2),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
      ),
      useMaterial3: true,
    );
  }
}
