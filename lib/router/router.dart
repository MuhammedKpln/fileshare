import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/features/auth/login/views/login.view.dart';
import 'package:boilerplate/features/auth/main/views/main.view.dart';
import 'package:boilerplate/features/file_transfer/views/file_transfer.view.dart';
import 'package:boilerplate/features/home/views/home.view.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: MainView,
      initial: true,
      children: [
        AutoRoute(page: HomeView),
        AutoRoute(page: LoginView),
      ],
    ),
    AutoRoute(
      page: FileTransferView,
      deferredLoading: false,
    )
  ],
)
class $AppRouter {}
