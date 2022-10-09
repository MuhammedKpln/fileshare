import 'package:boilerplate/features/auth/enums.dart';
import 'package:boilerplate/features/auth/login/views/login.view.dart';
import 'package:boilerplate/features/core/error.view.dart';
import 'package:boilerplate/features/home/views/home.view.dart';
import 'package:boilerplate/features/posts/views/post_details.view.dart';
import 'package:boilerplate/features/posts/views/posts.view.dart';
import 'package:boilerplate/router/paths.dart';
import 'package:boilerplate/services/app.service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// It's a class that defines routes
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
      GoRoute(
        name: RouteMetaData.home.routeName,
        path: RouteMetaData.home.routePath,
        pageBuilder: (context, state) => MaterialPage<HomeViewScreen>(
          child: const HomeViewScreen(),
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
      ),
      GoRoute(
        name: RouteMetaData.posts.routeName,
        path: RouteMetaData.posts.routePath,
        pageBuilder: (context, state) => MaterialPage<PostsView>(
          child: const PostsView(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: RouteMetaData.post.routeName,
        path: RouteMetaData.post.routePath,
        pageBuilder: (context, state) => MaterialPage<PostDetailsView>(
          child: PostDetailsView(
            postId: int.parse(state.params['id'] ?? '0'),
          ),
          key: state.pageKey,
        ),
      )
    ],
    redirect: (context, state) {
      final loginState = _appController.loginState;
      final loginLocation = state.namedLocation(RouteMetaData.login.routeName);
      final isInLoginPage = state.location == loginLocation;

      if (!_appController.isInit) {
        return null;
      }

      if (loginState != LoginState.loggedIn && !isInLoginPage) {
        return loginLocation;
      }

      if (loginState == LoginState.loggedIn && isInLoginPage) {
        return null;
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
