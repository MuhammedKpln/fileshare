import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/auth/controllers/auth.controller.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:boilerplate/shared/components/avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//TODO: refactor
/// A stateless widget that returns an AppBar with a title and an action
class Appbar extends StatelessWidget {
  const Appbar();

  @override
  Widget build(BuildContext context) {
    final controller = getIt<AuthViewController>();
    final date = DateFormat("d MMMM yyyy").format(DateTime.now()).toUpperCase();

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
      actions: [
        InkWell(
          onTap: controller.logout,
          child: Padding(
            padding: EdgeInsets.only(right: ThemePadding.medium.padding),
            child: Avatar(child: Assets.images.user.svg(fit: BoxFit.cover)),
          ),
        )
      ],
    );
  }
}
