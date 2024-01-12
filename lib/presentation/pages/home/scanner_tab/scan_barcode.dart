import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/data/bloc/scanner/scanner_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BarcodeReader extends StatefulWidget {
  const BarcodeReader({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarcodeReaderState();
}

class BarcodeReaderState extends State<BarcodeReader> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey barcodeKey = GlobalKey(debugLabel: 'Barcode');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScannerBloc, ScannerState>(
      listenWhen: (previous, current) =>
          previous.scannerStatus != current.scannerStatus,
      listener: (context, state) {
        if (state.isScannerOffScreen()) {
          controller?.pauseCamera();
        } else {
          controller?.resumeCamera();
        }
      },
      child: BlocBuilder<ScannerBloc, ScannerState>(
        builder: (context, state) {
          if (state.isScannerOffScreen()) {
            return Scaffold(body: Text(state.scannerStatus.toString()));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: buildBarcodeReader(context),
                  ),
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('status: ${state.scannerStatus}'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildBarcodeReader(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 450.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: barcodeKey,
      onQRViewCreated: onBarcodeReaderCreated,
      overlay: QrScannerOverlayShape(
          borderColor: kFuriousRedColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (controller, permission) =>
          onPermissionSet(context, controller, permission),
    );
  }

  void onBarcodeReaderCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      context.read<ScannerBloc>().add(ScannerBarcodeScanned(barcode: scanData));
      controller.pauseCamera();
    });
  }

  void onPermissionSet(
      BuildContext context, QRViewController controller, bool permission) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $permission');
    if (!permission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
