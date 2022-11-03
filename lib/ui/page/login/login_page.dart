import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/core/route/route_paths.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:provider/provider.dart';

import '../../../utils/res/color_res.dart';
import '../../../utils/res/font_res.dart';
import '../../../utils/res/image_res.dart';
import 'login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginViewModel>(context);
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
                    controller: provider.emailController,
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
                          color: Colors.amber,
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
                    obscureText: provider.obscureText,
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
                          color: Colors.amber,
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
                      suffixIcon: InkWell(
                        onTap: () {
                          provider.obscureText = !provider.obscureText;
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: provider.obscureText
                                ? Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.grey,
                              size: 25.r,
                            )
                                : Icon(
                              Icons.visibility_outlined,
                              color: Colors.grey,
                              size: 25.r,
                            )),
                      ),
                      suffixIconConstraints: BoxConstraints(),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();

                      provider.login(provider.emailController.text, provider.passwordController.text, context);

                    },
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorRes.green_08BA64,
                          borderRadius: BorderRadius.circular(12.5.r)),
                      child: const CText(
                        text: 'Login',
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

                     Navigator.of(context).pushNamed(RoutePaths.REGISTRATION);

                    },
                    child: CText(
                      text: 'Create Account ?',
                      color: ColorRes.green_08BA64,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontRes.medium,
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
