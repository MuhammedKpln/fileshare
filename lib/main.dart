import 'package:boilerplate/core/constants/core.dart';
import 'package:boilerplate/features/auth/models/user.model.dart';
import 'package:boilerplate/features/core/controllers/app.controller.dart';
import 'package:boilerplate/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  runApp(
    const App(),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final appController = AppController();

  @override
  void initState() {
    super.initState();
    appController.checkLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppController>(
          create: (context) => appController,
        ),
        Provider<AppRouter>(
          create: (context) => AppRouter(appController),
        ),
      ],
      builder: (context, child) {
        final goRouter = Provider.of<AppRouter>(context, listen: false).router;

        return MaterialApp.router(
          title: CoreConstants.appTitle,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerConfig: goRouter,
        );
      },
    );
  }
}
