
import 'package:flutter/material.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import '../../ui/page/dash/dash_page.dart';
import 'route_paths.dart';


class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.DASH:
        return MaterialPageRoute(builder: (_) => di<DashPage>());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No Page Availabe：${settings.name}'),
              ),
            ));
    }
  }

}