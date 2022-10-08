import 'package:boilerplate/auth/controllers/app.controller.dart';
import 'package:boilerplate/auth/enums.dart';
import 'package:boilerplate/router/paths.dart';
import 'package:boilerplate/screens/auth/login/views/login.view.dart';
import 'package:boilerplate/screens/core/error.view.dart';
import 'package:boilerplate/screens/home/views/home.view.dart';
import 'package:boilerplate/screens/todo_details/views/todo_details.view.dart';
import 'package:boilerplate/screens/todos/views/todos.view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// It's a class that defines routes
class AppRouter {
  /// It's a constructor.
  AppRouter(this._appController);
  late final AppController _appController;

  /// Routes
  late final router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: _appController,
    initialLocation: RouteMetaData.home.routePath,
    routes: [
      GoRoute(
        name: RouteMetaData.home.routeName,
        path: RouteMetaData.home.routePath,
        pageBuilder: (context, state) => MaterialPage<HomeViewScreen>(
          child: const HomeViewScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: RouteMetaData.todos.routeName,
        path: RouteMetaData.todos.routePath,
        pageBuilder: (context, state) => MaterialPage<TodosView>(
          child: const TodosView(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: RouteMetaData.todoDetails.routeName,
        path: RouteMetaData.todoDetails.routePath,
        pageBuilder: (context, state) => MaterialPage<TodoDetailsView>(
          child: TodoDetailsView(
            todoId: int.parse(state.params['todoId']!),
          ),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: RouteMetaData.login.routeName,
        path: RouteMetaData.login.routePath,
        pageBuilder: (context, state) => MaterialPage<LoginView>(
          child: const LoginView(),
          key: state.pageKey,
        ),
      )
    ],
    redirect: (context, state) {
      final loginState = _appController.loginState;
      final loginLocation = state.namedLocation(RouteMetaData.login.routeName);
      final homeLocation = state.namedLocation(RouteMetaData.todos.routeName);
      final isInLoginPage = state.location == loginLocation;

      if (!_appController.isInit) {
        return null;
      }

      if (loginState != LoginState.loggedIn && !isInLoginPage) {
        return loginLocation;
      }

      if (loginState == LoginState.loggedIn && isInLoginPage) {
        return homeLocation;
      }

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
