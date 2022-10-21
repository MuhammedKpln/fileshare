import 'package:boilerplate/core/constants/locale.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/env.dart';
import 'package:boilerplate/features/auth/models/user.model.dart';
import 'package:boilerplate/features/auth/storage/auth.adapter.dart';
import 'package:boilerplate/features/core/app.view.dart';
import 'package:boilerplate/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  configureDependencies();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(UserModelAdapter())
    ..registerAdapter(AuthModelAdapter());
  await EasyLocalization.ensureInitialized();

  print(Env.SUPABASE_URL);
  print(Env.SUPABASE_KEY);
  await Supabase.initialize(
    url: Env.SUPABASE_URL,
    anonKey: Env.SUPABASE_KEY,
    debug: kDebugMode,
    localStorage: const HiveLocalStorage(),
  );

  final locale = AppLocale();

  runApp(
    EasyLocalization(
      supportedLocales: locale.supportedLocales,
      path: locale.localePath,
      fallbackLocale: locale.fallbackLocale,
      assetLoader: const CodegenLoader(),
      child: const App(),
    ),
  );
}
