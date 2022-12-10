import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/file_transfer/controllers/file_transfer.controller.dart';
import 'package:boilerplate/features/file_transfer/helpers/transfer.helper.dart';
import 'package:boilerplate/features/find_user/models/file_information.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

/// It renders a file information
class File extends StatelessWidget {
  // ignore: public_member_api_docs
  const File({
    super.key,
    required this.file,
    required this.sendingFile,
  });

  /// File information to be displayed
  final FileInformation file;

  /// If local userr is sending files.
  final bool sendingFile;

  @override
  Widget build(BuildContext context) {
    final appController = getIt<FileTransferViewController>();

    Widget renderRemoveIcon() {
      if (!sendingFile) const SizedBox.shrink();

      return IconButton(
        onPressed: () => appController.removeFile(file),
        icon: const Icon(Ionicons.ellipsis_horizontal),
        color: Colors.grey.shade400,
      );
    }

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
                    TransferHelper.formatBytes(file.size),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.grey.shade400),
                  ),
                  // Observer(
                  //   builder: (_) {
                  //     if (file == null) return const SizedBox.shrink();

                  //     return Text(
                  //       file.transfered
                  //           ? 'doneTransferingTxt'.tr()
                  //           : appController.fileTransfering?.name ==
                  //                       file.name &&
                  //                   appController.gettedData > 0
                  //               ? 'transferingTxt..'.tr()
                  //               : '',
                  //       style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  //             color: !file.transfered
                  //                 ? Colors.orange
                  //                 : ColorPalette.primary.color,
                  //           ),
                  //     );
                  //   },
                  // )
                ],
              ),
            ),
          ],
        ),
        renderRemoveIcon(),
      ],
    );
  }
}
