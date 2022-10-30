

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DashViewModel with ChangeNotifier {



  // Controller
  TextEditingController containerSlController = TextEditingController();
  TextEditingController sealNoController = TextEditingController();
  TextEditingController wareHouseController = TextEditingController();
  TextEditingController materialNoController = TextEditingController();
  TextEditingController qytController = TextEditingController();

  // Image Picking
  List<XFile?> _listImage = [];
  List<String> _base64Image = [];
  List<XFile?> get listImage => _listImage;
  List<String>? get base64Image => _base64Image;
  set listImageAdd(XFile? value) {
    _listImage.add(value) ;
    convertImage(value);
    notifyListeners();
  }

  convertImage(XFile? imageBytes) async{
    //List<int> bytes = await imageBytes.readAsBytes();

    final bytes = File(imageBytes!.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);
    _base64Image.add(base64Image.toString());
  }

  set listImageRemove(int index) {
    _listImage.removeAt(index) ;
    _base64Image.removeAt(index);
    notifyListeners();
  }

  // Date Picker
  String? _dobDay ;
  String? _dobMonth ;
  String? _dobYear ;

  String? get dobDay => _dobDay;
  String? get dobMonth => _dobMonth;
  String? get dobYear => _dobYear;

  set dobDay(String? value) {
    _dobDay = value;
    notifyListeners();
  }
  set dobMonth(String? value) {
    _dobMonth = value;
    notifyListeners();
  }
  set dobYear(String? value) {
    _dobYear = value;
    notifyListeners();
  }



  String? _barcode ;
  String? get barcode => _barcode;
  set barcode(String? value) {
    _barcode = value ;
    notifyListeners();
  }


}
