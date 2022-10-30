
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inbound_flutter/core/model/inbound_data_model.dart';
import 'package:inbound_flutter/ui/page/qr_scan/qr_scan.dart';
import 'package:inbound_flutter/utils/image_utils.dart';
import 'package:path_provider/path_provider.dart';

import '../ui/page/dash/dash_page.dart';
import '../utils/date_time_utils.dart';


final di = GetIt.instance;

Future<void> setup() async {
  var externalDir;
  if (Platform.isIOS) { // Platform is imported from 'dart:io' package
    externalDir = await getApplicationDocumentsDirectory();
  } else if (Platform.isAndroid) {
    externalDir = await getExternalStorageDirectory();
  }
  Hive.registerAdapter(DataModelAdapter());
  await Hive.initFlutter();
  Hive.init(externalDir.path);
  await Hive.openBox("inbound_database");


  //pages
  di.registerSingleton(DashPage());
  di.registerSingleton(QRScan());

  //utils
  di.registerSingleton(ImageUtils());
  di.registerSingleton(DateTimeUtils());


}