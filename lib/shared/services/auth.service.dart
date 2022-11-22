import 'package:boilerplate/features/auth/enums.dart';
import 'package:boilerplate/features/auth/models/user.model.dart';
import 'package:boilerplate/features/auth/storage/auth.storage.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'auth.service.g.dart';

@LazySingleton()
class AuthService = _AuthServiceBase with _$AuthService;

abstract class _AuthServiceBase with Store {
  _AuthServiceBase(this._authBox);

  final AuthBox _authBox;

  @observable
  UserModel? user;

  @observable
  LoginState loginState = LoginState.none;

  @observable
  bool initialized = false;

  @action
  void setUser(UserModel _user) {
    user = _user;
  }

  /// > Check if the user is logged in. If they are, set the login state to
  /// logged in
  @action
  void setLoginState(LoginState state) {
    loginState = state;
  }

  /// > Check if the user is logged in. If they are, set the login state to
  /// logged in
  @action
  Future<void> checkLoginState() async {
    final user = await _authBox.getAuth();

    if (user != null) {
      loginState = LoginState.loggedIn;
      initialized = true;
      setUser(user.user);

      return;
    }

    initialized = true;
  }
}
