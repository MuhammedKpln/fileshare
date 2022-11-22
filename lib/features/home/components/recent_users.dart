import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/extensions/async_value.extension.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/home/controllers/home.controller.dart';
import 'package:boilerplate/features/home/models/transfer.model.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:boilerplate/shared/components/avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobx/mobx.dart';

/// A list of avatars that scrolls horizontally
class RecentUsers extends StatelessWidget {
  // ignore: public_member_api_docs
  const RecentUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appController = getIt<HomeViewController>();

    Widget _renderList(ObservableList<Transfer> data) {
      if (data.isEmpty) {
        return const Text(LocaleKeys.noTransfersExists).tr();
      }

      return ListView.separated(
        itemBuilder: (context, index) {
          final transfer = data[index];
          return Avatar(
            child: _Avatar(transfer),
          );
        },
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            right: ThemePadding.small.padding,
          ),
        ),
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
      );
    }

    return Observer(
      builder: (_) {
        if (appController.latestTransfers == null) {
          return const SizedBox.shrink();
        }

        return appController.latestTransfers!.asyncValue(
          pending: CircularProgressIndicator.new,
          fulfilled: _renderList,
          rejected: (error) => Text(error.toString()),
        );
      },
    );
  }

  Widget _Avatar(Transfer transfer) {
    if (transfer.to.avatarUrl != null) {
      return Image.network(
        transfer.to.avatarUrl!,
        fit: BoxFit.cover,
      );
    } else {
      return Assets.images.user.svg(fit: BoxFit.cover);
    }
  }
}
