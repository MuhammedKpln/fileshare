import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/shared/components/rounded_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

/// A button that goes back when pressed.
class CustomBackButton extends StatelessWidget {
  // ignore: public_member_api_docs
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    void goBack() {
      final canPop = context.router.canPop();
      if (canPop) {
        context.router.pop();
      }
    }

    return RoundedIconButton(
      onPressed: goBack,
      child: const Icon(Ionicons.close_outline),
    );
  }
}
