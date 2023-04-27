import 'package:boilerplate/core/constants/core.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/routers/app_router.dart';
import 'package:boilerplate/services/app.service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Used to access the `ScaffoldState` of the `App` widget.
final GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return MaterialApp.router(
          scaffoldMessengerKey: scaffoldKey,
          title: CoreConstants.appTitle,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: appService.theme.themeData,
          themeMode: appService.theme.mode,
          routerConfig: appRouter.config(),
          builder: (context, child) {
            return ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            );
          },
        );
      },
    );
  }
}
