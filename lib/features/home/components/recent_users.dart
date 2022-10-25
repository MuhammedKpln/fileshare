import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/shared/components/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A list of avatars that scrolls horizontally
class RecentUsers extends StatelessWidget {
  // ignore: public_member_api_docs
  const RecentUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Avatar(
          child: SvgPicture.network(
            'https://www.svgrepo.com/show/30132/avatar.svg',
            fit: BoxFit.cover,
          ),
        );
      },
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
          right: ThemePadding.small.padding,
        ),
      ),
      itemCount: 10,
      scrollDirection: Axis.horizontal,
    );
  }
}
