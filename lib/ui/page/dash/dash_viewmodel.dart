

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DashViewModel with ChangeNotifier {



  // Controller
  TextEditingController containerSlController = TextEditingController();
  TextEditingController sealNoController = TextEditingController();
  TextEditingController wareHouseController = TextEditingController();
  TextEditingController materialNoController = TextEditingController();

  // Image Picking
  List<XFile?> _listImage = [];
  List<XFile?> get listImage => _listImage;
  set listImageAdd(XFile? value) {
    _listImage.add(value) ;
    notifyListeners();
  }
  set listImageRemove(int index) {
    _listImage.removeAt(index) ;
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
