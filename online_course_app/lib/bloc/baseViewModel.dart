import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/services/authService.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authService = locator<AuthenticationService>();
  bool _busy = false;
  bool _messageVisibility = false;
  // bool _isUserLoggedIn = false; 

  bool get busy => _busy;
  bool get messageVisibility => _messageVisibility;
  // bool get isUserLoggedIn => _isUserLoggedIn;

  setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  setMessageVisibility(bool value) {
    _messageVisibility = value;
    notifyListeners();
  }
}
