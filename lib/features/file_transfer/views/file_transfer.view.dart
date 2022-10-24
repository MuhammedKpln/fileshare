import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/theme/gradient.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/file_transfer/controllers/file_transfer.controller.dart';
import 'package:boilerplate/features/find_user/models/file_information.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/shared/components/back_button.dart';
import 'package:boilerplate/shared/components/button.dart';
import 'package:boilerplate/shared/components/section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// It's a stateful widget that displays a profile card, a section title, and
/// a file
class FileTransferView extends StatefulWidget {
  // ignore: public_member_api_docs
  const FileTransferView({
    super.key,
    required this.sendingFile,
    required this.connectedPeer,
    required this.currentPeer,
  });

  /// A variable that is used to determine the icon to be used in the profil
  /// card.
  final bool sendingFile;

  /// Connected user id
  final String connectedPeer;

  final String currentPeer;

  @override
  State<FileTransferView> createState() => _FileTransferState();
}

class _FileTransferState extends State<FileTransferView> {
  final appController = getIt<FileTransferViewController>();

  @override
  void initState() {
    super.initState();
    appController.startPeerListeners(
      peerId: widget.currentPeer,
      connectedUserPeerId: widget.connectedPeer,
    );

    if (widget.sendingFile) {
      appController.connectToPeer(widget.connectedPeer);
    } else {
      Future.delayed(const Duration(seconds: 3))
          .then((value) => appController.sendUserProfile());
    }
  }

  @override
  void dispose() {
    getIt.resetLazySingleton<FileTransferViewController>();
    super.dispose();
  }

  Widget _renderFilesSection() {
    return Observer(
      builder: (_) {
        if (widget.sendingFile && appController.choosedFilesRaw == null ||
            // ignore: prefer_is_empty
            appController.choosedFilesRaw?.length == 0) {
          return _renderEmptyFilesSection();
        }
        if (!widget.sendingFile && appController.receveidFiles == null ||
            // ignore: prefer_is_empty
            appController.receveidFiles?.length == 0) {
          return _renderEmptyFilesSection();
        }

        return _renderFiles();
      },
    );
  }

  Widget _renderFiles() {
    final files = appController.choosedFiles ?? appController.receveidFiles;
    return Column(
      children: [
        // _FileCategorySectionTitle(),
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final file = files?[index];

              return _File(
                file: file!,
              );
            },
            itemCount: files?.length ?? 0,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Button(
              onPressed: appController.sendFiles,
              label: 'Send files',
              buttonType: ButtonType.primary,
            ),
            Button(
              onPressed: appController.clearFiles,
              label: 'Clear',
            ),
          ],
        )
      ],
    );
  }

  Widget _renderEmptyFilesSection() {
    return _EmptyFilesSection(
      onTap: appController.pickFile,
    );
  }

  IconData get profileCardIcon =>
      widget.sendingFile ? Ionicons.paper_plane : Ionicons.cloud_download;

  LinearGradient get cardBgGradient => widget.sendingFile
      ? ThemeGradient.secondaryGradient
      : ThemeGradient.primaryGradient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Padding(
        padding: EdgeInsets.all(ThemePadding.medium.padding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Observer(
                      builder: (_) {
                        return _ProfileCard(
                          bgGradient: cardBgGradient,
                          files: const [],
                          isSending: widget.sendingFile,
                          totalSize: 0,
                          value: 0,
                        );
                      },
                    ),
                    Section(
                      title: 'fileTransferDetailsSectionTitle'.tr(),
                      trailing: const Icon(Ionicons.ellipsis_horizontal),
                    ),
                    _renderFilesSection()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      title: const Text('transferingProcessTitleTxt').tr(),
      leadingWidth: 72,
      leading: Padding(
        padding: EdgeInsets.only(left: ThemePadding.medium.padding),
        child: const CustomBackButton(),
      ),
      actions: const [
        // Padding(
        //   padding: EdgeInsets.only(right: ThemePadding.medium.padding),
        //   child: RefreshButton(onPressed: () => null, onRefresh: true),
        // )
      ],
    );
  }
}

class _EmptyFilesSection extends StatelessWidget {
  const _EmptyFilesSection({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.animations.empty.lottie(width: 200),
            Text(
              'No files selected.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: ColorPalette.grey.color,
                    ),
                children: [
                  const TextSpan(text: 'Please '),
                  TextSpan(
                    text: 'click me ',
                    style: TextStyle(color: ColorPalette.red.color),
                  ),
                  const TextSpan(text: 'to send files.')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _File extends StatelessWidget {
  const _File({
    required this.file,
  });

  final FileInformation file;

  @override
  Widget build(BuildContext context) {
    final appController = getIt<FileTransferViewController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Assets.images.files.svg(width: 20, height: 20, fit: BoxFit.fill),
            Padding(
              padding: EdgeInsets.only(
                left: ThemePadding.medium.padding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    file.name,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${(file.size / 1000 / 1000).round()}MB",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.grey.shade400),
                  )
                ],
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () => appController.removeFile(file),
          icon: const Icon(Ionicons.ellipsis_horizontal),
          color: Colors.grey.shade400,
        )
      ],
    );
  }
}

class _FileCategorySectionTitle extends StatelessWidget {
  const _FileCategorySectionTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Assets.images.layers.svg(
          width: 50,
          height: 50,
          clipBehavior: Clip.antiAlias,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: ThemePadding.large.padding,
          ),
          child: Text(
            'fileTransferDetailsPhotosCategory',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ).tr(),
        )
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.bgGradient,
    required this.files,
    required this.isSending,
    required this.totalSize,
    required this.value,
  });

  final LinearGradient bgGradient;
  final bool isSending;
  final List<FileInformation> files;
  final int totalSize;
  final double value;

  @override
  Widget build(BuildContext context) {
    final appController = getIt<FileTransferViewController>();
    final localUsername = Supabase
        .instance.client.auth.currentUser!.userMetadata!['username'] as String;

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

                  final username = isSending
                      ? localUsername
                      : appController.connectedPeerUsername!;

                  return _ProfileCardInfo(
                    title: username,
                    subtitle: files.length.toString(),
                  );
                },
              ),
              const _ProfileCardInfo(
                title: 'To',
                subtitle: '64 m/s',
              ),
              Observer(
                builder: (_) {
                  if (appController.connectedPeerUsername == null) {
                    return const CircularProgressIndicator.adaptive();
                  }

                  final username = !isSending
                      ? localUsername
                      : appController.connectedPeerUsername!;

                  return _ProfileCardInfo(
                    title: username,
                    subtitle: (totalSize / 1000 / 1000).round().toString(),
                  );
                },
              ),
            ],
          ),
          _ProgressBar(
            value: value,
          )
        ],
      ),
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
          color: ColorPalette.primary.color,
          backgroundColor: Colors.white,
          minHeight: 20,
        ),
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
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
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
