import 'dart:async';

import 'package:online_course_app/models/dialogRequestModel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogService {
  Function(DialogRequest) _showDialogListener;

  Completer<bool> _dialogCompleter;

  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<bool> showDialog(
      {String title, String description, AlertType alertType}) {
    _dialogCompleter = Completer<bool>();
    _showDialogListener(DialogRequest(
        title: title, description: description, alertType: alertType));
    return _dialogCompleter.future;
  }

  void dialogCompleter(bool response) {
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}
