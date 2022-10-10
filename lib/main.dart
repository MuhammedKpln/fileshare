import 'package:boilerplate/core/constants/locale.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/features/auth/models/user.model.dart';
import 'package:boilerplate/features/core/app.view.dart';
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
