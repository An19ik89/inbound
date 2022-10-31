import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:inbound_flutter/core/model/inbound_data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelUtils{
  Future<void> createExcel(String file_name) async {
    //Create a Excel document.
    final Workbook workbook = Workbook();
    final Worksheet worksheet = workbook.worksheets[0];
  // Excel range initializing
    worksheet.getRangeByIndex(1,1).columnWidth = 10;
    worksheet.getRangeByIndex(1,2).columnWidth = 10;
    worksheet.getRangeByIndex(1,3).columnWidth = 10;
    worksheet.getRangeByIndex(1,4).columnWidth = 10;
    worksheet.getRangeByIndex(1,5).columnWidth = 10;
    worksheet.getRangeByIndex(1,6).columnWidth = 10;
    worksheet.getRangeByIndex(1,7).columnWidth = 10;
    worksheet.getRangeByIndex(1,8).columnWidth = 10;
    worksheet.getRangeByIndex(1,9).columnWidth = 10;
    worksheet.getRangeByIndex(1,10).columnWidth = 17;
    worksheet.getRangeByIndex(1,11).columnWidth = 17;
    worksheet.getRangeByIndex(1,12).columnWidth = 17;
    worksheet.getRangeByIndex(1,13).columnWidth = 17;
    worksheet.getRangeByIndex(1,14).columnWidth = 17;

  // Excel header
    worksheet.getRangeByIndex(1,1).setText('Date');
    worksheet.getRangeByIndex(1,2).setText('sl');
    worksheet.getRangeByIndex(1,3).setText('Container Sl');
    worksheet.getRangeByIndex(1,4).setText('Seal No.');
    worksheet.getRangeByIndex(1,5).setText('Warehouse');
    worksheet.getRangeByIndex(1,6).setText('Material No');
    worksheet.getRangeByIndex(1,7).setText('Reel No/barcode');
    worksheet.getRangeByIndex(1,8).setText('QYT(M)');
    worksheet.getRangeByIndex(1,9).setText('Pic 1');
    worksheet.getRangeByIndex(1,10).setText('Pic 2');
    worksheet.getRangeByIndex(1,11).setText('Pic 3');
    worksheet.getRangeByIndex(1,12).setText('Pic 4');
    worksheet.getRangeByIndex(1,13).setText('Pic 5');
    int i=2;
    for(String key in Hive.box("inbound_database").keys)
    {
      DataModel dm =Hive.box("inbound_database").get(key);
      //print (dm.quantity);
        worksheet.getRangeByIndex(i,1).setValue(dm.date);
        worksheet.getRangeByIndex(i,2).setValue((i-1).toString());
        worksheet.getRangeByIndex(i,3).setValue(dm.containerSl);
        worksheet.getRangeByIndex(i,4).setValue(dm.sealNo);
        worksheet.getRangeByIndex(i,5).setValue(dm.warehouse);
        worksheet.getRangeByIndex(i,6).setValue(dm.materialNo);
        worksheet.getRangeByIndex(i,7).setValue(dm.reelNo);
        worksheet.getRangeByIndex(i,8).setValue(dm.quantity);
        for(int j = 0;j<dm.imageUrls!.length;j++){
          worksheet.getRangeByIndex(i,j+9).rowHeight = 110;
          worksheet.pictures.addBase64(i, j+9, dm.imageUrls![j]);
        }
        i++;
    }

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();
  File('storage/emulated/0/Download/'+file_name+'.xlsx').writeAsBytes(bytes).then((value) {
    print(value);
    // Hive.box("inbound_database").clear();
  });

  }

}