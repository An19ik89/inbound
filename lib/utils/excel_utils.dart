import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:inbound_flutter/core/model/inbound_data_model.dart';
import 'package:inbound_flutter/core/session/session.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
    var A = worksheet.getRangeByIndex(1, 1);
    A.cellStyle.vAlign = VAlignType.center;
    A.cellStyle.hAlign = HAlignType.center;
    A.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    A.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    A.columnWidth = 15;

    var B = worksheet.getRangeByIndex(1, 2);
    B.cellStyle.vAlign = VAlignType.center;
    B.cellStyle.hAlign = HAlignType.center;
    B.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    B.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    B.columnWidth = 12;
    var C = worksheet.getRangeByIndex(1, 3);
    C.cellStyle.vAlign = VAlignType.center;
    C.cellStyle.hAlign = HAlignType.center;
    C.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    C.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    C.columnWidth = 15;
    var D = worksheet.getRangeByIndex(1, 4);
    D.cellStyle.vAlign = VAlignType.center;
    D.cellStyle.hAlign = HAlignType.center;
    D.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    D.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    D.columnWidth = 15;
    var E = worksheet.getRangeByIndex(1, 5);
    E.cellStyle.vAlign = VAlignType.center;
    E.cellStyle.hAlign = HAlignType.center;
    E.cellStyle.backColorRgb = Color.fromRGBO(111, 34, 101, 1);
    E.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    E.columnWidth = 15;
    var F = worksheet.getRangeByIndex(1, 6);
    F.cellStyle.vAlign = VAlignType.center;
    F.cellStyle.hAlign = HAlignType.center;
    F.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    F.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    F.columnWidth = 15;
    var G = worksheet.getRangeByIndex(1, 7);
    G.cellStyle.vAlign = VAlignType.center;
    G.cellStyle.hAlign = HAlignType.center;
    G.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    G.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    G.columnWidth = 15;
    var H = worksheet.getRangeByIndex(1, 8);
    H.cellStyle.vAlign = VAlignType.center;
    H.cellStyle.hAlign = HAlignType.center;
    H.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    H.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    H.columnWidth = 15;
    var I = worksheet.getRangeByIndex(1, 9);
    I.cellStyle.vAlign = VAlignType.center;
    I.cellStyle.hAlign = HAlignType.center;
    I.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    I.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    var J = worksheet.getRangeByIndex(1, 10);
    J.cellStyle.vAlign = VAlignType.center;
    J.cellStyle.hAlign = HAlignType.center;
    J.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    J.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    J.columnWidth = 20;
    var K = worksheet.getRangeByIndex(1, 11);
    K.cellStyle.vAlign = VAlignType.center;
    K.cellStyle.hAlign = HAlignType.center;
    K.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    K.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    K.columnWidth = 24;
    var L = worksheet.getRangeByIndex(1, 12);
    L.cellStyle.vAlign = VAlignType.center;
    L.cellStyle.hAlign = HAlignType.center;
    L.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    L.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    L.columnWidth = 24;
    var M = worksheet.getRangeByIndex(1, 13);
    M.cellStyle.vAlign = VAlignType.center;
    M.cellStyle.hAlign = HAlignType.center;
    M.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    M.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    M.columnWidth = 24;
    var N = worksheet.getRangeByIndex(1, 14);
    N.cellStyle.vAlign = VAlignType.center;
    N.cellStyle.hAlign = HAlignType.center;
    N.cellStyle.backColorRgb =Color.fromRGBO(0, 150, 255, 1);
    N.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    N.columnWidth = 24;
    var O = worksheet.getRangeByIndex(1, 15);
    O.cellStyle.vAlign = VAlignType.center;
    O.cellStyle.hAlign = HAlignType.center;
    O.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    O.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    O.columnWidth = 24;
    var P = worksheet.getRangeByIndex(1, 16);
    P.cellStyle.vAlign = VAlignType.center;
    P.cellStyle.hAlign = HAlignType.center;
    P.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    P.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    P.columnWidth = 24;
    var Q = worksheet.getRangeByIndex(1, 17);
    Q.cellStyle.vAlign = VAlignType.center;
    Q.cellStyle.hAlign = HAlignType.center;
    Q.cellStyle.backColorRgb = Color.fromRGBO(0, 150, 255, 1);
    Q.cellStyle.fontColorRgb = Color.fromRGBO(255, 255, 255, 1);
    Q.columnWidth = 24;



    // Excel header
    A.setText(session.getString(session.Sl));
    B.setText(session.getString(session.Date));
    C.setText(session.getString(session.ContainerSl));
    D.setText(session.getString(session.SealNo));
    E.setText('PO#');
    F.setText(session.getString(session.MaterialNo));
    G.setText(session.getString(session.WareHouse));
    H.setText(session.getString(session.ReelNo));
    H.setText(session.getString(session.Qyt));
    I.setText('Checked by');
    K.setText('Pic 1');
    L.setText('Pic 2');
    M.setText('Pic 3');
    N.setText('Pic 4');
    O.setText('Pic 5');
    int i = 2;
    for (int key in Hive.box("inbound_database").keys) {

      DataModel dm = Hive.box("inbound_database").get(key);
      //print (dm.quantity);
      var a = worksheet.getRangeByIndex(i, 1);
      a.cellStyle.vAlign = VAlignType.center;
      a.cellStyle.hAlign = HAlignType.center;
      a.rowHeight = 100;
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
      var k = worksheet.getRangeByIndex(i, 9);
      k.cellStyle.vAlign = VAlignType.center;
      k.cellStyle.hAlign = HAlignType.center;
      k.setValue(session.getAssignWorker());
      for (int j = 0; j < dm.imageUrls!.length; j++) {

         var picture = worksheet.pictures.addBase64(i, j + 10, dm.imageUrls![j]);
         picture.width = 162;
         picture.height = 122;

      }
      i++;
    }

    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

    final folderName = "SBTCkeker";

    final path = Directory("storage/emulated/0/$folderName");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      print('Exist');
      return await File('storage/emulated/0/SBTCkeker/' + file_name + '.xlsx').writeAsBytes(bytes);
    } else {
      path.create();
      return await File('storage/emulated/0/SBTCkeker/' + file_name + '.xlsx').writeAsBytes(bytes);
    }

  }
}
