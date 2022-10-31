import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inbound_flutter/core/model/inbound_data_model.dart';
import 'package:inbound_flutter/core/route/route_paths.dart';
import 'package:inbound_flutter/core/route/routes.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import 'core/providers.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: providers,
      child: ScreenUtilInit(
          designSize: const Size(414, 896),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Flutter MVVM',
              debugShowCheckedModeBanner: true,
              theme: ThemeData(
                primarySwatch: Colors.amber,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              initialRoute: RoutePaths.DASH,
              onGenerateRoute:  Routes.generateRoute,
            );
          }),
    );
  }
}