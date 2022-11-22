import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

/// It's a widget that takes a title, a title icon, and a child widget,
///  and renders them in a bottom
/// sheet
class CustomBottomSheet extends StatelessWidget {
  // ignore: public_member_api_docs
  const CustomBottomSheet({
    super.key,
    required this.child,
    required this.title,
    this.titleIcon,
    this.containerPadding = false,
  });

  /// A child to render inside bottom sheet.
  final Widget child;

  /// Bottom sheet title
  final String title;

  /// Bottom sheet title icon
  final Widget? titleIcon;

  /// Container paddin
  final bool? containerPadding;

  /// It's a getter that returns container padding
  EdgeInsets get padding => !containerPadding!
      ? EdgeInsets.all(ThemePadding.medium.padding)
      : EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    Widget renderTitle() {
      final textWidget = Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      );

      if (titleIcon != null) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [titleIcon!, textWidget],
        );
      }

      return textWidget;
    }

    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          renderTitle(),
          const Divider(),
          Container(
            child: child,
          )
        ],
      ),
    );
  }
}
