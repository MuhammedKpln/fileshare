import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/routers/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(
          page: FileTransferRoute.page,
        ),
        AutoRoute(
          page: FindUserRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          page: ScanQRCodeRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          page: SettingsRoute.page,
          fullscreenDialog: true,
        ),
        AutoRoute(
          page: OnboardRoute.page,
          initial: true,
        ),
      ];
}
