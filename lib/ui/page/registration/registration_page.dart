import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/ui/page/registration/registration_viewmodel.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:provider/provider.dart';

import '../../../utils/res/color_res.dart';
import '../../../utils/res/font_res.dart';
import '../../../utils/res/image_res.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RegistrationViewModel>(context);
    return Scaffold(
      backgroundColor: ColorRes.white_F7F7F7,
      body: Stack(fit: StackFit.expand, children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    ImageRes.splash,
                    height: 120.h,
                    width: 120.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextField(
                    autofocus: false,
                    controller: provider.nameController,
                    keyboardType: TextInputType.text,
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
                      focusedBorder: OutlineInputBorder(
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
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontRes.regular),
                      hintText: 'Name',
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextField(
                    autofocus: false,
                    controller: provider.passwordController,
                    keyboardType: TextInputType.text,
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
                      focusedBorder: OutlineInputBorder(
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
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontRes.regular),
                      hintText: 'Password',
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    autofocus: false,
                    controller: provider.oldNameController,
                    keyboardType: TextInputType.text,
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
                      focusedBorder: OutlineInputBorder(
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
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontRes.regular),
                      hintText: 'Old Name',
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextField(
                    autofocus: false,
                    controller: provider.oldpasswordController,
                    keyboardType: TextInputType.text,
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
                      focusedBorder: OutlineInputBorder(
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
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontRes.regular),
                      hintText: 'Old Password',

                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();

                       provider.registration(provider.nameController.text, provider.passwordController.text,provider.oldNameController.text,provider.oldpasswordController.text, context);

                    },
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorRes.green_08BA64,
                          borderRadius: BorderRadius.circular(12.5.r)),
                      child: const CText(
                        text: 'Create New User',
                        color: Colors.white,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontRes.medium,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();

                     provider.default_user(context);

                    },
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorRes.green_08BA64,
                          borderRadius: BorderRadius.circular(12.5.r)),
                      child: const CText(
                        text: 'Defaut',
                        color: Colors.white,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontRes.medium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
