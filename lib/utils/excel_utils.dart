import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelUtils{
  Future<void> createExcel() async {
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
    worksheet.getRangeByIndex(1,10).columnWidth = 50;
    worksheet.getRangeByIndex(1,11).columnWidth = 50;
    worksheet.getRangeByIndex(1,12).columnWidth = 50;
    worksheet.getRangeByIndex(1,13).columnWidth = 50;
    worksheet.getRangeByIndex(1,14).columnWidth = 50;

  // Excel header
    worksheet.getRangeByIndex(1,1).setText('Date');
    worksheet.getRangeByIndex(1,2).setText('sl');
    worksheet.getRangeByIndex(1,3).setText('Container Sl');
    worksheet.getRangeByIndex(1,4).setText('Seal No.');
    worksheet.getRangeByIndex(1,5).setText('Warehouse');
    worksheet.getRangeByIndex(1,6).setText('Material No');
    worksheet.getRangeByIndex(1,7).setText('Reel No');
    worksheet.getRangeByIndex(1,8).setText('Reel No/barcode');
    worksheet.getRangeByIndex(1,9).setText('QYT(M)');
    worksheet.getRangeByIndex(1,10).setText('Pic 1');
    worksheet.getRangeByIndex(1,11).setText('Pic 2');
    worksheet.getRangeByIndex(1,12).setText('Pic 3');
    worksheet.getRangeByIndex(1,13).setText('Pic 4');
    worksheet.getRangeByIndex(1,14).setText('Pic 5');

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

 File('storage/emulated/0/Download/'+'Output.xlsx').writeAsBytes(bytes).then((value) => print(value.path));

  }

}