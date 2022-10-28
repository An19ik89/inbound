

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DashViewModel with ChangeNotifier {




  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<XFile?> _listImage = [];
  List<XFile?> get listImage => _listImage;
  set listImages(XFile? value) {
    _listImage.add(value) ;
    notifyListeners();
  }





}
