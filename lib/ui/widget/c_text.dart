import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/res/font_res.dart';

class CText extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;
  final double? container_wight;
  final double? size;
  final String? fontFamily;


  const CText(
      {Key? key,
        required this.text, this.textAlign, this.color, this.fontWeight, this.container_wight, this.size, this.fontFamily,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: container_wight ,
      child: Text(
        text ?? '',
        maxLines: 1,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
          fontFamily: fontFamily ?? FontRes.medium,
          decoration:  TextDecoration.none,
          overflow: TextOverflow.ellipsis,
          color:  color ?? Colors.black,
          fontSize: size ?? 16.sp,
          fontWeight: fontWeight ?? FontWeight.w400,
        ),
      ),
    );
  }
}
