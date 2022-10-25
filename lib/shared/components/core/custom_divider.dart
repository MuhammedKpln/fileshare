import 'package:boilerplate/core/theme/palette.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// A widget that displays a divider with a text in the middle
class AppDivider extends StatelessWidget {
  // ignore: public_member_api_docs
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemePadding.medium.padding),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: Divider(),
          ),
          Text(
            'orDividerTxt',
            style: TextStyle(
              color: ColorPalette.grey.color,
            ),
          ).tr(),
          const Expanded(
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
