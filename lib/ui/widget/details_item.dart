
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' as Io;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';

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


  const DetailsItem(
      {Key? key, this.image_link, this.reel_no, this.campaign_date, this.container, this.seel_no, this.warehouse, this.metarial_no, this.qyt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("image link : $image_link");
    //Uint8List Uint8list_Image = const Base64Decoder().convert(image_link ??'');
    //print("image link : ${Uint8list_Image.toString()}");
    // final decodedBytes = base64Decode(image_link!);
    // Io.File file = Io.File("decodedBezkoder.png");
    // print("image link decode : ${decodedBytes.toString()}");


    Uint8List uint8list = base64.decode(image_link.toString());


    return Container(
      height: 150.h,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.2.r),
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        color: Colors.amber.shade50,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //image_link!.isNotEmpty ?
          SizedBox(
            height: 150.h,
            width: 131.w,
            child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)),
              //child: Image.memory(Base64Decoder().convert(image_link ??''), height: 150.h, width: 131.w, fit: BoxFit.cover,),
              child: Image.memory(uint8list, height: 150.h, width: 131.w, fit: BoxFit.cover,),
            ),

          )
          //     :
          // Container(
          //   height: 150.h,
          //     width: 131.w,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), bottomLeft: Radius.circular(15.r)), color: Colors.grey),
          //   child: Center(
          //     child: Image.asset(ImageRes.stock, height: 70.r, width: 70.r, fit: BoxFit.cover,),
          //   ),
          // ),
,
          Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 9.5.h, horizontal: 11.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reel_no ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    Text(
                      container ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 2.5.h,),
                    Text(
                      seel_no ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 2.5.h,),
                    Text(
                      warehouse ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 2.5.h,),
                    Text(
                      metarial_no ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 2.5.h,),
                    Text(
                      qyt ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    SizedBox(height: 5.h,),
                    Text(
                      campaign_date ?? '',
                      style: TextStyle(
                        color: ColorRes.green_00BC69,
                        fontSize: 13.5.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal
                      ),
                    ),

                  ],
                ),
              )),

          SizedBox(width: 5.w,)
        ],
      ),
    );
  }
}