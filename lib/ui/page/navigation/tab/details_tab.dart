import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/ui/page/navigation/navigation_viewmodel.dart';
import 'package:inbound_flutter/ui/widget/c_text.dart';
import 'package:inbound_flutter/ui/widget/details_item.dart';
import 'package:inbound_flutter/utils/res/color_res.dart';
import 'package:inbound_flutter/utils/res/font_res.dart';
import 'package:provider/provider.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationViewModel>(context);
    print("Data model list in details tab : ${Provider.of<NavigationViewModel>(context).dataModelList.length}");
    print("image url list in details tab : ${Provider.of<NavigationViewModel>(context).dataModelList[0].imageUrls!.length}");
    //provider.getDatabaseData();
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
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: provider.dataModelList.length ,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                //Uint8List recieveImage = ((provider.dataModelList[index].imageUrls?.length ?? 0) > 0 ? convertion(provider.dataModelList[index].imageUrls![0]):convertion('')) as Uint8List;
                //print("Image in details : ${recieveImage.toString()}");
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
   Future convertion(String baseImageData) async{
    if(baseImageData.isNotEmpty){
      Uint8List converted =  await Base64Decoder().convert(baseImageData ??'');
      return converted;
    }
    else{
      return "";
    }
  }

}