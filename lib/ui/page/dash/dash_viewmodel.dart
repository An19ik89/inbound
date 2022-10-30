

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbound_flutter/core/model/inbound_data_model.dart';

class DashViewModel with ChangeNotifier {



  // Controller
  TextEditingController containerSlController = TextEditingController();
  TextEditingController sealNoController = TextEditingController();
  TextEditingController wareHouseController = TextEditingController();
  TextEditingController materialNoController = TextEditingController();
  TextEditingController qytController = TextEditingController();

  // Image Picking
  List<XFile?> _listImage = [];
  List<String> _base64ImageList = [];
  List<XFile?> get listImage => _listImage;
  List<String>? get base64ImageList => _base64ImageList;
  set listImageAdd(XFile? value) {
    _listImage.add(value) ;
    convertImage(value);
    notifyListeners();
  }

  convertImage(XFile? imageBytes) async{
    //List<int> bytes = await imageBytes.readAsBytes();

    final bytes = File(imageBytes!.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);
    _base64ImageList.add(base64Image.toString());
  }

  set listImageRemove(int index) {
    _listImage.removeAt(index) ;
    _base64ImageList.removeAt(index);
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

  void indbound_data(){

    DataModel dataModel = DataModel();
    dataModel.containerSl = containerSlController.text;
    dataModel.sealNo = sealNoController.text;
    dataModel.warehouse = wareHouseController.text;
    dataModel.materialNo = materialNoController.text;
    dataModel.date = "${_dobDay ??""}/${_dobMonth??""}/${_dobYear??""}";
    dataModel.reelNo = "barcode";
    dataModel.quantity = "1";
    dataModel.imageUrls = base64ImageList;

    Hive.box("inbound_database").put("save_data", dataModel);
    // log("TEST : ${dataModel[0].imageUrls.toString()}");
    log("READ TEST FROM HIVE : ${Hive.box("inbound_database").get("save_data")}");

  }

  bool data_validate(){
    if(_dobDay == null || _dobYear == null || _dobMonth == null) return false;
    else if(containerSlController.text.isEmpty) return false;
    else if(sealNoController.text.isEmpty) return false;
    else if(wareHouseController.text.isEmpty) return false;
    else if(materialNoController.text.isEmpty) return false;
    else if(qytController.text.isEmpty) return false;
    else if(_barcode==null) return false;

    else return true;
  }


}
