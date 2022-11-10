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
    _isSwitchedHoneyWell = session.getBool(session.SCANNER);

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
  List<String> _base64ImageList = <String>[];
  List<String> get base64ImageList =>_base64ImageList;


  set base64ImageListAdd(XFile? value) {
    imageUtils.imageCovertBase64(value).then((value) => _base64ImageList.add(value));
    notifyListeners();
  }


  set base64listImageRemove(int index) {
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

    if (!Hive.box("inbound_database_key").containsKey(reelNoController.text)) {
      Hive.box("inbound_database_key").put(reelNoController.text,true);
      Hive.box("inbound_database").add(dataModel).then((_)  async {

        const snackBar = SnackBar(
          content: Text(
              'Data Saved !'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

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
    _base64ImageList = [];
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

    containerSlFieldController.clear();
    sealNoFieldController.clear();
    wareHouseFieldController.clear();
    materialNoFieldController.clear();
    qytFieldController.clear();
    dateFieldController.clear();
    slFieldController.clear();
    notifyListeners();
  }

  void title_reset_data(){
    session.setString(session.ContainerSl, session.ContainerSl);
    session.setString(session.SealNo, session.SealNo);
    session.setString(session.WareHouse, session.WareHouse);
    session.setString(session.MaterialNo, session.MaterialNo);
    session.setString(session.Qyt, session.Qyt);
    session.setString(session.Date, session.Date);
    session.setString(session.Sl, session.Sl);

    containerSlFieldController.clear();
    sealNoFieldController.clear();
    wareHouseFieldController.clear();
    materialNoFieldController.clear();
    qytFieldController.clear();
    dateFieldController.clear();
    slFieldController.clear();
    notifyListeners();
  }



  // --------- DetailsPage ---------
// Controller
  TextEditingController dbClearController = TextEditingController();

  List<DataModel> _dataModelList = [];
  List<DataModel> get dataModelList => _dataModelList;
   getDatabaseData(){
    _dataModelList.clear();
    _dataModelList = [];
    for(int key in Hive.box("inbound_database").keys) {
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



  clearDatabase(){
    Hive.box("inbound_database").clear();
    Hive.box("inbound_database_key").clear();
    _dataModelList.clear();
    _dataModelList = [];
    notifyListeners();
  }

  // --------- Update ---------

  int update_index = -1;

  // Date Picker
  String? _dobUpdateDay;
  String? _dobUpdateMonth;
  String? _dobUpdateYear;

  String? get dobUpdateDay => _dobUpdateDay;
  String? get dobUpdateMonth => _dobUpdateMonth;
  String? get dobUpdateYear => _dobUpdateYear;

  set  dobUpdate(DateTime value) {
    _dobUpdateDay = DateFormat('dd').format(value).toString();
    _dobUpdateMonth = DateFormat('MMM').format(value).toString();
    _dobUpdateYear = DateFormat('yyyy').format(value).toString();
    notifyListeners();
  }

  // Controller
  TextEditingController containerUpdateSlController = TextEditingController();
  TextEditingController sealNoUpdateController = TextEditingController();
  TextEditingController wareHouseUpdateController = TextEditingController();
  TextEditingController materialUpdateNoController = TextEditingController();
  TextEditingController qytUpdateController = TextEditingController();
  TextEditingController reelUpdateNoController = TextEditingController();


  // Image Picking
  List<String>  _base64UpdateImageList= <String>[];
  List<String> get base64UpdateImageList =>_base64UpdateImageList;


  set base64UpdateImageListAdd(XFile? value) {
    imageUtils.imageCovertBase64(value).then((value) => _base64UpdateImageList.add(value));
    notifyListeners();
  }


  set base64UpdatelistImageRemove(int index) {
    _base64UpdateImageList.removeAt(index);
    notifyListeners();
  }

  void getSingleItem(int index){
    clearUpdateValue();
    _dataModelList[index].imageUrls;
    _dobUpdateDay = _dataModelList[index].date!.substring(0,2) ?? '';
    _dobUpdateMonth = _dataModelList[index].date!.substring(3,6) ?? '';
    _dobUpdateYear = _dataModelList[index].date!.substring(7,11) ?? '';
    containerUpdateSlController.text = _dataModelList[index].containerSl ?? '';
    sealNoUpdateController.text = _dataModelList[index].sealNo ?? '';
    wareHouseUpdateController.text = _dataModelList[index].warehouse ?? '';
    materialUpdateNoController.text = _dataModelList[index].materialNo ?? '';
    qytUpdateController.text = _dataModelList[index].quantity ?? '';
    reelUpdateNoController.text = _dataModelList[index].reelNo ?? '';
    for(int i = 0;i<(_dataModelList[index].imageUrls != null ? _dataModelList[index].imageUrls!.length:0) ;i++) {
      _base64UpdateImageList.add(_dataModelList[index].imageUrls![i]);
    };

    notifyListeners();
  }

  void indbound_data_update(context){
    DataModel dataModel = DataModel();
    dataModel.containerSl = containerUpdateSlController.text;
    dataModel.sealNo = sealNoUpdateController.text;
    dataModel.warehouse = wareHouseUpdateController.text;
    dataModel.materialNo = materialUpdateNoController.text;
    dataModel.date = "${_dobUpdateDay ?? ""}/${_dobUpdateMonth ?? ""}/${_dobUpdateYear ?? ""}";
    dataModel.reelNo = reelUpdateNoController.text;
    dataModel.quantity = qytUpdateController.text;
    dataModel.imageUrls = _base64UpdateImageList;
    if (Hive.box("inbound_database_key").containsKey(reelUpdateNoController.text)) {
      Hive.box("inbound_database_key").put(reelNoController.text,true);
      Hive.box("inbound_database").put(update_index,dataModel).then((_)  async {
        update_index = - 1;

        const snackBar = SnackBar(
          content: Text(
              'Data Updated !'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        clearDatabaseDate();
        clearUpdateValue();
        await getDatabaseData();
        Navigator.of(context).pop();
      });
    }
    else{

      const snackBar = SnackBar(
        content: Text(
            'Barcode not found !'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  String data_update_validate() {
    if(_dobUpdateDay == null || _dobUpdateYear == null || _dobUpdateMonth == null) return 'Select date';
    else if(containerUpdateSlController.text.isEmpty) return 'Container is empty';
    else if(sealNoUpdateController.text.isEmpty) return 'Seal no is empty';
    else if(wareHouseUpdateController.text.isEmpty) return 'Warehouse is empty';
    else if(materialUpdateNoController.text.isEmpty) return 'Material is empty';
    else if(qytUpdateController.text.isEmpty) return 'Quantity is empty';
    else if(reelUpdateNoController.text.isEmpty) return 'Barcode is empty';
    else {
      return '';
    }

  }
  void singleDataDelete(context,index) {

    Hive.box("inbound_database").delete(index);
    Hive.box("inbound_database_key").delete(index).then((value)  async {
    const snackBar = SnackBar(
    content: Text(
    'Data Deleted !'),
    );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    clearDatabaseDate();
    await getDatabaseData();
    });
    notifyListeners();
}


  void clearUpdateValue(){
    try {
      _dobUpdateDay = null;
      _dobUpdateMonth = null;
      _dobUpdateYear = null;
      containerUpdateSlController.clear();
      sealNoUpdateController.clear();
      wareHouseUpdateController.clear();
      materialUpdateNoController.clear();
      qytUpdateController.clear();
      reelUpdateNoController.clear();
      _base64UpdateImageList = [];
    }catch (e){
      print(e);
    }

  }




}