import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/features/settings/controllers/settings.controller.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

/// `SettingsPageChangeDownloadsDir` is a `StatelessWidget` that displays a
/// `ListTile` with the text 'Change Downloads Directory'
class SettingsPageChangeDownloadsDir extends StatefulWidget {
  // ignore: public_member_api_docs
  const SettingsPageChangeDownloadsDir({super.key});

  @override
  State<SettingsPageChangeDownloadsDir> createState() =>
      _SettingsPageChangeDownloadsDir();
}

class _SettingsPageChangeDownloadsDir
    extends State<SettingsPageChangeDownloadsDir> {
  final controller = getIt<SettingsController>();

  @override
  void initState() {
    super.initState();

    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListTile(
          title: Text(LocaleKeys.changeDownloadsDir.tr()),
          subtitle: Text(controller.downloadDir ?? 'NULL'),
          onTap: controller.changeDownloadsDirectory,
        );
      },
    );
  }
}
