import 'package:boilerplate/features/auth/login/views/login.view.dart';
import 'package:boilerplate/features/core/error.view.dart';
import 'package:boilerplate/features/home/views/home.view.dart';
import 'package:boilerplate/router/paths.dart';
import 'package:boilerplate/services/app.service.dart';
import 'package:boilerplate/shared/scaffold_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

/// It's a class that defines routes
@LazySingleton()
class AppRouter {
  /// It's a constructor.
  AppRouter(this._appController);
  late final AppService _appController;

  /// Routes
  late final router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: _appController,
    initialLocation: RouteMetaData.home.routePath,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldNavbar(child: child);
        },
        routes: [
          GoRoute(
            path: RouteMetaData.home.routePath,
            builder: (context, state) {
              return const HomeViewScreen();
            },
          ),
          GoRoute(
            path: RouteMetaData.login.routePath,
            builder: (context, state) {
              return const LoginView();
            },
          )
        ],
      )
    ],
    redirect: (context, state) {
      // final loginState = _appController.loginState;
      // final loginLocation = state.namedLocation(RouteMetaData.login.routeName);
      // final homeLocation = state.namedLocation(RouteMetaData.home.routeName);
      // final isInLoginPage = state.location == loginLocation;
      // final isInRootPage = state.location == '/';

      // if (!_appController.isInit) {
      //   return null;
      // }

      // if (loginState != LoginState.loggedIn && !isInLoginPage) {
      //   return loginLocation;
      // }

      // if (loginState == LoginState.loggedIn && isInRootPage) {
      //   return homeLocation;
      // }

      return null;
    },
    errorPageBuilder: (context, state) => MaterialPage<ErrorView>(
      child: ErrorView(
        exception: state.error,
      ),
      key: state.pageKey,
    ),
  );
}
