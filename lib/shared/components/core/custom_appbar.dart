import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

/// This is a custom app bar that has a back button that navigates back.
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateBack() {
      final canPop = context.router.canPop();
      if (canPop) {
        context.router.pop();
      }
    }

    return AppBar(
      leading: IconButton(
        icon: const Icon(Ionicons.chevron_back_outline),
        onPressed: navigateBack,
      ),
    );
  }
}
