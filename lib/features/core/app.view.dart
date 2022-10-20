import 'package:boilerplate/core/constants/core.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/router/router.gr.dart';
import 'package:boilerplate/services/app.service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

/// `App`
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final appController = getIt<AppService>();

  @override
  void initState() {
    super.initState();
    appController.checkLoginState();
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final appService = getIt<AppService>();

    return Observer(
      builder: (context) {
        try {
          return MaterialApp.router(
            title: CoreConstants.appTitle,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: appService.theme.themeData,
            themeMode: appService.theme.mode,
            routerDelegate: appRouter.delegate(),
            routeInformationProvider: appRouter.routeInfoProvider(),
            routeInformationParser: appRouter.defaultRouteParser(),
          );
        } catch (err) {
          print(err);
          return const SizedBox.shrink();
        }
      },
    );
  }
}
