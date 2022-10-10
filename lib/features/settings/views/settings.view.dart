import 'package:boilerplate/features/settings/components/changeLocale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// It's a stateless widget that displays a list of settings
class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final List<Widget> _settings = [const ChangeLocale()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('settingsViewTitle').tr(),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final component = _settings[index];

          return component;
        },
        itemCount: _settings.length,
      ),
    );
  }
}