import 'package:boilerplate/auth/services/auth.service.dart';
import 'package:boilerplate/auth/storage/auth.storage.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'auth.controller.g.dart';

/// It's a way to create a list of constants.
enum FormFieldType { emailAdress, password }

/// `AuthViewController` that uses `AuthController` to manage its state
class AuthViewController = AuthController with _$AuthViewController;

/// It's a class that manages the state of the login page
abstract class AuthController with Store {
  final _authService = AuthService();
  final _authBox = AuthBox();

  final Map<FormFieldType, TextEditingController> textControllers = {
    FormFieldType.emailAdress:
        TextEditingController(text: 'eve.holt@reqres.in'),
    FormFieldType.password: TextEditingController(text: 'cityslicka'),
  };

  /// A controller that is used to manage the state of the email text field.
  final TextEditingController emailController = TextEditingController();

  /// A controller that is used to manage the state of the email text field.
  final TextEditingController passwordController = TextEditingController();

  @computed

  /// A getter that returns the value of the `emailController.text`
  String get emailAdress => emailController.text;

  @computed

  /// A getter that returns the value of the `passwordController.text`
  String get password => passwordController.text;

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
  Future<void> login(String email, String password) async {
    try {
      loading = true;
      final login = await _authService.login(email, password);
      await _authBox.saveUser(login.token);
      loading = false;
    } catch (err) {
      throw Exception(err);
    }
  }
}
