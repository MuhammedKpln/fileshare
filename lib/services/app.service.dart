import 'package:boilerplate/core/constants/locale.dart';
import 'package:boilerplate/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// App State
@LazySingleton()
class AppService extends ChangeNotifier {
  /// A constructor.
  AppService(this.locale, this.theme);

  /// Application locale
  final AppLocale locale;

  /// App theme
  final AppTheme theme;
}
