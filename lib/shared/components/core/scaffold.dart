import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.body, this.appBar});

  final Widget body;
  final AppBar? appBar;

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
