
import 'package:get_it/get_it.dart';
import 'package:inbound_flutter/utils/image_utils.dart';

import '../ui/page/dash/dash_page.dart';


final di = GetIt.instance;

Future<void> setup() async {
  //pages
  di.registerSingleton(DashPage());

  //utils
  di.registerSingleton(ImageUtils());

}