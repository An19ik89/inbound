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

}