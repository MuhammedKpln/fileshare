// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

/// Color palette
enum ColorPalette {
  primary(Color(0xFF3628EA)),
  surface(Color(0xFFE8EBF2)),
  text(Color(0xFF322F37));

  final Color color;
  const ColorPalette(this.color);
}

enum ThemeRadius {
  low(10),
  medium(15),
  high(30);

  final double radius;
  const ThemeRadius(this.radius);
}

enum ThemePadding {
  low(10),
  medium(15),
  high(30);

  final double padding;
  const ThemePadding(this.padding);
}

enum ThemeAnimations {
  slow(1000),
  medium(600),
  fast(200);

  final int duration;
  const ThemeAnimations(this.duration);
}
