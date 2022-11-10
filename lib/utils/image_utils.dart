import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils{
  Future<XFile?> pickCameraImage() async {
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(source: ImageSource.camera,
      maxWidth: 420,maxHeight: 420,imageQuality: 100,);
  }

  Future<String> imageCovertBase64(XFile? imageBytes) async{
    try {
      final bytes = File(imageBytes!.path).readAsBytesSync();

      return base64Encode(bytes);;
    }catch(e){
      print(e);
      return 'no';
    }
  }

  Future<XFile?> imageCovertFile(String imageBytes) async{
    try {

      Uint8List decodedBytes = base64Decode(imageBytes);
      return await XFile(bytes: decodedBytes ?? null,'1.png');
    }catch(e){
      print("Fuck");
      print(e);
      print(e);
    }
  }
}