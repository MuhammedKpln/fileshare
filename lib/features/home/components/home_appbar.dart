import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// A stateless widget that returns an AppBar with a title and an action
class HomeAppBar extends StatelessWidget {
  // ignore: public_member_api_docs
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('d MMMM yyyy').format(DateTime.now()).toUpperCase();

    return AppBar(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.dashboardTitleTxt,
            style: Theme.of(context).textTheme.titleLarge,
          ).tr(),
          Text(
            date,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: ColorPalette.grey.color),
          ),
        ],
      ),
    );
  }
}
