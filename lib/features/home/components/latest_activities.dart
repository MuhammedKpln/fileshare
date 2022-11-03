import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/extensions/async_value.extension.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/home/components/latest_activities_item.dart';
import 'package:boilerplate/features/home/controllers/home.controller.dart';
import 'package:boilerplate/features/home/models/transfer.model.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:boilerplate/shared/services/auth.service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobx/mobx.dart';

enum _ActionSheetActions { delete }

/// `LatestActivities` is a `StatelessWidget` that displays a `ListView`
/// of `LatestActivitiesItem`s
class LatestActivities extends StatelessWidget {
  // ignore: public_member_api_docs
  const LatestActivities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appController = getIt<HomeViewController>();
    final authService = getIt<AuthService>();

    Future<void> _deleteTransfer(int id) async {
      await appController.deleteTransfer(id);
    }

    void _onClickElippsis(int id) async {
      final result = await showModalActionSheet<_ActionSheetActions>(
        context: context,
        isDismissible: true,
        actions: [
          SheetAction(
              label: "deleteBtnTxt".tr(),
              isDestructiveAction: true,
              icon: Ionicons.trash,
              key: _ActionSheetActions.delete),
        ],
      );

      switch (result) {
        case _ActionSheetActions.delete:
          await _deleteTransfer(id);
          break;

        default:
          break;
      }
    }

    Widget _renderList(ObservableList<Transfer> data) {
      final authenticatedUser = authService.user;

      if (data.length < 1) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.animations.empty.lottie(width: 200),
              Text(LocaleKeys.noTransfersExists).tr()
            ],
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        itemCount: data.length,
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            bottom: ThemePadding.small.padding,
          ),
        ),
        itemBuilder: (context, index) {
          final transfer = data[index];
          return Dismissible(
            onDismissed: (direction) => _deleteTransfer(transfer.id),
            key: Key(transfer.id.toString()),
            background: _dismissibleBackground(),
            child: LatestActivitiesItem(
              sendedItem: transfer.from == authenticatedUser!.id,
              username: transfer.to.username,
              totalFiles: transfer.file_count,
              onClickElippsis: () => _onClickElippsis(transfer.id),
            ),
          );
        },
      );
    }

    return Observer(builder: (_) {
      if (appController.latestTransfers == null) {
        return SizedBox.shrink();
      }

      return appController.latestTransfers!.asyncValue(
        pending: () => CircularProgressIndicator(),
        fulfilled: _renderList,
        rejected: (error) => Text(error.toString()),
      );
    });
  }

  Container _dismissibleBackground() {
    return Container(
      color: ColorPalette.red.color,
      child: Icon(
        Ionicons.trash,
        color: Colors.white,
      ),
    );
  }
}
