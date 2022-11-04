import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:inbound_flutter/ui/page/navigation/tab/details_tab.dart';
import 'package:inbound_flutter/ui/page/navigation/tab/home_tab.dart';
import 'package:inbound_flutter/ui/page/navigation/tab/settings_tab.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';
import 'package:provider/provider.dart';

import 'navigation_viewmodel.dart';

class NavigationPage extends StatefulWidget {
  NavigationState createState() => NavigationState();
}

class NavigationState extends State<NavigationPage> {
  var currentTab = [
    di<HomeTab>(),
    di<DetailsTab>(),
    di<SettingsTab>()

  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationViewModel>(context);
    return Container(
        color: ColorRes.purple_6f2265,
        child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: ColorRes.white_F7F7F7,
      body: currentTab[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: provider.currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorRes.purple_6f2265,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: TextStyle(
          fontFamily:  FontRes.regular,
          decoration:  TextDecoration.none,
          overflow: TextOverflow.ellipsis,
          color:   ColorRes.purple_6f2265,
          fontSize:  13.5.sp,
          fontWeight:FontWeight.w400,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily:  FontRes.regular,
          decoration:  TextDecoration.none,
          overflow: TextOverflow.ellipsis,
          color:   Colors.grey,
          fontSize:  12.sp,
          fontWeight:FontWeight.w400,
        ),
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home,size: 30.r,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.description,size: 30.r,),
            label: 'Details',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.settings,size: 30.r,),
            label: 'Settings',
          ),
        ],
      ),
    )));
  }
}
