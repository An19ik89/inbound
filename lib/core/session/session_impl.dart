import 'package:inbound_flutter/core/session/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionImpl extends Session{
    SharedPreferences preferences;
    SessionImpl({required this.preferences});




  @override
  bool getBool(String name) {
    return preferences.getBool( name ) ?? false;
  }


  @override
  void setBool(String name, bool value) {
    preferences.setBool(name, value);
  }

  @override
  void removeAll() {
    preferences.clear();
  }

  @override
  String getString(String name) {
    return preferences.getString( name ) ?? name;
  }

  @override
  void setString(String name, String value) {
    preferences.setString(name, value);
  }

  @override
  String getLoginPassword() {
    return preferences.getString( PASSWORD ) ?? default_password;
  }

  @override
  String getLoginUser() {
    return preferences.getString(USER  ) ?? defaut_user;
  }

  @override
  void setLoginPassword(String value) {
    preferences.setString(PASSWORD, value);
  }

  @override
  void setLoginUser(String value) {
    preferences.setString(USER, value);
  }

  @override
  String getAssignWorker() {
    return preferences.getString(ASSIGN_WORKER  ) ?? defaut_user;
  }

  @override
  void setAssignWorker(String value) {
    preferences.setString(ASSIGN_WORKER, value);
  }

}