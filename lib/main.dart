import 'package:boilerplate/core/constants/core.dart';
import 'package:boilerplate/core/constants/locale.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/features/auth/models/user.model.dart';
import 'package:boilerplate/router/router.dart';
import 'package:boilerplate/services/app.service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  configureDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await EasyLocalization.ensureInitialized();
  final locale = AppLocale();

  runApp(
    EasyLocalization(
      supportedLocales: locale.supportedLocales,
      path: locale.localePath,
      fallbackLocale: locale.fallbackLocale,
      child: const App(),
    ),
  );
}

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
    final goRouter = getIt<AppRouter>().router;

    return MaterialApp.router(
      title: CoreConstants.appTitle,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }
}
