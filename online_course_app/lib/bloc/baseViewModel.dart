import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/services/authService.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authService = locator<AuthenticationService>();
  bool _busy = false;
  bool _messageVisibility = false;
  bool get busy => _busy;
  bool get messageVisibility => _messageVisibility;
  // bool get isUserLoggedIn => _isUserLoggedIn;

  User get currentUser => _authService.currentUser;

  Future uploadFile(File image, String filename) async {
    try {
      final StorageReference storageReference =
          FirebaseStorage.instance.ref().child('images/$filename');
      final StorageUploadTask _uploadTask = storageReference.putFile(image);
      final String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  setMessageVisibility(bool value) {
    _messageVisibility = value;
    notifyListeners();
  }
}
