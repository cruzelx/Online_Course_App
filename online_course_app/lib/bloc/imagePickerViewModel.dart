import 'dart:io';
import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/services/mediaService.dart';

class ImagePickerViewModel extends BaseModel {
  final _mediaService = locator<MediaService>();

  List<File> _images;

  List<File> get images => _images;

  Future selectImage() async {
    final _uploadedImage = await _mediaService.pickImage();
    if (_uploadedImage is bool) return false;
    _images.add(_uploadedImage);
  }
}
