import 'package:boilerplate/router/paths.dart';
import 'package:boilerplate/screens/core/error.view.dart';
import 'package:boilerplate/screens/home/views/home.view.dart';
import 'package:boilerplate/screens/todo_details/views/todo_details.view.dart';
import 'package:boilerplate/screens/todos/views/todos.view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// It's a class that defines routes
class AppRouter {
  /// It's a constructor.
  AppRouter();

  /// Routes
  late final router = GoRouter(
    debugLogDiagnostics: true,
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
