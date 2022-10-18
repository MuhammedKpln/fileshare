import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/shared/components/avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

///Latest activites item
class LatestActivitiesItem extends StatelessWidget {
  // ignore: public_member_api_docs
  const LatestActivitiesItem({
    super.key,
    required this.username,
    required this.totalFiles,
    required this.sendedItem,
  });

  /// Username
  final String username;

  /// Sended/Received total files
  final int totalFiles;

  /// Has authenticated user sended item?
  final bool sendedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemePadding.small.padding),
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalette.grey.color),
        borderRadius: BorderRadius.circular(ThemeRadius.large.radius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Avatar(
                color: Colors.white,
                child: Icon(
                  sendedItem ? Ionicons.paper_plane : Ionicons.cloud_download,
                  color: sendedItem
                      ? ColorPalette.primary.color
                      : ColorPalette.red.color,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: ThemePadding.medium.padding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'sendToTxt',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ).tr(
                      namedArgs: {'name': username},
                    ),
                    Text(
                      'Archive * $totalFiles files',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => null,
            icon: const Icon(
              Ionicons.ellipsis_horizontal_outline,
            ),
          )
        ],
      ),
    );
  }
}
