import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/features/core/components/bottombar/bottomtabs.dart';
import 'package:flutter/material.dart';

class ScaffoldWithBottomBar extends StatelessWidget {
  const ScaffoldWithBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomNavigator(),
      extendBody: true,
      body: AutoRouter(),
    );
  }
}
