import 'package:flutter/material.dart';

/// A button that takes a label and a callback function
class Button extends StatelessWidget {
  // ignore: public_member_api_docs
  const Button({
    super.key,
    required this.onPressed,
    required this.label,
  });

  /// A function that takes no arguments and returns nothing.
  final VoidCallback onPressed;

  /// A variable that is being passed in from the parent widget.
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
