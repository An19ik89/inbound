
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:inbound_flutter/utils/image_utils.dart';
import 'package:path_provider/path_provider.dart';

import '../ui/page/dash/dash_page.dart';
import '../utils/date_time_utils.dart';


final di = GetIt.instance;

Future<void> setup() async {
  //pages
  di.registerSingleton(DashPage());

  //utils
  di.registerSingleton(ImageUtils());
  di.registerSingleton(DateTimeUtils());


}