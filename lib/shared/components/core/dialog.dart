import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/shared/components/button.dart';
import 'package:flutter/material.dart';

class AppDialogAction {
  AppDialogAction(
      {required this.label, required this.callback, this.isPrimary});

  final String label;
  final VoidCallback callback;
  final bool? isPrimary;
}

class _AppDialogTitle extends StatelessWidget {
  const _AppDialogTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemePadding.small.padding),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class AppDialog extends StatelessWidget {
  const AppDialog(
      {super.key,
      required this.title,
      required this.child,
      required this.actions});
  final String title;
  final Widget child;
  final List<AppDialogAction> actions;

  List<Widget> get actionsAsWidget => actions
      .map((e) => Padding(
            padding: EdgeInsets.only(right: ThemePadding.small.padding),
            child: Button(
              onPressed: e.callback,
              label: e.label,
              buttonType: e.isPrimary != null && e.isPrimary!
                  ? ButtonType.primary
                  : null,
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(ThemePadding.small.padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AppDialogTitle(title: title),
          Divider(),
          Padding(
            padding: EdgeInsets.all(ThemePadding.small.padding),
            child: child,
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(ThemePadding.small.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...actionsAsWidget,
              ],
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeRadius.medium.radius)),
    );
  }
}
