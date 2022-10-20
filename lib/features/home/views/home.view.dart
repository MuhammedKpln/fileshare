import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/home/components/appbar.dart';
import 'package:boilerplate/features/home/components/latest_activities.dart';
import 'package:boilerplate/features/home/components/recent_users.dart';
import 'package:boilerplate/features/home/components/section.dart';
import 'package:boilerplate/features/home/views/components/Card.dart';
import 'package:boilerplate/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

/// A stateless widget that displays a title, a text, and a button
class HomeView extends StatelessWidget {
  /// A named constructor.
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromRadius(30),
        child: Appbar(),
      ),
      body: Padding(
        padding: EdgeInsets.all(ThemePadding.medium.padding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeCard(
                    color: ColorPalette.red.color,
                    onPressed: () => context.router.push(const SendFileRoute()),
                    label: 'sendBtnTxt'.tr(),
                    icon: Ionicons.paper_plane_outline,
                  ),
                  HomeCard(
                    color: ColorPalette.primary.color,
                    onPressed: () => null,
                    label: 'receiveBtnTxt'.tr(),
                    icon: Ionicons.cloud_download_outline,
                  ),
                ],
              ),
              Section(
                title: 'sendAgain'.tr(),
                child: const SizedBox(
                  height: 50,
                  child: RecentUsers(),
                ),
              ),
              Section(
                title: 'latestActivities'.tr(),
                trailing: Text(
                  'seeAllBtnTxt',
                  style: Theme.of(context).textTheme.titleSmall,
                ).tr(),
                child: const LatestActivities(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
