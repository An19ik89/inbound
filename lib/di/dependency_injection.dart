
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inbound_flutter/core/model/inbound_data_model.dart';
import 'package:inbound_flutter/core/session/session.dart';
import 'package:inbound_flutter/core/session/session_impl.dart';
import 'package:inbound_flutter/ui/page/field/field_page.dart';
import 'package:inbound_flutter/ui/page/login/login_page.dart';
import 'package:inbound_flutter/ui/page/navigation/navigation_page.dart';
import 'package:inbound_flutter/ui/page/navigation/tab/details_tab.dart';
import 'package:inbound_flutter/ui/page/navigation/tab/home_tab.dart';
import 'package:inbound_flutter/ui/page/navigation/tab/settings_tab.dart';
import 'package:inbound_flutter/ui/page/registration/registration_page.dart';
import 'package:inbound_flutter/ui/page/splash/splash_page.dart';
import 'package:inbound_flutter/utils/excel_utils.dart';
import 'package:inbound_flutter/utils/image_utils.dart';
import 'package:inbound_flutter/utils/alert_dialog_utils.dart';
import 'package:inbound_flutter/utils/res/qrscan_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  await Hive.openBox("inbound_database_key");

  //local
  di.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  di.registerLazySingleton<Session>(() => SessionImpl(  preferences: di<SharedPreferences>()));

  //utils
  di.registerSingleton(ImageUtils());
  di.registerSingleton(DateTimeUtils());
  di.registerSingleton(ExcelUtils());
  di.registerSingleton(AlertDialogUtils());
  di.registerSingleton(QrScanUtils());

  //pages
  di.registerSingleton(FieldPage());
  di.registerSingleton(NavigationPage());
  di.registerSingleton(SplashPage());
  di.registerSingleton(LoginPage());
  di.registerSingleton(RegistrationPage());

  //tab
  di.registerSingleton(HomeTab());
  di.registerSingleton(DetailsTab());
  di.registerSingleton(SettingsTab());




}