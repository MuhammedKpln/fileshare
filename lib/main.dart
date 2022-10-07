import 'package:boilerplate/constants%20/core.dart';
import 'package:boilerplate/router/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    App(),
  );
}

/// `App` Entry Point.
class App extends StatelessWidget {
  /// A named constructor.
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: CoreConstants.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _appRouter.router,
    );
  }
}
