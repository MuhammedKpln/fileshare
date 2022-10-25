import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

/// `AppScaffold` is a `StatelessWidget` that takes a `body` and an optional
///  `appBar` and displays them
/// in a `Scaffold` with some padding
class AppScaffold extends StatelessWidget {
  // ignore: public_member_api_docs
  const AppScaffold({super.key, required this.body, this.appBar});

  /// A variable that is a widget.
  final Widget body;

  /// A nullable type.
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.all(ThemePadding.medium.padding),
        child: body,
      ),
    );
  }
}
