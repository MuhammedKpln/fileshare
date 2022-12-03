import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/home/components/home_appbar.dart';
import 'package:boilerplate/features/home/controllers/home.controller.dart';
import 'package:boilerplate/features/home/models/nearby_device.model.dart';
import 'package:boilerplate/features/home/views/components/card.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:boilerplate/routers/app_router.gr.dart';
import 'package:boilerplate/shared/components/section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ignore: public_member_api_docs
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
    super.initState();
    appController.init(onNavigate: onNavigate);
  }

  void onNavigate(String peerId) {
    context.router.navigate(
      FindUserRoute(
        peerId: appController.myDeviceInformation.uuid,
        remotePeerId: peerId,
      ),
    );
  }

  void connect(NearbyDevice device) {
    appController.channel.send(
      type: RealtimeListenTypes.broadcast,
      event: 'navigate',
      payload: appController.myDeviceInformation.toMap(),
    );

    context.router.navigate(
      FindUserRoute(
        peerId: appController.myDeviceInformation.uuid,
        remotePeerId: device.uuid,
        peerStartedConnection: true,
      ),
    );
  }

  @override
  void dispose() {
    appController.dispose();
    super.dispose();
  }

  IconData _getPlatformIcon(String platform) {
    switch (platform) {
      case 'ios':
        return Ionicons.logo_apple;
      case 'android':
        return Ionicons.logo_android;
      case 'linux':
        return Ionicons.logo_tux;
      case 'macos':
        return Ionicons.logo_apple;
      case 'windows':
        return Ionicons.logo_windows;

      default:
        return Ionicons.planet_outline;
    }
  }

  String _getPlatformDescription(String platform) {
    switch (platform) {
      case 'ios':
        return 'Apple iPhone';
      case 'android':
        return 'Android';
      case 'linux':
        return 'Linux';
      case 'macos':
        return 'Apple macOS';
      case 'windows':
        return 'Microsoft Windows';

      default:
        return 'Mars';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromRadius(50),
        child: HomeAppBar(),
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
                title: LocaleKeys.nearbyDevicesTitle.tr(),
                subtitle: LocaleKeys.nearbyDevicesSubTitle.tr(),
              ),
              deviceIdIndicator(),
              Observer(
                builder: (_) {
                  if (appController.nearbyDevices.isNotEmpty) {
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final user = appController.nearbyDevices[index];
                          return ListTile(
                            onTap: () => connect(user!),
                            leading: _renderIcon(user),
                            title: Text(user!.username),
                            subtitle:
                                Text(_getPlatformDescription(user.platform)),
                          );
                        },
                        itemCount: appController.nearbyDevices.length,
                      ),
                    );
                  }

                  return Center(
                    child: Assets.animations.discover.lottie(
                      height: 300,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding deviceIdIndicator() {
    return Padding(
      padding: EdgeInsets.only(bottom: ThemePadding.medium.padding),
      child: Center(
        child: Observer(
          builder: (_) {
            return RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.grey),
                children: [
                  const WidgetSpan(
                    child: Icon(Ionicons.wifi_outline),
                  ),
                  const TextSpan(text: "You're known as "),
                  TextSpan(
                    text: appController.myDeviceInformation.username,
                    style: TextStyle(color: ColorPalette.primary.color),
                  ),
                  TextSpan(
                    text: appController.myDeviceInformation.uuid,
                    style: TextStyle(color: ColorPalette.primary.color),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _renderIcon(NearbyDevice? user) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette.primary.color,
        borderRadius: BorderRadius.circular(ThemeRadius.medium.radius),
      ),
      padding: EdgeInsets.all(ThemePadding.small.padding),
      child: Icon(_getPlatformIcon(user!.platform), color: Colors.white),
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
      FindUserRoute(),
    );
  }
}
