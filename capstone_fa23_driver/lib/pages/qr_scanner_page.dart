import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quét mã QR',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        controller.stopCamera();
        Future.delayed(const Duration(seconds: 1), () {
          context.push("/orders/map-view/${scanData.code}");
        });
      }
    }, onDone: () {
      // if (result == null) {
      //   return;
      // }
    }, onError: (error) {
      // if (kDebugMode) {
      //   print(error.toString());
      // }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
