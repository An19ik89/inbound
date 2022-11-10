// import 'package:flutter_share/flutter_share.dart';
// import 'package:documents_picker/documents_picker.dart';

import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';

class FileShareUtils{
  Future<void> shareFile() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        initialDirectory: 'storage/emulated/0/SBTCkeker/',
        allowedExtensions: ['xlsx'],
        allowCompression: false
    );

    if (result != null) {

      Share.shareFiles([result.files.single.path!], text: '');
    } else {
      // User canceled the picker
    }

  }
}