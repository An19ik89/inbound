import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:inbound_flutter/core/model/inbound_data_model.dart';
import 'package:inbound_flutter/core/session/session.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelUtils {
  final Session session = di<Session>();

  Future<File> createExcel(String file_name) async {
    //Create a Excel document.
    final Workbook workbook = Workbook();
    final Worksheet worksheet = workbook.worksheets[0];

    final Style style = workbook.styles.add('Style1');
    style.hAlign = HAlignType.center;
    style.vAlign = VAlignType.center;

    // Excel range initializing
    var A1 = worksheet.getRangeByIndex(1, 1);
    A1.cellStyle.vAlign = VAlignType.center;
    A1.cellStyle.hAlign = HAlignType.center;
    A1.columnWidth = 13;
    var A2 = worksheet.getRangeByIndex(1, 2);
    A2.cellStyle.vAlign = VAlignType.center;
    A2.cellStyle.hAlign = HAlignType.center;
    A2.columnWidth = 13;
    var A3 = worksheet.getRangeByIndex(1, 3);
    A3.cellStyle.vAlign = VAlignType.center;
    A3.cellStyle.hAlign = HAlignType.center;
    A3.columnWidth = 13;
    var A4 = worksheet.getRangeByIndex(1, 4);
    A4.cellStyle.vAlign = VAlignType.center;
    A4.cellStyle.hAlign = HAlignType.center;
    A4.columnWidth = 13;
    var A5 = worksheet.getRangeByIndex(1, 5);
    A5.cellStyle.vAlign = VAlignType.center;
    A5.cellStyle.hAlign = HAlignType.center;
    A5.columnWidth = 13;
    var A6 = worksheet.getRangeByIndex(1, 6);
    A6.cellStyle.vAlign = VAlignType.center;
    A6.cellStyle.hAlign = HAlignType.center;
    A6.columnWidth = 13;
    var A7 = worksheet.getRangeByIndex(1, 7);
    A7.cellStyle.vAlign = VAlignType.center;
    A7.cellStyle.hAlign = HAlignType.center;
    A7.columnWidth = 13;
    var A8 = worksheet.getRangeByIndex(1, 8);
    A8.cellStyle.vAlign = VAlignType.center;
    A8.cellStyle.hAlign = HAlignType.center;
    A8.columnWidth = 13;
    var A9 = worksheet.getRangeByIndex(1, 9);
    A9.cellStyle.vAlign = VAlignType.center;
    A9.cellStyle.hAlign = HAlignType.center;
    A9.columnWidth = 14;
    var A10 = worksheet.getRangeByIndex(1, 10);
    A10.cellStyle.vAlign = VAlignType.center;
    A10.cellStyle.hAlign = HAlignType.center;
    A10.columnWidth = 14;
    var A11 = worksheet.getRangeByIndex(1, 11);
    A11.cellStyle.vAlign = VAlignType.center;
    A11.cellStyle.hAlign = HAlignType.center;
    A11.columnWidth = 14;
    var A12 = worksheet.getRangeByIndex(1, 12);
    A12.cellStyle.vAlign = VAlignType.center;
    A12.cellStyle.hAlign = HAlignType.center;
    A12.columnWidth = 14;
    var A13 = worksheet.getRangeByIndex(1, 13);
    A13.cellStyle.vAlign = VAlignType.center;
    A13.cellStyle.hAlign = HAlignType.center;
    A13.columnWidth = 14;
    var A14 = worksheet.getRangeByIndex(1, 14);
    A14.cellStyle.vAlign = VAlignType.center;
    A14.cellStyle.hAlign = HAlignType.center;
    A14.columnWidth = 14;



    // Excel header
    A1.setText(session.getString(session.Date));
    A2.setText(session.getString(session.Sl));
    A3.setText(session.getString(session.ContainerSl));
    A4.setText(session.getString(session.SealNo));
    A5.setText(session.getString(session.WareHouse));
    A6.setText(session.getString(session.MaterialNo));
    A7.setText(session.getString(session.ReelNo));
    A8.setText(session.getString(session.Qyt));
    A9.setText('Checked by');
    A10.setText('Pic 1');
    A11.setText('Pic 2');
    A12.setText('Pic 3');
    A13.setText('Pic 4');
    A14.setText('Pic 5');
    int i = 2;
    for (String key in Hive.box("inbound_database").keys) {
      DataModel dm = Hive.box("inbound_database").get(key);
      //print (dm.quantity);
      var a = worksheet.getRangeByIndex(i, 1);
      a.cellStyle.vAlign = VAlignType.center;
      a.cellStyle.hAlign = HAlignType.center;
      a.rowHeight = 67.5;
      a.setValue(dm.date);
      var b = worksheet.getRangeByIndex(i, 2);
      b.cellStyle.vAlign = VAlignType.center;
      b.cellStyle.hAlign = HAlignType.center;
      b.setValue((i - 1).toString());
      var c = worksheet.getRangeByIndex(i, 3);
      c.cellStyle.vAlign = VAlignType.center;
      c.cellStyle.hAlign = HAlignType.center;
      c.setValue(dm.containerSl);
      var d = worksheet.getRangeByIndex(i, 4);
      d.cellStyle.vAlign = VAlignType.center;
      d.cellStyle.hAlign = HAlignType.center;
      d.setValue(dm.sealNo);
      var e = worksheet.getRangeByIndex(i, 5);
      e.cellStyle.vAlign = VAlignType.center;
      e.cellStyle.hAlign = HAlignType.center;
      e.setValue(dm.warehouse);
      var f = worksheet.getRangeByIndex(i, 6);
      f.cellStyle.vAlign = VAlignType.center;
      f.cellStyle.hAlign = HAlignType.center;
      f.setValue(dm.materialNo);
      var g = worksheet.getRangeByIndex(i, 7);
      g.cellStyle.vAlign = VAlignType.center;
      g.cellStyle.hAlign = HAlignType.center;
      g.setValue(dm.reelNo);
      var h = worksheet.getRangeByIndex(i, 8);
      h.cellStyle.vAlign = VAlignType.center;
      h.cellStyle.hAlign = HAlignType.center;
      h.setValue(dm.quantity);
      var j = worksheet.getRangeByIndex(i, 9);
      j.cellStyle.vAlign = VAlignType.center;
      j.cellStyle.hAlign = HAlignType.center;
      j.setValue(session.getLoginUser());
      for (int j = 0; j < dm.imageUrls!.length; j++) {

        var picture = worksheet.pictures.addBase64(i, j + 10, dm.imageUrls![j]);
        picture.width = 100;
        picture.height = 100;

      }
      i++;
    }

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();
    return await File('storage/emulated/0/Download/' + file_name + '.xlsx')
        .writeAsBytes(bytes);
  }
}
