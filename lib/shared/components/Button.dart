import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  primary(Color(0xFF7968F8));

  final Color color;

  const ButtonType(this.color);
}

/// A button that takes a label and a callback function
class Button extends StatelessWidget {
  // ignore: public_member_api_docs
  const Button({
    super.key,
    required this.onPressed,
    required this.label,
    this.buttonType,
    this.icon,
    this.disabled,
    this.loading,
    this.customStyle,
  });

  /// A function that takes no arguments and returns nothing.
  final VoidCallback onPressed;

  /// A variable that is being passed in from the parent widget.
  final String label;

  /// A button type
  final ButtonType? buttonType;

  /// A icon for the button
  final IconData? icon;

  /// Is button disabled
  final bool? disabled;

  /// Is button disabled
  final bool? loading;

  /// A custom style for the button.
  final ButtonStyle? customStyle;

  /// A getter that returns a color based on the button type.
  Color? get txtColor {
    if (buttonType == ButtonType.primary) {
      return Colors.white;
    }

    return null;
  }

  bool get isLoading => loading != null && loading == true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled != null && disabled! ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonType?.color),
      ).merge(customStyle),
      child: isLoading ? _renderLoading() : _renderButton(),
    );
  }

  Row _renderLoading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [CircularProgressIndicator.adaptive()],
    );
  }

  Row _renderButton() {
    return Row(
      children: [
        if (icon != null) Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: ThemePadding.small.padding),
          child: Text(
            label,
            style: TextStyle(color: txtColor),
          ),
        )
      ],
    );
  }
}
