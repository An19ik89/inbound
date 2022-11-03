
import 'package:flutter/material.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'package:inbound_flutter/ui/page/field/field_page.dart';
import 'package:inbound_flutter/ui/page/login/login_page.dart';
import 'package:inbound_flutter/ui/page/navigation/navigation_page.dart';
import 'package:inbound_flutter/ui/page/registration/registration_page.dart';
import 'package:inbound_flutter/ui/page/splash/splash_page.dart';
import 'route_paths.dart';


class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.SPLASH:
        return MaterialPageRoute(builder: (_) => di<SplashPage>());
      case RoutePaths.LOGIN:
        return MaterialPageRoute(builder: (_) => di<LoginPage>());
        case RoutePaths.REGISTRATION:
        return MaterialPageRoute(builder: (_) => di<RegistrationPage>());
      case RoutePaths.FIELD:
        return MaterialPageRoute(builder: (_) => di<FieldPage>());
      case RoutePaths.NAVIGATOR:
        return MaterialPageRoute(builder: (_) => di<NavigationPage>());

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