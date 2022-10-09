import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/extensions/toast.extension.dart';
import 'package:boilerplate/core/theme/toast.dart';
import 'package:boilerplate/features/auth/controllers/auth.controller.dart';
import 'package:boilerplate/features/auth/storage/auth.storage.dart';
import 'package:boilerplate/router/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A stateless widget that displays a title, a text, and a button
class HomeViewScreen extends StatelessWidget {
  /// A named constructor.
  const HomeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = getIt<AuthViewController>();

    void navigateTodos() {
      final name = RouteMetaData.posts.routeName;
      context.pushNamed(name);
    }

    void navigateLogin() {
      final name = RouteMetaData.login.routeName;

      context.pushNamed(name);
    }

    Future<void> logout() async {
      print('object');
      await authController.logout();

      context.toast.showToast('OK', toastType: ToastType.success);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: navigateTodos,
              child: const Text('Todos'),
            ),
            ElevatedButton(
              onPressed: navigateLogin,
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: logout,
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
