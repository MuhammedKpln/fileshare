import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

/// It's a ListTile that has a trailing Switch that toggles the theme of the app
class ChangeTheme extends StatelessWidget {
  // ignore: public_member_api_docs
  const ChangeTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = getIt<AppTheme>();

    // ignore: avoid_positional_boolean_parameters
    void onChanged(bool value) {
      if (value) {
        appTheme.setTheme(ThemeMode.dark);
        return;
      }

      appTheme.setTheme(ThemeMode.system);
    }

    return ListTile(
      title: const Text('darkModeTxt').tr(),
      trailing: Observer(
        builder: (_) => Switch(
          onChanged: onChanged,
          value: appTheme.isDarkMode,
        ),
      ),
    );
  }
}
