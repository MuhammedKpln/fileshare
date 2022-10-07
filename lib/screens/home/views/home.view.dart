import 'package:boilerplate/router/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A stateless widget that displays a title, a text, and a button
class HomeViewScreen extends StatelessWidget {
  /// A named constructor.
  const HomeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateTodos() {
      final name = RouteMetaData.todos.routeName;
      GoRouter.of(context).pushNamed(name);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: navigateTodos,
              child: const Text('Todos'),
            )
          ],
        ),
      ),
    );
  }
}
