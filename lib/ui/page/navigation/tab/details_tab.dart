import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/ui/page/navigation/navigation_viewmodel.dart';
import 'package:inbound_flutter/ui/widget/details_item.dart';
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
                      image_link: (provider.dataModelList[index].imageUrls?.length ?? 0) > 0 ? provider.dataModelList[index].imageUrls![0]:'',
                      campaign_date: provider.dataModelList[index].date,

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