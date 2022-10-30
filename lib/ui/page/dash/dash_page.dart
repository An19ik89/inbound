import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:inbound_flutter/core/model/inbound_data_model.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:inbound_flutter/ui/widget/c_textfield.dart';
import 'package:inbound_flutter/utils/date_time_utils.dart';
import 'package:inbound_flutter/utils/image_utils.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';
import 'package:inbound_flutter/utils/res/image_res.dart';
import 'package:intl/intl.dart';
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

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DashViewModel>(context);
    return Container(
      color: Colors.amber,
      child:  SafeArea(
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
              leading: Builder(builder: (context) =>   IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 22.r,
                  ))),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 22.r,
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
                        dateTimeUtils.selectDateFromPicker(context).then((value) {
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
                              text: 'Date',
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
                            border: Border.all(color: Colors.amber, width: 0.5.r),
                            borderRadius: BorderRadius.all(Radius.circular(12.5.r)),
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Row(
                      children: [
                        CText(
                          text: 'Container Sl : ',
                          container_wight: 110.w,
                        ),
                        Flexible(
                            child: CTextField(
                                hint_text: 'Container Sl',
                                controller: provider.containerSlController,
                                textInputType: TextInputType.number))
                      ],
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Row(
                      children: [
                        CText(
                          text: 'Seal No. : ',
                          container_wight: 110.w,
                        ),
                        Flexible(
                            child: CTextField(
                                hint_text: 'Seal No.',
                                controller: provider.sealNoController,
                                textInputType: TextInputType.number))
                      ],
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Row(
                      children: [
                        CText(
                          text: 'Warehouse : ',
                          container_wight: 110.w,
                        ),
                        Flexible(
                            child: CTextField(
                                hint_text: 'Warehouse',
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
                          text: 'Metarial No. : ',
                          container_wight: 110.w,
                        ),
                        Flexible(
                            child: CTextField(
                                hint_text: 'Metarial No.',
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
                          text: 'Qyt. : ',
                          container_wight: 110.w,
                        ),
                        Flexible(
                            child: CTextField(
                                hint_text: 'Quantity.',
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
                        color: provider.barcode != null ? Colors.black : Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5.r),
                          borderRadius: BorderRadius.all(Radius.circular(12.5.r)),
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
                      height: 100.h,
                      child: ListView.builder(
                        itemCount: provider.listImage.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 8.w),
                            child: InkWell(
                              onLongPress: (){
                                provider.listImageRemove = index;
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                                child: Image.file(
                                  File(provider.listImage[index]!.path),
                                  height: 100.r,
                                  width: 100.r,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(
                      height: 13.h,
                    ),

                    InkWell(
                      onTap: () async
                      {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if(provider.data_validate()){
                          provider.indbound_data(context);
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
            drawer: Drawer(child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.amber,

                      ),
                      child: Center(
                        child: Image.asset(ImageRes.stock,height: 100.h,width: 100.w,fit: BoxFit.contain,),
                      )
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: CText(text:' My Profile ',size: 14.5.sp,),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: const Text(' My Course '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.workspace_premium),
                    title: const Text(' Go Premium '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.video_label),
                    title: const Text(' Saved Videos '),
                    onTap: () {
                      Navigator.pop(context);
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
              ),),
          )),
    );
  }
}

var testData =
[
  {
    "serial_no": "F4ottWBnCpM",
    "date": "date",
    "container_sl": "F",
    "warehouse": "w",
    "material_no": "m",
    "reel_no": "r",
    "quantity": "q",
    "imageUrls": [
      "https://images.unsplash.com/photo-1648737966636-2fc3a5fffc8a?ixid=MnwzMzQyMjN8MXwxfGFsbHwxfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1",
      "https://images.unsplash.com/photo-1648737966636-2fc3a5fffc8a?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzQyMjN8MXwxfGFsbHwxfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1&q=80"
    ],
  },
  {
    "serial_no": "F4ottWBnCpK",
    "date": "date",
    "container_sl": "F",
    "warehouse": "w",
    "material_no": "m",
    "reel_no": "r",
    "quantity": "q",
    "imageUrls": [
      "https://images.unsplash.com/photo-1648737966636-2fc3a5fffc8a?ixid=MnwzMzQyMjN8MXwxfGFsbHwxfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1",
      "https://images.unsplash.com/photo-1648737966636-2fc3a5fffc8a?crop=entropy&cs=tinysrgb&fm=jpg&ixid=MnwzMzQyMjN8MXwxfGFsbHwxfHx8fHx8Mnx8MTY1NDE4NDQ4MQ&ixlib=rb-1.2.1&q=80",
    ],
  },
];


