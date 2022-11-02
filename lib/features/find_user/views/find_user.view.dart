import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/extensions/show_bottom_sheet.dart';
import 'package:boilerplate/core/extensions/toast.extension.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/find_user/controllers/find_user.controller.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/routers/app_router.gr.dart';
import 'package:boilerplate/shared/components/button.dart';
import 'package:boilerplate/shared/components/core/custom_appbar.dart';
import 'package:boilerplate/shared/components/core/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// `FindUserView` is a `StatefulWidget` that creates a `_FindUserViewState`
/// when it's created
class FindUserView extends StatefulWidget {
  // ignore: public_member_api_docs
  const FindUserView({super.key});

  @override
  State<FindUserView> createState() => _FindUserViewState();
}

class _FindUserViewState extends State<FindUserView> {
  final appController = getIt<FindUserViewController>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    appController.startListener(onNavigate: _onNavigateRequested);
    appController.askForConnectingFromClipboard(
      (clipboardData) => print(clipboardData),
    );
    super.initState();
  }

  @override
  void dispose() {
    getIt.resetLazySingleton<FindUserViewController>();
    super.dispose();
  }

  void generateId() async {
    appController.generateId();
    final id = appController.pId;

    await Clipboard.setData(ClipboardData(text: id));

    context.toast.showToast("generatedQrCode".tr());
  }

  Future<void> _onNavigateRequested(String peerId) async {
    await context.router.push(
      FileTransferRoute(
        sendingFile: false,
        currentPeer: appController.peerId!,
        connectedPeer: peerId,
      ),
    );
  }

  Future<void> onConnectionSuccess(String connectedPeerId) async {
    await context.router.push(
      FileTransferRoute(
        sendingFile: true,
        currentPeer: appController.pId!,
        connectedPeer: connectedPeerId,
      ),
    );
  }

  Future<void> scanQrCode() async {
    await context.router.push(
      ScanQRCodeRoute(
        onCodeScanned: (p0) async {
          context.navigateBack();
          appController.connectToPeer(
            p0!,
            () => onConnectionSuccess(p0),
          );
        },
      ),
    );
  }

  void connect(BuildContext _context) {
    if (appController.formState.currentState!.validate()) {
      appController.connectToPeer(
        appController.formFindUserId!,
        () async {
          await _context.router.pop();
          onConnectionSuccess(appController.formFindUserId!);
        },
      );

      return;
    }
  }

  void showTextInputDialog() async {
    await context.showBottomSheet<void>(
        child: _renderBottomSheet(), title: "connectToPeer".tr());
  }

  Widget _renderBottomSheet() {
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
                        InputDecoration(labelText: "peerIdFormLabelTxt".tr()),
                    validator: appController.validateFormFindUserId,
                    controller: appController.formFields["findUserId"],
                  ),
                ],
              )),
          Observer(builder: (_) {
            return Button(
                onPressed: () => connect(context),
                label: "connectBtnTxt".tr(),
                loading: appController.connecting,
                buttonType: ButtonType.primary);
          })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: CustomAppBar(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Observer(
                builder: (_) {
                  if (appController.connecting) {
                    return const CircularProgressIndicator();
                  }

                  return AnimatedCrossFade(
                    firstChild: Assets.animations.qr.lottie(repeat: true),
                    secondChild: _secondChild(),
                    crossFadeState: appController.peerId != null
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 500),
                    secondCurve: Curves.slowMiddle,
                  );
                },
              ),
              Text(
                'findUserTitle'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.only(top: ThemePadding.medium.padding),
                child: Text(
                  'findUserDesc'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: ColorPalette.grey.color),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Button(
                onPressed: scanQrCode,
                label: 'sendFileBtnTxt'.tr(),
                buttonType: ButtonType.primary,
                customStyle: ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.all(ThemePadding.medium.padding),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ThemePadding.medium.padding),
                child: Button(
                  onPressed: generateId,
                  label: 'receiveFileBtnTxt'.tr(),
                  customStyle: ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.all(ThemePadding.medium.padding),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: showTextInputDialog,
                  child: Text("manualConnectingBtnTxt").tr())
            ],
          )
        ],
      ),
    );
  }

  Widget _secondChild() {
    return Column(
      children: [
        QrImage(
          data: appController.peerId ?? '',
          size: 200,
        ),
      ],
    );
  }
}
