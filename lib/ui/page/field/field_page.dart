
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/core/session/session.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:inbound_flutter/ui/page/dash/dash_viewmodel.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:inbound_flutter/ui/widget/c_textfield.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';
import 'package:provider/provider.dart';


class FieldPage extends StatefulWidget {
  const FieldPage({Key? key}) : super(key: key);

  @override
  State<FieldPage> createState() => _FieldState();
}

class _FieldState extends State<FieldPage> {
  final Session session = di<Session>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DashViewModel>(context);
    return Container(
      color: Colors.amber,
      child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: ColorRes.white_F7F7F7,
            drawerEnableOpenDragGesture: false,
            appBar: AppBar(
              title: CText(
                text: 'Edit',
                fontWeight: FontWeight.w600,
                color: Colors.white,
                size: 18.sp,
                fontFamily: FontRes.bold,
              ),
              leading: Builder(
                  builder: (context) => IconButton(
                      onPressed: () {
                       Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25.r,
                      ))),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CTextField(
                        hint_text: session.getString(session.Date),
                        controller: provider.dateFieldController,
                        textInputType: TextInputType.text),
                    SizedBox(
                      height: 13.h,
                    ),
                    CTextField(
                        hint_text: session.getString(session.Sl),
                        controller: provider.slFieldController,
                        textInputType: TextInputType.text),
                    SizedBox(
                      height: 13.h,
                    ),
                     CTextField(
                                hint_text: session.getString(session.ContainerSl),
                                controller: provider.containerSlFieldController,
                                textInputType: TextInputType.text),
                    SizedBox(
                      height: 13.h,
                    ),
                     CTextField(
                                hint_text: session.getString(session.SealNo),
                                controller: provider.sealNoFieldController,
                                textInputType: TextInputType.text),
                    SizedBox(
                      height: 13.h,
                    ),
                     CTextField(
                                hint_text: session.getString(session.WareHouse),
                                controller: provider.wareHouseFieldController,
                                textInputType: TextInputType.text),
                    SizedBox(
                      height: 13.h,
                    ),

                        CTextField(
                                hint_text: session.getString(session.MaterialNo),
                                controller: provider.materialNoFieldController,
                                textInputType: TextInputType.text),


                    SizedBox(
                      height: 13.h,
                    ),

                         CTextField(
                                hint_text: session.getString(session.Qyt),
                                controller: provider.qytFieldController,
                                textInputType: TextInputType.text),

                    SizedBox(
                      height: 13.h,
                    ),

                    InkWell(
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        provider.title_data();
                        Navigator.of(context).pop();

                      },
                      child: Container(
                        height: 50.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorRes.green_08BA64,
                            borderRadius: BorderRadius.circular(12.5.r)),
                        child: CText(
                          text: 'SAVE',
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),)
              ),
            ),
          ),
    );
  }

}
