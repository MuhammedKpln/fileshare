import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/core/constants/core.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/features/auth/enums.dart';
import 'package:boilerplate/routers/app_router.gr.dart';
import 'package:boilerplate/routers/auth_router.gr.dart';
import 'package:boilerplate/services/app.service.dart';
import 'package:boilerplate/shared/services/auth.service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

/// `App`
class App extends StatefulWidget {
  // ignore: public_member_api_docs
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final appService = getIt<AppService>();
  final appRouter = AppRouter();
  final authRouter = AuthRouter();

  @override
  void initState() {
    super.initState();
    appService.authService.checkLoginState();
  }

  RootStackRouter _getRouter(AuthService service) {
    if (service.initialized) {
      FlutterNativeSplash.remove();
    }

    if (service.loginState == LoginState.loggedIn) {
      FlutterNativeSplash.remove();

      return appRouter;
    }

    if (service.loginState == LoginState.none) {
      FlutterNativeSplash.remove();

      return authRouter;
    }

    return authRouter;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final loginState = appService.authService;
        return MaterialApp.router(
          key: scaffoldKey,
          title: CoreConstants.appTitle,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: appService.theme.themeData,
          themeMode: appService.theme.mode,
          routerDelegate: _getRouter(loginState).delegate(),
          routeInformationParser: _getRouter(loginState).defaultRouteParser(),
          routeInformationProvider: _getRouter(loginState).routeInfoProvider(),
        );
      },
    );
  }
}
