import 'package:boilerplate/core/theme/gradient.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/shared/components/back_button.dart';
import 'package:boilerplate/shared/components/refresh_button.dart';
import 'package:boilerplate/shared/components/section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

/// It's a stateful widget that displays a profile card, a section title, and
/// a file
class FileTransferView extends StatefulWidget {
  // ignore: public_member_api_docs
  const FileTransferView({super.key, required this.sendingFile});

  /// A variable that is used to determine the icon to be used in the profil
  /// card.
  final bool sendingFile;

  @override
  State<FileTransferView> createState() => _FileTransferState();
}

class _FileTransferState extends State<FileTransferView> {
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
                    _ProfileCard(bgGradient: cardBgGradient),
                    Section(
                      title: 'fileTransferDetailsSectionTitle'.tr(),
                      trailing: const Icon(Ionicons.ellipsis_horizontal),
                    ),
                    const _FileCategorySectionTitle(),
                    const _File()
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
      actions: [
        Padding(
          padding: EdgeInsets.only(right: ThemePadding.medium.padding),
          child: RefreshButton(onPressed: () => null, onRefresh: true),
        )
      ],
    );
  }
}

class _File extends StatelessWidget {
  const _File();

  @override
  Widget build(BuildContext context) {
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
                    'Preview.mp4',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '8 MB',
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
          onPressed: () => null,
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
  const _ProfileCard({required this.bgGradient});

  final LinearGradient bgGradient;

  @override
  Widget build(BuildContext context) {
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
            children: const [
              _ProfileCardInfo(title: 'Micheal', subtitle: '4 of 6 files'),
              _ProfileCardInfo(
                title: 'To',
                subtitle: '64 m/s',
              ),
              _ProfileCardInfo(title: 'Jason', subtitle: '8 of 12MB'),
            ],
          ),
          const _ProgressBar()
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ThemeRadius.small.radius),
      child: SizedBox(
        width: double.infinity,
        child: LinearProgressIndicator(
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
