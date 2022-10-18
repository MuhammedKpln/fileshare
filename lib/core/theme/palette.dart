// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

/// Color palette
enum ColorPalette {
  primary(Color(0xFF8E5ED4)),
  secondary(Color(0xFFBF83FF)),
  grey(Color(0xFFB8C4E2)),
  background(Colors.white),
  text(Color(0xFF303E65)),
  red(Color(0xFFFA5A7E));

  final Color color;
  const ColorPalette(this.color);
}

enum ThemePadding {
  small(10),
  medium(20),
  large(30);

  final double padding;
  const ThemePadding(this.padding);
}

enum ThemeRadius {
  small(5),
  medium(10),
  large(20);

  final double radius;
  const ThemeRadius(this.radius);
}
