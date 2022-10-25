import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/features/auth/views/login/login.view.dart';
import 'package:boilerplate/features/auth/views/register/register.view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginView, initial: true),
    AutoRoute(
      page: RegisterView,
    ),
  ],
)
// ignore: public_member_api_docs
class $AuthRouter {}
