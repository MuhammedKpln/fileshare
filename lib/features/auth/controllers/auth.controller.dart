import 'package:boilerplate/core/extensions/supabase_errors.extension.dart';
import 'package:boilerplate/core/logger/logger.dart';
import 'package:boilerplate/features/auth/enums.dart';
import 'package:boilerplate/features/auth/models/auth.model.dart';
import 'package:boilerplate/features/auth/services/auth.repository.dart';
import 'package:boilerplate/features/auth/storage/auth.storage.dart';
import 'package:boilerplate/services/app.service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth.controller.g.dart';

/// It's a way to create a list of constants.
enum FormFieldType { email, password }

/// `AuthViewController` that uses `AuthController` to manage its state
@LazySingleton()
class AuthViewController = AuthController with _$AuthViewController;

/// It's a class that manages the state of the login page
abstract class AuthController with Store {
  AuthController(
    this._appController,
    this._authBox,
    this._authService,
    this._logger,
  );

  final AppService _appController;
  final AuthService _authService;
  final AuthBox _authBox;
  final LogService _logger;

  final Map<FormFieldType, TextEditingController> textControllers = {
    FormFieldType.email: TextEditingController(text: 'kminchelle'),
    FormFieldType.password: TextEditingController(text: '0lelplR'),
  };

  /// A getter that returns the value of the `emailController.text`
  @computed
  String get email => textControllers[FormFieldType.email]!.text;

  /// A getter that returns the value of the `passwordController.text`
  @computed
  String get password => textControllers[FormFieldType.password]!.text;

  /// A boolean variable that is used to show a loading indicator when the user
  /// is logging in.
  @observable
  bool loading = false;

  /// It logs in the user and saves the token in the box.
  ///
  /// Args:
  ///   email (String): The email of the user
  ///   password (String): The password of the user.
  @action
  Future<void> login() async {
    try {
      loading = true;
      final login = await _authService.login(
        AuthLoginArgs(
          password: password,
          email: email,
        ),
      );
      await _authBox.saveUser(login);
      _appController.setLoginState(LoginState.loggedIn);

      loading = false;
    } on AuthException catch (err) {
      loading = false;
      throw err.error();
    }
  }

  @action
  Future<void> register() async {
    try {
      final login = await _authService.register(
        AuthRegisterModel(
          password: password,
          email: email,
          username: 'MAMI',
        ),
      );
      await _authBox.saveUser(login);
      _appController.setLoginState(LoginState.loggedIn);

      loading = false;
    } on AuthException catch (err) {
      _logger.error(err);
      throw Exception(err.error());
    }
  }

  @action

  /// `_appController.setLoginState(LoginState.none);`
  ///
  /// This is the only line of code that matters
  Future<void> logout() async {
    await _authBox.clear();
    await Supabase.instance.client.auth.signOut();

    _appController.setLoginState(LoginState.none);
  }
}
