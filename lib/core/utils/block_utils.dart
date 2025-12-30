import 'package:flutter/material.dart';
import '../theme/colors.dart';

class BlockUtils {
  static Color getColorForIntent(String? intent, [int blockNumber = 1]) {
    if (intent == null) return Colors.transparent;

    Color baseColor;
    final i = intent.toLowerCase();
    if (i.contains('base') || i.contains('foundation')) {
      baseColor = AppColors.blockBase;
    } else if (i.contains('build') || i.contains('accumulation')) {
      baseColor = AppColors.blockBuild;
    } else if (i.contains('peak') || i.contains('intensity')) {
      baseColor = AppColors.blockPeak;
    } else if (i.contains('taper')) {
      baseColor = AppColors.blockTaper;
    } else if (i.contains('recover')) {
      baseColor = AppColors.blockRecovery;
    } else {
      baseColor = AppColors.accentOrange; // Default
    }

    // Modulate color based on block number to distinguish adjacent blocks blocks
    if (blockNumber % 2 == 0) {
      // Shift lightness slightly for even blocks
      // Convert to HSL, reduce lightness by ~15% for visible contrast
      // Since our background is dark, darkening the color might make it recessive.
      // Let's trying shifting hue slightly or just dimming it.
      // Dimming is safer.
      final hsl = HSLColor.fromColor(baseColor);
      return hsl
          .withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0))
          .toColor();
    }

    return baseColor;
  }
}
