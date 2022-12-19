import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/features/file_transfer/views/file_transfer.view.dart';
import 'package:boilerplate/features/find_user/views/find_user.view.dart';
import 'package:boilerplate/features/find_user/views/scan_qr_code.dart';
import 'package:boilerplate/features/home/views/home.view.dart';
import 'package:boilerplate/features/onboard/views/onboard.view.dart';
import 'package:boilerplate/features/settings/views/settings.view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomeView,
      deferredLoading: true,
    ),
    AutoRoute(page: FileTransferView, deferredLoading: true),
    AutoRoute(
      page: FindUserView,
      fullscreenDialog: true,
      deferredLoading: true,
    ),
    AutoRoute(
      page: ScanQRCodeView,
      fullscreenDialog: true,
      deferredLoading: true,
    ),
    AutoRoute(
      page: SettingsView,
      fullscreenDialog: true,
      deferredLoading: true,
    ),
    AutoRoute(page: OnboardView, deferredLoading: true, initial: true)
  ],
)
// ignore: public_member_api_docs
class $AppRouter {}
