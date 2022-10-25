import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

/// It's a class that contains static properties that are used to create
/// gradients
class ThemeGradient {
  /// It's a constructor.
  const ThemeGradient();

  /// Creating a gradient with two colors.
  static LinearGradient primaryGradient = LinearGradient(
    colors: [
      ColorPalette.primary.color,
      ColorPalette.primary.color.withOpacity(.5)
    ],
  );

  /// It's creating a gradient with two colors.
  static LinearGradient secondaryGradient = LinearGradient(
    colors: [ColorPalette.red.color, ColorPalette.red.color.withOpacity(.5)],
  );
}
