import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

/// `RoundedIconButton` is a `StatelessWidget` that displays an `IconButton`
///  with a `DecoratedBox` decoration
class RoundedIconButton extends StatelessWidget {
  // ignore: public_member_api_docs
  const RoundedIconButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  /// A function that takes no arguments and returns nothing.
  final VoidCallback onPressed;

  /// `IconData` is a class that represents a single icon.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalette.grey.color),
        borderRadius: BorderRadius.circular(ThemeRadius.medium.radius),
      ),
      child: IconButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size.fromHeight(30)),
        ),
        onPressed: onPressed,
        icon: child,
      ),
    );
  }
}
