// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AppLocale {
  final String localePath = 'assets/translations';

  Future<void> updateLocale(Locale l, BuildContext context) async {
    final engine = WidgetsFlutterBinding.ensureInitialized();

    if (l == context.locale) {
      return;
    }

    await context.setLocale(l);
    await engine.performReassemble();
  }

  Locale get fallbackLocale => _SupportedLocales.values
      .where((element) => element.primary != null)
      .map((e) => e.locale)
      .toList()
      .first;

  List<Locale> get supportedLocales =>
      _SupportedLocales.values.map((e) => e.locale).toList();
}

/// App supported locales
enum _SupportedLocales {
  en(Locale('en'), primary: true),
  tr(Locale('tr'));

  final Locale locale;
  final bool? primary;
  const _SupportedLocales(this.locale, {this.primary});
}
