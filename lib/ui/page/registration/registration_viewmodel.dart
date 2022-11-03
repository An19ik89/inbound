import 'package:flutter/material.dart';
import 'package:inbound_flutter/core/route/route_paths.dart';
import 'package:inbound_flutter/core/session/session.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';



class RegistrationViewModel with ChangeNotifier {
  final Session session = di<Session>();

  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }


  TextEditingController oldNameController = TextEditingController();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  registration(String name, String password,String old_name, String old_password,context) async {
    if(old_name == session.defaut_user && old_password == session.default_password){
      session.setLoginUser(name);
      session.setLoginPassword(password);
      oldNameController.clear();
      oldpasswordController.clear();
      nameController.clear();
      passwordController.clear();
      const snackBar = SnackBar(
        content: Text(
            'Account Created'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.of(context).pop();
    }else{
      const snackBar = SnackBar(
        content: Text(
            'Not Matched'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  default_user(context) async {
    session.setLoginUser(session.defaut_user);
    session.setLoginPassword(session.default_password);

      const snackBar = SnackBar(
        content: Text(
            'Default user setted'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.of(context).pop();

  }





}
