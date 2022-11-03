import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:inbound_flutter/core/route/route_paths.dart';
import 'package:inbound_flutter/core/session/session.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:inbound_flutter/ui/page/navigation/navigation_viewmodel.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:inbound_flutter/ui/widget/c_textfield.dart';
import 'package:inbound_flutter/utils/alert_dialog_utils.dart';
import 'package:inbound_flutter/utils/excel_utils.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';
import 'package:inbound_flutter/utils/res/image_res.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatelessWidget {
  var dialogUtils = di<AlertDialogUtils>();
  var excelUtils = di<ExcelUtils>();
  final Session session = di<Session>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationViewModel>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            ImageRes.settings_background,
            height: 160.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RoutePaths.FIELD);
                },
                child:   Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CText(
                        text: 'Edit Field',
                        size: 16.5.sp,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_outlined,
                      size: 30.r,
                      color: ColorRes.grey_9C9C9C,
                    )
                  ],
                ),
              ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () async {
                    Map<Permission, PermissionStatus> statuses = await [Permission.storage,].request();
                    if (statuses[Permission.storage].toString() ==
                        "PermissionStatus.granted") {
                      if (Hive.box("inbound_database").length > 0) {
                        provider.fileNameController.text =
                            "${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}_${DateTime.now().millisecond}";
                        alertFileDialog(provider, context);
                      } else {
                        dialogUtils.errorDialog(context,
                            "There is no data for export!");
                      }
                    } else {
                      dialogUtils.errorDialog(context,
                          "We need to request your permission to read ");
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CText(
                          text: 'Export',
                          size: 16.5.sp,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        size: 30.r,
                        color: ColorRes.grey_9C9C9C,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CText(
                        text: 'Honey Well',
                        size: 16.5.sp,
                      ),
                    ),
                    CupertinoSwitch(
                        activeColor: ColorRes.green_08BA64,
                        trackColor: ColorRes.white_66EFEFEF,
                        value: provider.isSwitchedHoneyWell,
                        onChanged: (v) {
                          provider.isSwitchedHoneyWell = v;
                          session.setBool(session.SCANNER,v);
                        }),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () async {
                    session.setBool(session.LOGIN, false);
                    Navigator.pushNamedAndRemoveUntil(context, RoutePaths.LOGIN, (route) => false);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CText(
                          text: 'Logout',
                          size: 16.5.sp,
                        ),
                      ),
                      Icon(
                        Icons.logout,
                        size: 30.r,
                        color: ColorRes.grey_9C9C9C,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }

  alertFileDialog(NavigationViewModel provider, context) {
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
                  if (!File('storage/emulated/0/Download/${provider.fileNameController.text}.xlsx')
                      .existsSync()) {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          contentPadding: const EdgeInsets.all(0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          content: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height / 1.7,
                            ),
                            width: 300.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: Colors.transparent),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CircularProgressIndicator(),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    excelUtils
                        .createExcel(provider.fileNameController.text)
                        .then((value) {
                      print(value);

//                       if (value.path == 'storage/emulated/0/Download/${provider.fileNameController.text}.xlsx') {
//
// // Hive.box("inbound_database").clear();
//                       }
                      Navigator.of(context).pop();
                    }).catchError((onError, stackTrace) {
                      print(onError);
                      Navigator.of(context).pop();
                    });
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
}
