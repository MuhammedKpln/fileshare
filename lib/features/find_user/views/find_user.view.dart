import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/extensions/toast.extension.dart';
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/find_user/controllers/find_user.controller.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/routers/app_router.gr.dart';
import 'package:boilerplate/shared/components/button.dart';
import 'package:boilerplate/shared/components/core/custom_appbar.dart';
import 'package:boilerplate/shared/components/core/scaffold.dart';
import 'package:flutter/material.dart';
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
  final text = TextEditingController();

  @override
  void initState() {
    appController.startListener(onNavigate: _onNavigateRequested);
    super.initState();
  }

  @override
  void dispose() {
    getIt.resetLazySingleton<FindUserViewController>();
    super.dispose();
  }

  void generateId() {
    appController.generateId();

    context.toast.showToast('Generated a QR Code!');
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

  void connect() {
    print(text.text);
    appController.connectToPeer(
      text.text,
      () => onConnectionSuccess(text.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                      secondChild: QrImage(
                        data: appController.peerId ?? '',
                        size: 200,
                      ),
                      crossFadeState: appController.peerId != null
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 500),
                      secondCurve: Curves.slowMiddle,
                    );
                  },
                ),
                Observer(builder: (_) {
                  return SelectableText(appController.peerId ?? "");
                }),
                TextFormField(
                  controller: text,
                ),
                ElevatedButton(onPressed: connect, child: Text("qwe")),
                ElevatedButton(onPressed: generateId, child: Text("qwe")),
                Text(
                  'Scan QR code to connect to other peer!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ThemePadding.medium.padding),
                  child: Text(
                    'Scan QR code or generate a qr code for sender.',
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
                  label: 'Send file',
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
                    label: 'Receive file',
                    customStyle: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.all(ThemePadding.medium.padding),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
