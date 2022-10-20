import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

class ThemeGradient {
  const ThemeGradient();

  /// Creating a gradient with two colors.
  static LinearGradient primaryGradient = LinearGradient(
    colors: [
      ColorPalette.primary.color,
      ColorPalette.primary.color.withOpacity(.5)
    ],
  );
  static LinearGradient secondaryGradient = LinearGradient(
    colors: [ColorPalette.red.color, ColorPalette.red.color.withOpacity(.5)],
  );
}
