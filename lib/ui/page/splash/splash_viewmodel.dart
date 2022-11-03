

import 'package:flutter/material.dart';

class SplashViewModel with ChangeNotifier {


  bool _repeatForever = false;
  bool get repeatForever => _repeatForever;


  bool _stopPauseOnTap = false;
  bool get stopPauseOnTap => _stopPauseOnTap;


  bool _onFinished = true;
  bool get onFinished => _onFinished;

   onMove() {
     _repeatForever = !repeatForever;
     _stopPauseOnTap = !stopPauseOnTap;
    _onFinished = !onFinished;

    notifyListeners();
  }
}
