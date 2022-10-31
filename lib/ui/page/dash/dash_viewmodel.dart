import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbound_flutter/core/model/inbound_data_model.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DashViewModel with ChangeNotifier {
  // Controller
  TextEditingController containerSlController = TextEditingController();
  TextEditingController sealNoController = TextEditingController();
  TextEditingController wareHouseController = TextEditingController();
  TextEditingController materialNoController = TextEditingController();
  TextEditingController qytController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();

  // Image Picking
  List<XFile?> _listImage = [];
  List<String> _base64ImageList = [];
  List<XFile?> get listImage => _listImage;
  List<String>? get base64ImageList => _base64ImageList;
  set listImageAdd(XFile? value) {
    _listImage.add(value);
    convertImage(value);
    notifyListeners();
  }

  convertImage(XFile? imageBytes) async {
    //List<int> bytes = await imageBytes.readAsBytes();

    final bytes = File(imageBytes!.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);
    _base64ImageList.add(base64Image.toString());
  }

  set listImageRemove(int index) {
    _listImage.removeAt(index);
    _base64ImageList.removeAt(index);
    notifyListeners();
  }

  // Date Picker
  String? _dobDay;
  String? _dobMonth;
  String? _dobYear;

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

  String? _barcode;
  String? get barcode => _barcode;
  set barcode(String? value) {
    _barcode = value;
    notifyListeners();
  }

  void indbound_data(context) async {
    DataModel dataModel = DataModel();
    dataModel.containerSl = containerSlController.text;
    dataModel.sealNo = sealNoController.text;
    dataModel.warehouse = wareHouseController.text;
    dataModel.materialNo = materialNoController.text;
    dataModel.date = "${_dobDay ?? ""}/${_dobMonth ?? ""}/${_dobYear ?? ""}";
    dataModel.reelNo = _barcode;
    dataModel.quantity = qytController.text;
    dataModel.imageUrls = base64ImageList;

    if (!Hive.box("inbound_database").containsKey(_barcode)) {
      Hive.box("inbound_database").put(_barcode,dataModel).then((_)  {
          data_clear();
      });
    }
    else{

      final snackBar = SnackBar(
        content: Text(
            'Barcode already been used !'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


  }

  String data_validate() {
    if(_dobDay == null || _dobYear == null || _dobMonth == null) return 'Select date';
    else if(containerSlController.text.isEmpty) return 'Container is empty';
    else if(sealNoController.text.isEmpty) return 'Seal no is empty';
    else if(wareHouseController.text.isEmpty) return 'Warehouse is empty';
    else if(materialNoController.text.isEmpty) return 'Material is empty';
    else if(qytController.text.isEmpty) return 'Quantity is empty';
    else if(_barcode==null) return 'Barcode is emply';

    else return '';

  }


  // Drawer Side menu

  bool _isSwitchedHoneyWell = false ;
  bool get isSwitchedHoneyWell => _isSwitchedHoneyWell;

  set isSwitchedHoneyWell(bool value) {
    _isSwitchedHoneyWell = value;
    notifyListeners();
  }

  void data_clear(){
    _dobDay = null;
    _dobMonth = null;
    _dobYear = null;
    containerSlController.clear();
    sealNoController.clear();
    wareHouseController.clear();
    materialNoController.clear();
    qytController.clear();
    _barcode = null;
    _listImage.clear();
    _base64ImageList.clear();
    notifyListeners();
  }

}
