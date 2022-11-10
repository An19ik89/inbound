import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/core/session/session.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';

import '../../utils/res/image_res.dart';


class DetailsItem extends StatelessWidget {
  final String? image_link;
  final String? reel_no;
  final String? container;
  final String? seel_no;
  final String? warehouse;
  final String? metarial_no;
  final String? qyt;
  final String? campaign_date;
  final String? image_quantity;
  final Session session;

  const DetailsItem(
      {Key? key, this.image_link, this.reel_no, this.campaign_date, this.container, this.seel_no, this.warehouse, this.metarial_no, this.qyt, this.image_quantity, required this.session})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 150.h,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.2.r),
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        color: ColorRes.purple_6f2265.withOpacity(0.09),),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image_link!= ''?
          Stack(
            children: [
              SizedBox(
                height: 150.h,
                width: 131.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
                  child: Image.memory(Base64Decoder().convert(image_link ??''), height: 150.h, width: 131.w, fit: BoxFit.cover,),
                ),

              ),
              Positioned.fill(child:  Center(child:  CText(text: image_quantity ?? '',size: 25.sp,color: Colors.amber,fontWeight: FontWeight.w700,fontFamily: FontRes.bold,),),
              )
            ],
          ):Container(
            height: 150.h,
              width: 131.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)), color: Colors.grey),
            child: Center(
              child: Image.asset(ImageRes.barcode, height: 50.r, width: 50.r, fit: BoxFit.cover,),
            ),
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 9.5.h, horizontal: 11.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Flexible(child: CText(text: reel_no ?? '',size: 16.sp,color: ColorRes.purple_6f2265,fontWeight: FontWeight.w700,fontFamily: FontRes.bold,maxLines: 1),),
                    SizedBox(height: 6.5.h,),
                    Row(children: [CText( container_wight: 75.w,text: '${session.getString(session.ContainerSl)} : ',color:  Colors.black54,size: 12.sp,fontWeight:FontWeight.w400,fontFamily: FontRes.medium,maxLines: 1,), Flexible(child: CText(text:  container ?? '',size: 12.sp,color: Colors.black54,fontWeight: FontWeight.w400,maxLines: 1),),],),
                    SizedBox(height: 2.5.h,),
                    Row(children: [CText( container_wight: 75.w,text: '${session.getString(session.SealNo)} : ',color:  Colors.black54,size: 12.sp,fontWeight:FontWeight.w400,fontFamily: FontRes.medium,maxLines: 1,),  Flexible(child: CText(text:  seel_no ?? '',size: 12.sp,color: Colors.black54,fontWeight: FontWeight.w400,maxLines: 1),),],),
                    SizedBox(height: 2.5.h,),
                    Row(children: [CText( container_wight: 75.w,text: '${session.getString(session.WareHouse)} : ',color:  Colors.black54,size: 12.sp,fontWeight:FontWeight.w400,fontFamily: FontRes.medium,maxLines: 1,),   Flexible(child: CText(text:  warehouse ?? '',size: 12.sp,color: Colors.black54,fontWeight: FontWeight.w400,maxLines: 1),),],),
                    SizedBox(height: 2.5.h,),
                    Row(children: [CText( container_wight: 75.w,text: '${session.getString(session.MaterialNo)} : ',color:  Colors.black54,size: 12.sp,fontWeight:FontWeight.w400,fontFamily: FontRes.medium,maxLines: 1,),    Flexible(child: CText(text:  metarial_no ?? '',size: 12.sp,color: Colors.black54,fontWeight: FontWeight.w400,maxLines: 1),),],),

                    SizedBox(height: 2.5.h,),
                    Row(children: [CText( container_wight: 75.w,text: '${session.getString(session.Qyt)} : ',color:  Colors.black54,size: 12.sp,fontWeight:FontWeight.w400,fontFamily: FontRes.medium,maxLines: 1,),     Flexible(child: CText(text:  qyt ?? '',size: 12.sp,color: Colors.black54,fontWeight: FontWeight.w400,maxLines: 1),),],),

                    SizedBox(height: 6.5.h,),
                    Flexible(child:  CText(text:  campaign_date ?? '',size: 13.5.sp,color: ColorRes.green_00BC69,fontWeight: FontWeight.w500,fontFamily: FontRes.medium,maxLines: 1,),),

                  ],
                ),
              )),

          SizedBox(width: 5.w,)
        ],
      ),
    );
  }
}