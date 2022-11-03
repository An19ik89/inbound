import 'package:inbound_flutter/ui/page/login/login_viewmodel.dart';
import 'package:inbound_flutter/ui/page/navigation/navigation_viewmodel.dart';
import 'package:inbound_flutter/ui/page/registration/registration_viewmodel.dart';
import 'package:inbound_flutter/ui/page/splash/splash_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';




List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  // Provider(create: (_) => Api()),
];

List<SingleChildWidget> dependentServices = [
  ChangeNotifierProvider(create: (_) => SplashViewModel()),
  ChangeNotifierProvider(create: (_) => NavigationViewModel()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
];