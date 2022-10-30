import 'package:image_picker/image_picker.dart';

class ImageUtils{
  Future<XFile?> pickCameraImage() async {
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(source: ImageSource.camera,
      maxWidth: 166.08,maxHeight: 133.44,imageQuality: 90,);
  }
}