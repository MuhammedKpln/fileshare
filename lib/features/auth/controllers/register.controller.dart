import 'package:boilerplate/core/constants/form.dart';
import 'package:boilerplate/core/extensions/supabase_errors.extension.dart';
import 'package:boilerplate/core/logger/logger.dart';
import 'package:boilerplate/features/auth/enums.dart';
import 'package:boilerplate/features/auth/models/auth.model.dart';
import 'package:boilerplate/features/auth/services/auth.repository.dart';
import 'package:boilerplate/features/auth/storage/auth.adapter.dart';
import 'package:boilerplate/features/auth/storage/auth.storage.dart';
import 'package:boilerplate/services/app.service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'register.controller.g.dart';

/// It's a way to create a list of constants.
enum FormFieldType { email, username, password, passwordConfirmation }

/// `AuthViewController` that uses `AuthController` to manage its state
@LazySingleton()
class RegisterViewController = RegisterController with _$RegisterViewController;

/// It's a class that manages the state of the login page
abstract class RegisterController with Store {
  // ignore: public_member_api_docs
  RegisterController(
    this._appController,
    this._authBox,
    this._authService,
    this._logger,
  );

  final AppService _appController;
  final AuthService _authService;
  final AuthBox _authBox;
  final LogService _logger;

  /// It's a way to create a list of constants.
  final Map<FormFieldType, TextEditingController> textControllers = {
    FormFieldType.email: TextEditingController(),
    FormFieldType.password: TextEditingController(),
    FormFieldType.passwordConfirmation: TextEditingController(),
    FormFieldType.username: TextEditingController(),
  };

  /// It's a way to access the form state.
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// It's a boolean that controls the visibility of the password field.
  @observable
  bool showPaswordField = false;

  /// It's a list of errors that is being observed by the view.
  @observable
  ObservableList<String> errors = ObservableList();

  /// It's a way to observe the state of the future.
  @observable
  ObservableFuture<AuthModel>? registerFuture;

  /// A getter that returns the value of the `emailController.text`
  String get email => textControllers[FormFieldType.email]!.text;

  /// A getter that returns the value of the `emailController.text`
  String get username => textControllers[FormFieldType.username]!.text;

  /// A getter that returns the value of the `passwordController.text`
  String get password => textControllers[FormFieldType.password]!.text;

  /// A getter that returns the value of the `passwordController.text`
  String get passwordConfirmation =>
      textControllers[FormFieldType.passwordConfirmation]!.text;

  /// It's a getter that returns a function that validates the email.
  String? Function(String? value) get emailValidator => _validateEmail;

  /// It's a getter that returns a function that validates the email.
  String? Function(String? value) get usernameValidator => _validateUsername;

  /// It's a getter that returns a function that validates the password.
  String? Function(String? value) get passwordValidator => _validatePassword;

  String? _validateEmail(String? value) {
    if (value != null && EMAIL_REGEX.hasMatch(value)) {
      return null;
    }

    return 'validEmailErrorTxt'.tr();
  }

  String? _validateUsername(String? value) {
    if (value != null && value.length > 4) {
      return null;
    }

    return 'validEmailErrorTxt'.tr();
  }

  String? _validatePassword(String? value) {
    final isMatchingConfirmation = password == passwordConfirmation;

    if (value != null && value.length < 4) {
      return 'validPasswordErrorTxt'.tr();
    }

    if (!isMatchingConfirmation) {
      return 'passwordIsNotEqualError'.tr();
    }

    return null;
  }

  /// It toggles the value of the showPasswordField variable.
  void toggleShowPasswordField() {
    showPaswordField = !showPaswordField;
  }

  @action
  Future<void> register() async {
    try {
      final args = AuthRegisterModel(
        password: password,
        email: email,
        username: username,
      );
      final registerRepo = _authService.register(args);

      registerFuture = ObservableFuture(registerRepo);

      await registerFuture?.then((value) async {
        await _authBox.saveUser(value);
        _appController.setLoginState(LoginState.loggedIn);
      });
    } on AuthException catch (err) {
      errors.add(err.error());
      _logger.error(err);
      throw Exception(err.error());
    }
  }
}
