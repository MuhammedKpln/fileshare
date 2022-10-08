import 'package:boilerplate/auth/controllers/app.controller.dart';
import 'package:boilerplate/auth/enums.dart';
import 'package:boilerplate/auth/models/auth.model.dart';
import 'package:boilerplate/auth/services/auth.service.dart';
import 'package:boilerplate/auth/storage/auth.storage.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'auth.controller.g.dart';

/// It's a way to create a list of constants.
enum FormFieldType { username, password }

/// `AuthViewController` that uses `AuthController` to manage its state
class AuthViewController = AuthController with _$AuthViewController;

/// It's a class that manages the state of the login page
abstract class AuthController with Store {
  AuthController(this._appController);

  final _authService = AuthService();
  final _authBox = AuthBox();
  final AppController _appController;

  final Map<FormFieldType, TextEditingController> textControllers = {
    FormFieldType.username: TextEditingController(text: 'kminchelle'),
    FormFieldType.password: TextEditingController(text: '0lelplR'),
  };

  /// A controller that is used to manage the state of the email text field.

  final TextEditingController usernameController = TextEditingController();

  /// A controller that is used to manage the state of the email text field.
  final TextEditingController passwordController = TextEditingController();

  /// A getter that returns the value of the `emailController.text`
  @computed
  String get username => textControllers[FormFieldType.username]!.text;

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
      print(username);
      print(password);
      final login = await _authService.login(
        AuthLoginArgs(
          username: username,
          password: password,
        ),
      );
      await _authBox.saveUser(login);
      _appController.setLoginState(LoginState.loggedIn);

      loading = false;
    } catch (err) {
      loading = false;
      throw Exception(err);
    }
  }
}
