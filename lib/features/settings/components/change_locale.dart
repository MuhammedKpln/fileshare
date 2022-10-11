import 'package:boilerplate/core/constants/locale.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/extensions/toast.extension.dart';
import 'package:boilerplate/core/theme/toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// It's a ListTile that allows the user to change the app locale
class ChangeLocale extends StatelessWidget {
  // ignore: public_member_api_docs
  const ChangeLocale({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocale = getIt<AppLocale>();
    final supportedLocales = appLocale.supportedLocales
        .map(
          (e) => DropdownMenuItem<Locale>(
            value: e,
            child: Text(e.languageCode),
          ),
        )
        .toList();

    Future<void> onChanged(Locale? locale) async {
      if (locale != null) {
        if (appLocale.supportedLocales.contains(locale)) {
          await context.setLocale(locale);
          context.toast.showToast('OK', toastType: ToastType.success);

          return;
        }

        context.toast.showToast(
          'appLocaleNotFoundError'.tr(),
          toastType: ToastType.error,
        );
      }
    }

    return ListTile(
      title: const Text('appLocaleSettingsTxt').tr(),
      trailing: DropdownButton<Locale>(
        items: supportedLocales,
        value: context.locale,
        onChanged: onChanged,
      ),
    );
  }
}
