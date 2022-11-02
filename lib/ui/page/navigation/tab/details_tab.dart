import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inbound_flutter/ui/page/navigation/navigation_viewmodel.dart';
import 'package:inbound_flutter/ui/widget/details_item.dart';
import 'package:provider/provider.dart';

class DetailsTab extends StatelessWidget {

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
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) => InkWell(
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
              ),
            )
          ],
        ),
      ),
    );
  }

}