import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/res/font_res.dart';

class CText extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;


  const CText(
      {Key? key,
        required this.text, this.textAlign, this.color, this.fontWeight,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      child: Text(
        text ?? '',
        maxLines: 1,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
          fontFamily: FontRes.medium,
          decoration:  TextDecoration.none,
          overflow: TextOverflow.ellipsis,
          color:  color ?? Colors.black,
          fontSize: 16.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
        ),
      ),
    );
  }
}
