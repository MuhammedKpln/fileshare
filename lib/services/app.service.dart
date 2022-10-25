import 'package:boilerplate/core/constants/locale.dart';
import 'package:boilerplate/core/theme/theme.dart';
import 'package:boilerplate/shared/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// App State
@LazySingleton()
class AppService extends ChangeNotifier {
  /// A constructor.
  AppService(this.locale, this.theme, this.authService);

  /// Application locale
  final AppLocale locale;

  /// App theme
  final AppTheme theme;

  /// auth service
  final AuthService authService;

  /// Used to check if the app is initialized.
  final bool isInit = false;
}
