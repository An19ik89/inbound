import 'package:image_picker/image_picker.dart';

class ImageUtils{
  Future<XFile?> pickCameraImage() async {
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 400,
      imageQuality: 50,);
  }
}