import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/features/find_user/controllers/find_user.controller.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/shared/components/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

/// It's a stateless widget that displays a form to enter a user id,
///  and a button to connect to that
/// user
class ManualFindUser extends StatelessWidget {
  // ignore: public_member_api_docs
  const ManualFindUser({super.key, required this.onConnect});

  /// A callback function that is called when the button is pressed.
  final VoidCallback onConnect;

  @override
  Widget build(BuildContext context) {
    final appController = getIt<FindUserViewController>();

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Assets.animations.connect.lottie(repeat: false, width: 200),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: appController.formState,
            child: Column(
              children: [
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'peerIdFormLabelTxt'.tr()),
                  validator: appController.validateFormFindUserId,
                  controller: appController.formFields['findUserId'],
                ),
              ],
            ),
          ),
          Observer(
            builder: (_) {
              return Button(
                onPressed: onConnect,
                label: 'connectBtnTxt'.tr(),
                loading: appController.connecting,
                buttonType: ButtonType.primary,
              );
            },
          )
        ],
      ),
    );
  }
}
