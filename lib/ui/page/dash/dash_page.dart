import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:inbound_flutter/ui/widget/c_textfield.dart';
import 'package:inbound_flutter/utils/image_utils.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';
import 'package:provider/provider.dart';

import 'dash_viewmodel.dart';

class DashPage extends StatefulWidget {
  const DashPage({Key? key}) : super(key: key);

  @override
  State<DashPage> createState() => _DashState();
}

class _DashState extends State<DashPage> {
  var imageUtils = di<ImageUtils>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DashViewModel>(context);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CText(text: 'Container Sl : '),
                  Flexible(
                      child: CTextField(
                          hint_text: 'Container Sl',
                          controller: provider.emailController,
                          textInputType: TextInputType.number))
                ],
              ),
              SizedBox(
                height: 13.h,
              ),
              Row(
                children: [
                  CText(text: 'Seal No. : '),
                  Flexible(
                      child: CTextField(
                          hint_text: 'Seal No.',
                          controller: provider.emailController,
                          textInputType: TextInputType.number))
                ],
              ),
              SizedBox(
                height: 13.h,
              ),
              Row(
                children: [
                  CText(text: 'Warehouse : '),
                  Flexible(
                      child: CTextField(
                          hint_text: 'Warehouse',
                          controller: provider.emailController,
                          textInputType: TextInputType.text))
                ],
              ),
              SizedBox(
                height: 13.h,
              ),
              Row(
                children: [
                  CText(text: 'Metarial No. : '),
                  Flexible(
                      child: CTextField(
                          hint_text: 'Metarial No.',
                          controller: provider.emailController,
                          textInputType: TextInputType.number))
                ],
              ),
              SizedBox(
                height: 13.h,
              ),
             Center(child:  InkWell(
               onTap: () {
                 imageUtils.pickCameraImage().then((value) => {
                   if (value != null) {provider.listImages = value}
                 });
               },
               child: Container(
                 height: 50.h,
                 width: ScreenUtil.defaultSize.width.w,
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                     color: Colors.amber,
                     borderRadius: BorderRadius.circular(12.5.r)),
                 child: CText(
                   text: 'Continue',
                   color: Colors.white,
                   textAlign: TextAlign.center,
                   fontWeight: FontWeight.w500,
                 ),
               ),
             ),),
              
              SizedBox(height: 13.h,),

              SizedBox(
                height: 100.h,
                child: ListView.builder(
                  itemCount: provider.listImage.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 8.w),
                      child: ClipRRect(
                        borderRadius : BorderRadius.all(Radius.circular(12.5)),
                        child: Image.file(File(provider.listImage[index]!.path),height: 100.r,width: 100.r,fit: BoxFit.cover,),
                      ),
                    );


                  },
                ),
              )
            ],
          ),
          
        ),
      ),
    ));
  }
}
