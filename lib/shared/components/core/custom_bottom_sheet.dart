import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet(
      {super.key, required this.child, required this.title, this.titleIcon});

  final Widget child;
  final String title;
  final Widget? titleIcon;

  @override
  Widget build(BuildContext context) {
    Widget _renderTitle() {
      final textWidget = Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      );

      if (this.titleIcon != null) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [this.titleIcon!, textWidget],
        );
      }

      return textWidget;
    }

    return Padding(
      padding: EdgeInsets.all(ThemePadding.medium.padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _renderTitle(),
          Divider(),
          Container(
            child: child,
          )
        ],
      ),
    );
  }
}
