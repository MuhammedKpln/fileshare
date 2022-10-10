import 'package:boilerplate/core/constants/locale.dart';
import 'package:boilerplate/features/auth/enums.dart';
import 'package:boilerplate/features/auth/storage/auth.storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// App State
@LazySingleton()
class AppService extends ChangeNotifier {
  /// A constructor.
  AppService(this.locale);

  /// Application locale
  final AppLocale locale;

  /// Setting the default value of the loginState to none.
  LoginState? loginState = LoginState.none;

  /// Used to check if the app is initialized.
  bool isInit = false;

  /// > Check if the user is logged in. If they are, set the login state to
  /// logged in
  Future<void> checkLoginState() async {
    final authBox = AuthBox();
    final user = await authBox.getUser();

    if (user != null) {
      loginState = LoginState.loggedIn;
    }

    isInit = true;
    notifyListeners();
  }

  /// > Check if the user is logged in. If they are, set the login state to
  /// logged in
  void setLoginState(LoginState state) {
    loginState = state;
    notifyListeners();
  }
}
