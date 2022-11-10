import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/core/session/session.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:inbound_flutter/ui/page/navigation/navigation_viewmodel.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:inbound_flutter/ui/widget/c_textfield.dart';
import 'package:inbound_flutter/utils/alert_dialog_utils.dart';
import 'package:inbound_flutter/utils/date_time_utils.dart';
import 'package:inbound_flutter/utils/excel_utils.dart';
import 'package:inbound_flutter/utils/image_utils.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';
import 'package:inbound_flutter/utils/res/qrscan_utils.dart';
import 'package:provider/provider.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdateState();
}

class _UpdateState extends State<UpdatePage> {
  final Session session = di<Session>();
  var imageUtils = di<ImageUtils>();
  var dateTimeUtils = di<DateTimeUtils>();
  var excelUtils = di<ExcelUtils>();
  var dialogUtils = di<AlertDialogUtils>();
  var qrcanUtils = di<QrScanUtils>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationViewModel>(context);
    return Container(
      color: ColorRes.purple_6f2265,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: ColorRes.white_F7F7F7,
          drawerEnableOpenDragGesture: false,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: ColorRes.purple_6f2265,
            title: CText(
              text: 'Update',
              fontWeight: FontWeight.w600,
              color: Colors.white,
              size: 18.sp,
              fontFamily: FontRes.bold,
            ),
            leading: Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25.r,
                    ))),
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
                          provider.dobUpdate = value;
                        }
                      });
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: ColorRes.purple_6f2265, width: 0.5.r),
                          borderRadius:
                          BorderRadius.all(Radius.circular(12.5.r)),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CText(
                            text: provider.session.getString(provider.session.Date),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          CText(
                            text: provider.dobUpdateDay ?? 'day',
                            color: provider.dobUpdateDay != null
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
                            text: provider.dobUpdateMonth ?? 'month',
                            color: provider.dobUpdateMonth != null
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
                            text: provider.dobUpdateYear ?? 'year',
                            color: provider.dobUpdateYear != null
                                ? Colors.black
                                : Colors.grey,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    children: [
                      CText(
                        text: '${provider.session.getString(provider.session.ContainerSl)} : ',
                        container_wight: 110.w,
                      ),
                      Flexible(
                          child: CTextField(
                              hint_text:
                              provider.session.getString(provider.session.ContainerSl),
                              controller: provider.containerUpdateSlController,
                              textInputType: TextInputType.text))
                    ],
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    children: [
                      CText(
                        text: '${provider.session.getString(provider.session.SealNo)} : ',
                        container_wight: 110.w,
                      ),
                      Flexible(
                          child: CTextField(
                              hint_text: provider.session.getString(provider.session.SealNo),
                              controller: provider.sealNoUpdateController,
                              textInputType: TextInputType.text))
                    ],
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    children: [
                      CText(
                        text: '${provider.session.getString(provider.session.WareHouse)} : ',
                        container_wight: 110.w,
                      ),
                      Flexible(
                          child: CTextField(
                              hint_text: provider.session.getString(provider.session.WareHouse),
                              controller: provider.wareHouseUpdateController,
                              textInputType: TextInputType.text))
                    ],
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    children: [
                      CText(
                        text: '${provider.session.getString(provider.session.MaterialNo)} : ',
                        container_wight: 110.w,
                      ),
                      Flexible(
                          child: CTextField(
                              hint_text:
                              provider.session.getString(provider.session.MaterialNo),
                              controller: provider.materialUpdateNoController,
                              textInputType: TextInputType.number))
                    ],
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    children: [
                      CText(
                        text: '${provider.session.getString(provider.session.Qyt)} : ',
                        container_wight: 110.w,
                      ),
                      Flexible(
                          child: CTextField(
                              hint_text: provider.session.getString(provider.session.Qyt),
                              controller: provider.qytUpdateController,
                              textInputType: TextInputType.number))
                    ],
                  ),

                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    children: [
                      CText(
                        text: '${provider.session.getString(provider.session.ReelNo)} : ',
                        container_wight: 110.w,
                      ),
                      Flexible(
                          child: CTextField(
                            enable: false,
                              hint_text:
                              provider.session.getString(provider.session.ReelNo),
                              controller: provider.reelUpdateNoController,
                              textInputType: TextInputType.text))
                    ],
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      imageUtils.pickCameraImage().then((value) => {
                        if (value != null) {provider.base64UpdateImageListAdd = value}
                      });
                    },
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorRes.purple_6f2265,
                          borderRadius: BorderRadius.circular(12.5.r)),
                      child: const CText(
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
                      itemCount: provider.base64UpdateImageList.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 8.w),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.h, horizontal: 5.w),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.5)),

                                  child: Image.memory(Base64Decoder().convert(provider.base64UpdateImageList[index] ??''), height: 100.h, width: 100.w, fit: BoxFit.cover,),
                                ),
                              ),
                              Positioned(
                                  top: -2.h,
                                  right: -2.w,
                                  child: InkWell(
                                    onTap: () {
                                      provider.base64UpdatelistImageRemove = index;
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
                      if (provider.data_update_validate() == '' &&provider.update_index!=-1) {
                        provider.indbound_data_update(context);
                      } else {
                        dialogUtils.errorDialog(context,provider.data_validate());
                      }
                    },
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorRes.green_08BA64,
                          borderRadius: BorderRadius.circular(12.5.r)),
                      child: const CText(
                        text: 'Update',
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
        ),
      ),
    );


  }


}
