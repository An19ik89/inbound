import 'package:inbound_flutter/ui/page/navigation/navigation_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../ui/page/dash/dash_viewmodel.dart';



List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  // Provider(create: (_) => Api()),
];

List<SingleChildWidget> dependentServices = [
  ChangeNotifierProvider(create: (_) => DashViewModel()),
  ChangeNotifierProvider(create: (_) => NavigationViewModel()),
];