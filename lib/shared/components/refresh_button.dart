import 'package:boilerplate/shared/components/rounded_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    super.key,
    required this.onPressed,
    required this.onRefresh,
  });

  /// A boolean value that is used to determine whether the button is pressed
  /// or not.
  final bool onRefresh;

  /// A function that returns nothing and takes no arguments.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RoundedIconButton(
      onPressed: onPressed,
      child: !onRefresh
          ? const Icon(Ionicons.refresh_outline)
          : const CircularProgressIndicator(strokeWidth: 1),
    );
  }
}
