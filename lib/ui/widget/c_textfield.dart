import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/res/color_res.dart';
import '../../utils/res/font_res.dart';

class CTextField extends StatelessWidget {
  final String? hint_text;
  final TextEditingController?  controller;
  final TextInputType? textInputType;
  final bool? enable;


  const CTextField(
      {Key? key,
        required this.hint_text,
        required this.controller,
        required this.textInputType, this.enable,
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enable ?? true,
      autofocus: false,
      controller: controller,
      keyboardType: textInputType,
      style: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          fontFamily: FontRes.regular),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.5.r),
          borderSide: BorderSide(
            width: .5,
            color: ColorRes.grey_9C9C9C,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.5.r),
          borderSide: BorderSide(
            width: .5,
            color: ColorRes.purple_6f2265,
            style: BorderStyle.solid,
          ),
        ),
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w, vertical: 15.h),
        hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            fontFamily: FontRes.regular),
        hintText: hint_text,
      ),
    );
  }
}
