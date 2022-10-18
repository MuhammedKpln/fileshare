import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/shared/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A stateless widget that returns an AppBar with a title and an action
class Appbar extends StatelessWidget {
  const Appbar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            '22 jan, 2022',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: ColorPalette.grey.color),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: ThemePadding.medium.padding),
          child: Avatar(
            child: SvgPicture.network(
              'https://www.svgrepo.com/show/30132/avatar.svg',
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
