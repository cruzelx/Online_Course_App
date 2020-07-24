import 'package:flutter/cupertino.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool _messageVisibility = false;

  bool get busy => _busy;
  bool get messageVisibility => _messageVisibility;

  setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  setMessageVisibility(bool value) {
    _messageVisibility = value;
    notifyListeners();
  }
}
