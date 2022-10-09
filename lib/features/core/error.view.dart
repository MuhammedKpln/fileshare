import 'package:flutter/material.dart';

/// `ErrorView` is for showing error screen!
class ErrorView extends StatelessWidget {
  /// A named constructor.
  const ErrorView({super.key, this.exception});

  /// Exception for showing the error
  final Exception? exception;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Oh snap!'),
        Text(exception.toString()),
      ],
    );
  }
}
