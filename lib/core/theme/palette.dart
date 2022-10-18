// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

/// Color palette
enum ColorPalette {
  primary(Color(0xFF8E5ED4)),
  grey(Color(0xFFB8C4E2)),
  background(Colors.white),
  text(Color(0xFF32323C)),
  pink(Color(0xFFF1293E));

  final Color color;
  const ColorPalette(this.color);
}

enum ThemePadding {
  small(5),
  medium(10),
  large(20);

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
