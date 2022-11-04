

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/ui/page/navigation/navigation_viewmodel.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:inbound_flutter/ui/widget/c_textfield.dart';
import 'package:inbound_flutter/ui/widget/details_item.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';
import 'package:provider/provider.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationViewModel>(context);
    return   SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

             Row(
               children: [
                 CText(text:  'Total Scanned : ',size: 25.sp,color: Colors.black,fontWeight: FontWeight.w700,fontFamily: FontRes.bold,),
                 SizedBox(width: 13.w,),
                 CText(text:  provider.dataModelList.length .toString(),size: 25.sp,color: ColorRes.green_08BA64,fontWeight: FontWeight.w500,fontFamily: FontRes.bold,),
               ],
             ),
            SizedBox(height:  20.h,),
            provider.dataModelList.length > 0 ?    InkWell(
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                alertClearDbDialog(provider,context);


              },
              child: Container(
                height: 50.h,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorRes.green_08BA64,
                    borderRadius: BorderRadius.circular(12.5.r)),
                child: const CText(
                  text: 'Clear Data',
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontRes.medium,
                ),
              ),
            ) : SizedBox.shrink(),
            SizedBox(height:  20.h,),
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: provider.dataModelList.length ,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: DetailsItem(
                      reel_no: provider.dataModelList[index].reelNo ,
                      container: provider.dataModelList[index].containerSl,
                      seel_no: provider.dataModelList[index].sealNo,
                      warehouse: provider.dataModelList[index].warehouse,
                      metarial_no: provider.dataModelList[index].materialNo,
                      qyt: provider.dataModelList[index].quantity,
                      image_link: Provider.of<NavigationViewModel>(context).dataModelList[index].imageUrls![0].toString(),
                      //image_link: (provider.dataModelList[index].imageUrls?.length ?? 0) > 0 ? provider.dataModelList[index].imageUrls![0]:'',
                      campaign_date: provider.dataModelList[index].date,
                      image_quantity: (provider.dataModelList[index].imageUrls?.length ?? 0) > 0 ? provider.dataModelList[index].imageUrls!.length > 1 ? (provider.dataModelList[index].imageUrls!.length).toString()+" +" :'':'',

                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }


  alertClearDbDialog(NavigationViewModel provider, context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: CText(
              text: 'Key',
              fontWeight: FontWeight.w700,
              color: Colors.black,
              size: 20.sp,
              fontFamily: FontRes.bold,
            ),
            content: CTextField(
                hint_text: 'Password',
                controller: provider.dbClearController,
                textInputType: TextInputType.text),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: CText(
                  text: 'Cancel',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  size: 16.sp,
                  fontFamily: FontRes.medium,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: ColorRes.green_08BA64),
                onPressed: () {
                  if(provider.dbClearController.text == provider.session.default_db){
                    provider.clearDatabase();
                    Navigator.of(context).pop();
                  }
                },
                child: CText(
                  text: 'Accept',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  size: 16.sp,
                  fontFamily: FontRes.medium,
                ),
              ),
            ],
          );
        });
  }

}