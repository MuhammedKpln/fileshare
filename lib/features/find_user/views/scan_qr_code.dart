import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRCodeView extends StatefulWidget {
  const ScanQRCodeView({super.key, required this.onCodeScanned});
  final Function(String? codeId) onCodeScanned;

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
