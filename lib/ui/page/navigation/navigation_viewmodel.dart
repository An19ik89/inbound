import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbound_flutter/core/model/inbound_data_model.dart';
import 'package:inbound_flutter/core/session/session.dart';
import 'package:inbound_flutter/di/dependency_injection.dart';
import 'dart:convert';

import 'package:inbound_flutter/utils/image_utils.dart';
import 'package:intl/intl.dart';

class NavigationViewModel with ChangeNotifier {
  var imageUtils = di<ImageUtils>();
  int _currentIndex = 0;

  int  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }




  final Session session = di<Session>();
  NavigationViewModel(){
    containerSlFieldController.text = session.getString(session.ContainerSl);
    sealNoFieldController.text = session.getString(session.SealNo);
    wareHouseFieldController.text = session.getString(session.WareHouse);
    materialNoFieldController.text = session.getString(session.MaterialNo);
    qytFieldController.text = session.getString(session.Qyt);
    dateFieldController.text = session.getString(session.Date);
    slFieldController.text = session.getString(session.Sl);

    getDatabaseData();

  }


  // --------- homePage ---------

  // Date Picker
  String? _dobDay;
  String? _dobMonth;
  String? _dobYear;

  String? get dobDay => _dobDay;
  String? get dobMonth => _dobMonth;
  String? get dobYear => _dobYear;

  set  dob(DateTime value) {
    _dobDay = DateFormat('dd').format(value).toString();
    _dobMonth = DateFormat('MMM').format(value).toString();
    _dobYear = DateFormat('yyyy').format(value).toString();
    notifyListeners();
  }

  // Controller
  TextEditingController containerSlController = TextEditingController();
  TextEditingController sealNoController = TextEditingController();
  TextEditingController wareHouseController = TextEditingController();
  TextEditingController materialNoController = TextEditingController();
  TextEditingController qytController = TextEditingController();
  TextEditingController reelNoController = TextEditingController();


  // Image Picking
  final List<XFile?> _listImage = [];
  final List<String> _base64ImageList = [];
  List<XFile?> get listImage => _listImage;

  set listImageAdd(XFile? value) {
    _listImage.add(value);
    imageUtils.imageCovertBase64(value).then((value) => _base64ImageList.add(value));
    notifyListeners();
  }


  set listImageRemove(int index) {
    _listImage.removeAt(index);
    _base64ImageList.removeAt(index);
    notifyListeners();
  }

  void indbound_data_save(context) async {
    DataModel dataModel = DataModel();
    dataModel.containerSl = containerSlController.text;
    dataModel.sealNo = sealNoController.text;
    dataModel.warehouse = wareHouseController.text;
    dataModel.materialNo = materialNoController.text;
    dataModel.date = "${_dobDay ?? ""}/${_dobMonth ?? ""}/${_dobYear ?? ""}";
    dataModel.reelNo = reelNoController.text;
    dataModel.quantity = qytController.text;
    dataModel.imageUrls = _base64ImageList;

    if (!Hive.box("inbound_database").containsKey(reelNoController.text)) {
      Hive.box("inbound_database").put(reelNoController.text,dataModel).then((_)  async {
        clearDatabaseDate();

        await getDatabaseData();
      });
    }
    else{

      const snackBar = SnackBar(
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
    else if(reelNoController.text.isEmpty) return 'Barcode is empty';
    else {
      return '';
    }

  }



  void clearDatabaseDate(){
    qytController.clear();
    reelNoController.clear();
    _listImage.clear();
    //_base64ImageList.clear();
    notifyListeners();
  }



  // Controller field
  TextEditingController containerSlFieldController = TextEditingController();
  TextEditingController sealNoFieldController = TextEditingController();
  TextEditingController wareHouseFieldController = TextEditingController();
  TextEditingController materialNoFieldController = TextEditingController();
  TextEditingController qytFieldController = TextEditingController();
  TextEditingController dateFieldController = TextEditingController();
  TextEditingController slFieldController = TextEditingController();


  void title_data(){
    session.setString(session.ContainerSl, containerSlFieldController.text);
    session.setString(session.SealNo, sealNoFieldController.text);
    session.setString(session.WareHouse, wareHouseFieldController.text);
    session.setString(session.MaterialNo, materialNoFieldController.text);
    session.setString(session.Qyt, qytFieldController.text);
    session.setString(session.Date, dateFieldController.text);
    session.setString(session.Sl, slFieldController.text);
    notifyListeners();
  }



  // --------- DetailsPage ---------

  List<DataModel> _dataModelList = [];
  List<DataModel> get dataModelList => _dataModelList;
   getDatabaseData(){
    _dataModelList.clear();
    _dataModelList = [];
    for(String key in Hive.box("inbound_database").keys) {
      _dataModelList.add(Hive.box("inbound_database").get(key));
    }
    notifyListeners();
  }

  // Controller
  TextEditingController fileNameController = TextEditingController();

  bool _isSwitchedHoneyWell = false ;
  bool get isSwitchedHoneyWell => _isSwitchedHoneyWell;

  set isSwitchedHoneyWell(bool value) {
    _isSwitchedHoneyWell = value;
    notifyListeners();
  }

}