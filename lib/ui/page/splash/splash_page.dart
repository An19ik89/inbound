import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/core/route/route_paths.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';
import 'package:provider/provider.dart';
import '../../../core/session/session.dart';

import '../../../utils/res/image_res.dart';
import 'splash_viewmodel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {

  final Session session = di<Session>();
  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<SplashViewModel>(context);


    return  Scaffold(
        backgroundColor: ColorRes.white_F7F7F7,
        body: Stack(
          fit: StackFit.expand,
          children: [
           Center(
             child:  Image.asset(
               ImageRes.splash,
               height: 200.h,
               width: 200.w,
               fit: BoxFit.contain,
             ),
           ),

            
            Positioned(
              bottom: 50.h,
                right: 0,
                left: 0,
                child: Center(
                  child: DefaultTextStyle(
                    style:  TextStyle(
                      fontSize: 16.sp,
                      color: ColorRes.green_08BA64,
                      fontFamily: FontRes.medium,
                      fontWeight: FontWeight.w500,
                    ),
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      repeatForever: provider.repeatForever,
                      stopPauseOnTap: provider.stopPauseOnTap,
                      isRepeatingAnimation: true,
                      onFinished: provider.onFinished ? (){ session.getBool(session.LOGIN)  ? Navigator.of(context).pushReplacementNamed(RoutePaths.NAVIGATOR):Navigator.of(context).pushReplacementNamed(RoutePaths.LOGIN);}:null,

                      animatedTexts: [
                        WavyAnimatedText('Presented by CodeXive'),
                      ],

                    ),
                  ),
                ))

          ],
        ),
      );
  }
}
