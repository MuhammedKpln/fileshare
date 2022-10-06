import 'package:boilerplate/router/paths.dart';
import 'package:boilerplate/screens/Home/views/home.view.dart';
import 'package:boilerplate/screens/core/error.view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// It's a class that defines routes
class AppRouter {
/// It's a constructor.
  AppRouter();

  /// Routes
  late final router = GoRouter(
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        path: RouteMetaData.home.routePath,
        name: RouteMetaData.home.routeName,
        pageBuilder: (context, state) => MaterialPage<HomeViewScreen>(
          child: const HomeViewScreen(),
          key: state.pageKey,
        ),
      )
    ],
    errorPageBuilder: (context, state) => MaterialPage<ErrorView>(
      child: ErrorView(
        exception: state.error,
      ),
      key: state.pageKey,
    ),
  );
}
