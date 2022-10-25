import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/features/auth/main/views/main.view.dart';
import 'package:boilerplate/features/file_transfer/views/file_transfer.view.dart';
import 'package:boilerplate/features/find_user/views/find_user.view.dart';
import 'package:boilerplate/features/find_user/views/scan_qr_code.dart';
import 'package:boilerplate/features/home/views/home.view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: MainView,
      initial: true,
      children: [
        AutoRoute(page: HomeView),
      ],
    ),
    AutoRoute(page: FileTransferView),
    AutoRoute(page: FindUserView, fullscreenDialog: true),
    AutoRoute(page: ScanQRCodeView, fullscreenDialog: true),
  ],
)
// ignore: public_member_api_docs
class $AppRouter {}
