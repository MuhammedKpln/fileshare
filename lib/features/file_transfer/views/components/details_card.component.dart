import 'package:auto_size_text/auto_size_text.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/file_transfer/controllers/file_transfer.controller.dart';
import 'package:boilerplate/features/find_user/models/file_information.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

/// It's a widget that shows the current status of the file transfer
class ProfileCard extends StatelessWidget {
  // ignore: public_member_api_docs
  const ProfileCard({
    super.key,
    required this.bgGradient,
    required this.files,
    required this.isSending,
  });

  /// A variable that is used to set the background gradient of the widget.
  final LinearGradient bgGradient;

  /// If local user is sending the file.
  final bool isSending;

  /// A list of files that are being sent/received.
  final List<FileInformation> files;

  @override
  Widget build(BuildContext context) {
    final appController = getIt<FileTransferViewController>();
    final localUsername = appController.localUsername;

    return Container(
      height: 200,
      padding: EdgeInsets.all(ThemePadding.large.padding),
      decoration: BoxDecoration(
        gradient: bgGradient,
        borderRadius: BorderRadius.circular(ThemeRadius.large.radius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Observer(
                builder: (_) {
                  if (appController.connectedPeerUsername == null) {
                    return const CircularProgressIndicator.adaptive();
                  }

                  final username = localUsername;
                  final localeUsername =
                      LocaleKeys.fileTransferViewSendingUsername.tr(
                    namedArgs: {'name': username},
                  );

                  return _ProfileCardInfo(
                    title: localeUsername,
                    subtitle: '${files.length} Sending files',
                  );
                },
              ),
              _ProfileCardInfo(
                title: LocaleKeys.toUser.tr(),
                subtitle: '',
              ),
              Observer(
                builder: (_) {
                  if (appController.connectedPeerUsername == null) {
                    return const CircularProgressIndicator.adaptive();
                  }

                  final username =
                      appController.connectedPeerUsername ?? 'ERROR';

                  return _ProfileCardInfo(
                    title: username,
                    subtitle:
                        '${appController.transferedFiles.length} Received files',
                  );
                },
              ),
            ],
          ),
          Observer(
            builder: (_) {
              if (appController.gettedData == 0) {
                return const SizedBox.shrink();
              }

              return _ProgressBar(
                value: appController.progressPercent,
              );
            },
          )
        ],
      ),
    );
  }
}

class _ProfileCardInfo extends StatelessWidget {
  const _ProfileCardInfo({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        AutoSizeText(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
        )
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ThemeRadius.small.radius),
      child: SizedBox(
        width: double.infinity,
        child: LinearProgressIndicator(
          value: value,
          minHeight: 20,
        ),
      ),
    );
  }
}
