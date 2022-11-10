import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';

class AlertDialogUtils{


  errorDialog(BuildContext context,String value) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: CText(
              text: 'Error !',
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
}