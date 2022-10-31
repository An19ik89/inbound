import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/ui/page/dash/dash_viewmodel.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

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
    var provider = Provider.of<DashViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context, provider),
          Positioned(
            top: 40.h,
            right: 30.w,
            child: InkWell(
              onTap: () async {
                await controller?.flipCamera();
              },
              child: Icon(
                Icons.flip_camera_android_outlined,
                color: Colors.white,
                size: 40.r,
              ),
            ),
          ),
          Positioned(
              bottom: 20.h,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      await controller?.pauseCamera();
                    },
                    child: Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 30.r,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await controller?.resumeCamera();
                    },
                    child: Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 50.r,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await controller?.toggleFlash();
                    },
                    child: Icon(
                      Icons.flash_on,
                      color: Colors.white,
                      size: 30.r,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context, DashViewModel provider) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400.h ||
            MediaQuery.of(context).size.height < 400.h)
        ? 300.0.w
        : 300.0.w;

    return QRView(
      key: qrKey,
      onQRViewCreated: (ctrl) => _onQRViewCreated(ctrl, provider),
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10.r,
          borderLength: 30.r,
          borderWidth: 10.r,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller, DashViewModel provider) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      alertDialog(provider);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
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

  alertDialog(DashViewModel provider) {
    controller!.pauseCamera();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: CText(
              text: 'Scan Result',
              fontWeight: FontWeight.w700,
              color: Colors.black,
              size: 20.sp,
              fontFamily: FontRes.bold,
            ),
            content: CText(
              text: result?.code ?? '',
              fontWeight: FontWeight.w500,
              color: Colors.black,
              size: 18.sp,
              fontFamily: FontRes.regular,
            ),
            actions: [
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: Colors.redAccent),
                onPressed: () {
                  Navigator.of(context).pop();
                  controller!.resumeCamera();
                },
                child: CText(
                  text: 'Cancel',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  size: 16.sp,
                  fontFamily: FontRes.medium,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: ColorRes.green_08BA64),
                onPressed: () {
                  provider.barcode = result?.code ?? null;
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: CText(
                  text: 'Accept',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  size: 16.sp,
                  fontFamily: FontRes.medium,
                ),
              ),
            ],
          );
        });
  }
}
