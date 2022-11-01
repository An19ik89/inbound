import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:inbound_flutter/core/route/route_paths.dart';
import 'package:inbound_flutter/core/session/session.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:inbound_flutter/ui/widget/c_textfield.dart';
import 'package:inbound_flutter/utils/date_time_utils.dart';
import 'package:inbound_flutter/utils/excel_utils.dart';
import 'package:inbound_flutter/utils/image_utils.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';
import 'package:inbound_flutter/utils/res/image_res.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'dash_viewmodel.dart';

class DashPage extends StatefulWidget {
  const DashPage({Key? key}) : super(key: key);

  @override
  State<DashPage> createState() => _DashState();
}

class _DashState extends State<DashPage> {
  var imageUtils = di<ImageUtils>();
  var dateTimeUtils = di<DateTimeUtils>();
  var excelUtils = di<ExcelUtils>();
  final Session session = di<Session>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DashViewModel>(context);
    return Container(
      color: Colors.amber,
      child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: ColorRes.white_F7F7F7,
            drawerEnableOpenDragGesture: false,
            appBar: AppBar(
              title: CText(
                text: 'InBound',
                fontWeight: FontWeight.w600,
                color: Colors.white,
                size: 18.sp,
                fontFamily: FontRes.bold,
              ),
              leading: Builder(
                  builder: (context) => IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(
                        Icons.menu_outlined,
                        color: Colors.white,
                        size: 25.r,
                      ))),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 25.r,
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        dateTimeUtils
                            .selectDateFromPicker(context)
                            .then((value) {
                          if (value != null) {
                            provider.dobDay =
                                DateFormat('dd').format(value).toString();
                            provider.dobMonth =
                                DateFormat('MMM').format(value).toString();
                            provider.dobYear =
                                DateFormat('yyyy').format(value).toString();
                          }
                        });
                      },
                      child: Container(
                        height: 50.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CText(
                              text: session.getString(session.Date),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            CText(
                              text: provider.dobDay ?? 'day',
                              color: provider.dobDay != null
                                  ? Colors.black
                                  : Colors.grey,
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              height: 20.h,
                              width: 1.09.w,
                              color: Colors.grey,
                            ),
                            CText(
                              text: provider.dobMonth ?? 'month',
                              color: provider.dobMonth != null
                                  ? Colors.black
                                  : Colors.grey,
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              height: 20.h,
                              width: 1.09.w,
                              color: Colors.grey,
                            ),
                            CText(
                              text: provider.dobYear ?? 'year',
                              color: provider.dobYear != null
                                  ? Colors.black
                                  : Colors.grey,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.amber, width: 0.5.r),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.5.r)),
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Row(
                      children: [
                        CText(
                          text: session.getString(session.ContainerSl)+' : ',
                          container_wight: 110.w,
                        ),
                        Flexible(
                            child: CTextField(
                                hint_text: session.getString(session.ContainerSl),
                                controller: provider.containerSlController,
                                textInputType: TextInputType.text))
                      ],
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Row(
                      children: [
                        CText(
                          text: session.getString(session.SealNo)+' : ',
                          container_wight: 110.w,
                        ),
                        Flexible(
                            child: CTextField(
                                hint_text: session.getString(session.SealNo),
                                controller: provider.sealNoController,
                                textInputType: TextInputType.text))
                      ],
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Row(
                      children: [
                        CText(
                          text: session.getString(session.WareHouse)+' : ',
                          container_wight: 110.w,
                        ),
                        Flexible(
                            child: CTextField(
                                hint_text: session.getString(session.WareHouse),
                                controller: provider.wareHouseController,
                                textInputType: TextInputType.text))
                      ],
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Row(
                      children: [
                        CText(
                          text: session.getString(session.MaterialNo)+' : ',
                          container_wight: 110.w,
                        ),
                        Flexible(
                            child: CTextField(
                                hint_text: session.getString(session.MaterialNo),
                                controller: provider.materialNoController,
                                textInputType: TextInputType.number))
                      ],
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Row(
                      children: [
                        CText(
                          text: session.getString(session.Qyt)+' : ',
                          container_wight: 110.w,
                        ),
                        Flexible(
                            child: CTextField(
                                hint_text: session.getString(session.Qyt),
                                controller: provider.qytController,
                                textInputType: TextInputType.number))
                      ],
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (!provider.isSwitchedHoneyWell) {
                          scanBarcodeNormal(provider);
                          // Navigator.of(context).pushNamed(RoutePaths.QRSCAN);
                        }
                      },
                      child: Container(
                        height: 50.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(12.5.r)),
                        child: CText(
                          text: 'SCAN BARCODE',
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Container(
                      height: 45.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: CText(
                        text: provider.barcode ?? 'Barcode empty',
                        color: provider.barcode != null
                            ? Colors.black
                            : Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5.r),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.5.r)),
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        imageUtils.pickCameraImage().then((value) => {
                              if (value != null) {provider.listImageAdd = value}
                            });
                      },
                      child: Container(
                        height: 50.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(12.5.r)),
                        child: CText(
                          text: 'CAMERA',
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    SizedBox(
                      height: 110.h,
                      child: ListView.builder(
                        itemCount: provider.listImage.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 8.w),

                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12.5)),
                                      child: Image.file(
                                        File(provider.listImage[index]!.path),
                                        height: 100.r,
                                        width: 100.r,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: -2.h,
                                      right: -2.w,
                                      child: InkWell(
                                        onTap:(){
                                          provider.listImageRemove = index;
                                        },
                                        child: Icon(
                                          Icons.remove_circle,
                                          color: Colors.redAccent,
                                          size: 25.r,
                                        ),
                                      ))
                                ],
                              ),

                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    InkWell(
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (provider.data_validate() == '') {
                          provider.indbound_data(context);
                        } else {
                          alertDialog(provider.data_validate());
                        }
                      },
                      child: Container(
                        height: 50.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorRes.green_08BA64,
                            borderRadius: BorderRadius.circular(12.5.r)),
                        child: CText(
                          text: 'SAVE',
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: Center(
                        child: Image.asset(
                          ImageRes.stock,
                          height: 100.h,
                          width: 100.w,
                          fit: BoxFit.contain,
                        ),
                      )),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: CText(
                      text: 'My Profile',
                      size: 14.5.sp,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.devices,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CText(
                          text: 'Honey Well',
                          size: 14.5.sp,
                        ),
                        CupertinoSwitch(
                            activeColor: ColorRes.green_08BA64,
                            trackColor: ColorRes.white_66EFEFEF,
                            value: provider.isSwitchedHoneyWell,
                            onChanged: (v) {
                              provider.isSwitchedHoneyWell = v;
                            }),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.import_export_outlined),
                    title: CText(
                      text: 'Export',
                      size: 14.5.sp,
                    ),
                    onTap: () async {
                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.storage,
                      ].request();
                      if (statuses[Permission.storage].toString() ==
                          "PermissionStatus.granted") {
                        if (Hive.box("inbound_database").length > 0) {
                          provider.fileNameController.text =
                              DateTime.now().day.toString() +
                                  "_" +
                                  DateTime.now().month.toString() +
                                  "_" +
                                  DateTime.now().year.toString() +
                                  "_" +
                                  DateTime.now().millisecond.toString();
                          alertFileDialog(provider);
                        } else {
                          alertDialog("No Data Available");
                        }
                      } else {
                        alertDialog(
                            "We need to request your permission to read ");
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: CText(
                      text: 'Edit Field',
                      size: 14.5.sp,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(RoutePaths.FIELD);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: const Text(' Edit Profile '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: const Text('LogOut'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }

  alertDialog(String value) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: CText(
              text: 'Error Result',
              fontWeight: FontWeight.w700,
              color: Colors.black,
              size: 20.sp,
              fontFamily: FontRes.bold,
            ),
            content: CText(
              text: value,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              size: 18.sp,
              maxLines: 2,
              fontFamily: FontRes.regular,
            ),
          );
        });
  }

  alertFileDialog(DashViewModel provider) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: CText(
              text: 'File Name',
              fontWeight: FontWeight.w700,
              color: Colors.black,
              size: 20.sp,
              fontFamily: FontRes.bold,
            ),
            content: CTextField(
                hint_text: 'File Name',
                controller: provider.fileNameController,
                textInputType: TextInputType.text),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                onPressed: () {
                  Navigator.of(context).pop();
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
                style: ElevatedButton.styleFrom(primary: ColorRes.green_08BA64),
                onPressed: () {
                  if (!File('storage/emulated/0/Download/' +
                          provider.fileNameController.text +
                          '.xlsx')
                      .existsSync()) {
                    excelUtils.createExcel(provider.fileNameController.text);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
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

  Future<void> scanBarcodeNormal(DashViewModel provider) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      provider.barcode = barcodeScanRes;
      print(barcodeScanRes);

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }
}
