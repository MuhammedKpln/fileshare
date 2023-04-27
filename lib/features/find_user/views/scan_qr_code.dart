import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

/// `ScanQRCodeView` is a `StatefulWidget` that takes a
/// `Function(String? codeId)` as a parameter and
/// calls it when a QR code is scanned
@RoutePage()
class ScanQRCodeView extends StatefulWidget {
  // ignore: public_member_api_docs
  const ScanQRCodeView({super.key, required this.onCodeScanned});

  /// A function that takes a string and returns void.
  final void Function(String? codeId) onCodeScanned;

  @override
  State<ScanQRCodeView> createState() => _ScanQRCodeViewState();
}

class _ScanQRCodeViewState extends State<ScanQRCodeView> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  bool codeFound = false;

  void _onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!codeFound) {
        codeFound = true;
        widget.onCodeScanned.call(scanData.code);

        return;
      }
    });
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}
