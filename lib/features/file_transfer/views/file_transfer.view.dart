import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/theme/gradient.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/file_transfer/controllers/file_transfer.controller.dart';
import 'package:boilerplate/features/file_transfer/helpers/transfer.helper.dart';
import 'package:boilerplate/features/file_transfer/views/components/details_card.component.dart';
import 'package:boilerplate/features/file_transfer/views/components/empty_files_section.component.dart';
import 'package:boilerplate/features/file_transfer/views/components/file_details.component.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:boilerplate/shared/components/back_button.dart';
import 'package:boilerplate/shared/components/button.dart';
import 'package:boilerplate/shared/components/section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';

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
      onUserDisconnect: onUserDisconnect,
    );

    if (widget.sendingFile) {
      appController.connectToPeer(
        widget.connectedPeer,
        onUserDisconnect: onUserDisconnect,
      );
    }
  }

  void onUserDisconnect() {
    context.router.navigateBack();
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

        return _renderFiles(sendingFile: widget.sendingFile);
      },
    );
  }

  void _onPressed() {
    appController.isTransfering = true;
    TransferHelper.startIsolate();
  }

  Widget renderActionButtons() {
    if (!widget.sendingFile) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Observer(
          builder: (_) {
            return Button(
              onPressed: _onPressed,
              label: 'transferFilesBtnTxt'.tr(),
              buttonType: ButtonType.primary,
              loading: appController.isTransfering,
            );
          },
        ),
        Button(
          onPressed: appController.clearFiles,
          label: 'clearFilesBtnTxt'.tr(),
        ),
      ],
    );
  }

  Widget _renderFiles({required bool sendingFile}) {
    final files = appController.choosedFiles ?? appController.receveidFiles;

    return Column(
      children: [
        // _FileCategorySectionTitle(),
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final file = files![index];

              return File(
                file: file,
                sendingFile: sendingFile,
              );
            },
            itemCount: files?.length ?? 0,
          ),
        ),

        renderActionButtons()
      ],
    );
  }

  Widget _renderEmptyFilesSection() {
    final onTap = widget.sendingFile ? appController.pickFile : () => null;
    return EmptyFilesSection(
      onTap: onTap,
    );
  }

  IconData get profileCardIcon =>
      widget.sendingFile ? Ionicons.paper_plane : Ionicons.cloud_download;

  LinearGradient get cardBgGradient => widget.sendingFile
      ? ThemeGradient.secondaryGradient
      : ThemeGradient.primaryGradient;

  Widget renderDisconnectedView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: ThemePadding.large.padding),
          child: Text(
            LocaleKeys.userDisconnectedMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ).tr(),
        ),
        Assets.animations.disconnected.lottie(
          height: 200,
        ),
      ],
    );
  }

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
                child: Observer(
                  builder: (_) {
                    if (appController.disconnected) {
                      return renderDisconnectedView();
                    }

                    return Column(
                      children: [
                        Observer(
                          builder: (_) {
                            return ProfileCard(
                              bgGradient: cardBgGradient,
                              files: appController.choosedFiles ??
                                  appController.receveidFiles ??
                                  [],
                              isSending: widget.sendingFile,
                            );
                          },
                        ),
                        Section(
                          title: 'fileTransferDetailsSectionTitle'.tr(),
                        ),
                        Observer(
                          builder: (_) {
                            return _renderFilesSection();
                          },
                        )
                      ],
                    );
                  },
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
