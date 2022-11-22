import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/home/components/appbar.dart';
import 'package:boilerplate/features/home/components/latest_activities.dart';
import 'package:boilerplate/features/home/components/recent_users.dart';
import 'package:boilerplate/features/home/controllers/home.controller.dart';
import 'package:boilerplate/features/home/views/components/card.dart';
import 'package:boilerplate/routers/app_router.gr.dart';
import 'package:boilerplate/shared/components/section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomeView extends StatefulWidget {
  /// A named constructor.
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final appController = getIt<HomeViewController>();

  @override
  void initState() {
    appController.init();
    super.initState();
  }

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
                    onPressed: () =>
                        navigateToFileShare(sending: true, context: context),
                    label: 'sendBtnTxt'.tr(),
                    icon: Ionicons.paper_plane_outline,
                  ),
                  HomeCard(
                    color: ColorPalette.primary.color,
                    onPressed: () =>
                        navigateToFileShare(sending: false, context: context),
                    label: 'receiveBtnTxt'.tr(),
                    icon: Ionicons.cloud_download_outline,
                  ),
                ],
              ),
              Section(
                title: 'sendAgain'.tr(),
              ),
              const SizedBox(
                height: 50,
                child: RecentUsers(),
              ),
              Section(
                title: 'latestActivities'.tr(),
                trailing: Text(
                  'seeAllBtnTxt',
                  style: Theme.of(context).textTheme.titleSmall,
                ).tr(),
              ),
              const LatestActivities()
            ],
          ),
        ),
      ),
    );
  }

  /// It navigates to the FileTransferRoute.
  ///
  /// Args:
  ///   sending (bool): A boolean value that determines whether the user is
  ///   sending or receiving a file. context (BuildContext): The context of the
  ///   current screen.
  ///
  /// Returns:
  ///   A Future<void>
  Future<void> navigateToFileShare({
    required bool sending,
    required BuildContext context,
  }) async {
    return context.router.navigate(
      const FindUserRoute(),
    );
  }
}
