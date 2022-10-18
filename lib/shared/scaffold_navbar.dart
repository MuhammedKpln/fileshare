import 'package:boilerplate/router/paths.dart';
import 'package:boilerplate/shared/navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldNavbar extends StatelessWidget {
  const ScaffoldNavbar({super.key, required this.child});

  static int _calculateSelectedIndex(BuildContext context) {
    final route = GoRouter.of(context);
    final location = route.location;

    if (location.startsWith(RouteMetaData.login.routePath)) {
      return 1;
    }

    if (location.startsWith(RouteMetaData.home.routePath)) {
      return 0;
    }

    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(RouteMetaData.home.routePath);
        break;
      case 1:
        GoRouter.of(context).go(RouteMetaData.login.routePath);
        break;
    }
  }

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (id) => _onItemTapped(id, context),
      ),
      body: child,
    );
  }
}
