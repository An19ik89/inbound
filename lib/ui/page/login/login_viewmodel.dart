import 'package:flutter/material.dart';
import 'package:inbound_flutter/core/route/route_paths.dart';
import 'package:inbound_flutter/core/session/session.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';



class LoginViewModel with ChangeNotifier {
  final Session session = di<Session>();

  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  login(String name, String password,context) async {
    if(name == session.getLoginUser() && password == session.getLoginPassword()){
      emailController.clear();
      passwordController.clear();
      session.setBool(session.LOGIN, true);
      Navigator.pushNamedAndRemoveUntil(context, RoutePaths.NAVIGATOR, (route) => false);
    }else{
      const snackBar = SnackBar(
        content: Text(
            'Not Matched'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    }





}
