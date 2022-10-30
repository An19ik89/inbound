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
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
    var provider = Provider.of<DashViewModel>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context,provider)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context,DashViewModel provider) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 300.0.w
        : 300.0.w;

    return QRView(
      key: qrKey,
      onQRViewCreated:(ctrl) => _onQRViewCreated(ctrl,provider),
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10.r,
          borderLength: 30.r,
          borderWidth: 10.r,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller,DashViewModel provider) {

      this.controller = controller;

    controller.scannedDataStream.listen((scanData) {

        result = scanData;
        alertDialog(provider);


    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
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

  alertDialog(DashViewModel provider){
    controller!.pauseCamera();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
      return  AlertDialog(
      title:  CText(
        text: 'Scan Result',
        fontWeight: FontWeight.w700,
        color: Colors.black,
        size: 20.sp,
        fontFamily: FontRes.bold,
      ),
      content:  CText(
            text: result?.code ??'',
            fontWeight: FontWeight.w500,
            color: Colors.black,
            size: 18.sp,
            fontFamily: FontRes.regular,
          ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent
          ),
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
          backgroundColor: ColorRes.green_08BA64
          ),
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
    );});
  }
}