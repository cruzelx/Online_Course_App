import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class MediaService {
  final _picker = ImagePicker();

  Future pickImage() async {
    try {
      PickedFile _image = await _picker.getImage(source: ImageSource.gallery);
      return File(_image.path);
    } catch (e) {
      return false;
    }
  }
}
