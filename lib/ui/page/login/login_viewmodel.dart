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


  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController assignWorkerController = TextEditingController();



  login(String name, String password,String assign_worker,context) async {
    if(name == session.getLoginUser() && password == session.getLoginPassword() && assign_worker != ''){
      nameController.clear();
      passwordController.clear();
      assignWorkerController.clear();
      session.setAssignWorker(assign_worker);
      session.setBool(session.LOGIN, true);
      Navigator.pushNamedAndRemoveUntil(context, RoutePaths.NAVIGATOR, (route) => false);
    }else if(assign_worker == ''){
      const snackBar = SnackBar(
        content: Text(
            'Assign Worker Should not be empty'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
      const snackBar = SnackBar(
        content: Text(
            'Not Matched'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    }





}
