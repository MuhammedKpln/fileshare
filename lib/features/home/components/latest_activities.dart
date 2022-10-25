import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/home/components/latest_activities_item.dart';
import 'package:flutter/material.dart';

/// `LatestActivities` is a `StatelessWidget` that displays a `ListView`
/// of `LatestActivitiesItem`s
class LatestActivities extends StatelessWidget {
  // ignore: public_member_api_docs
  const LatestActivities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
          bottom: ThemePadding.small.padding,
        ),
      ),
      itemBuilder: (context, index) {
        return LatestActivitiesItem(
          sendedItem: index % 2 == 0 ? true : false,
          username: 'Selam $index',
          totalFiles: index,
        );
      },
    );
  }
}
