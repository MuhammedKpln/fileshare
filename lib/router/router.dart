import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/features/auth/main/views/main.view.dart';
import 'package:boilerplate/features/auth/views/login/login.view.dart';
import 'package:boilerplate/features/file_transfer/views/file_transfer.view.dart';
import 'package:boilerplate/features/home/views/home.view.dart';
import 'package:boilerplate/router/guards/auth.guard.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: MainView,
      initial: true,
      children: [
        AutoRoute(page: HomeView),
      ],
      guards: [AuthGuard],
    ),
    AutoRoute(
      page: FileTransferView,
      deferredLoading: true,
    ),
    AutoRoute(
      page: LoginView,
      deferredLoading: true,
    )
  ],
)
class $AppRouter {}
