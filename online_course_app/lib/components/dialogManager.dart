import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_course_app/constants/enums/connectivityStatus.dart';
import 'package:online_course_app/models/dialogRequestModel.dart';
import 'package:online_course_app/services/dialogService.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../locator.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);
  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    // TODO: implement initState
    _dialogService.registerDialogListener(_showDialog);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkStatus _connStat = Provider.of<NetworkStatus>(context);

    return _connStat != NetworkStatus.Offline
        ? widget.child
        : Scaffold(
            body: Center(
              child: Text("No Internet Connection"),
            ),
          );
  }

  void _showDialog(DialogRequest dialogRequest) {
    Alert(
        context: context,
        type: dialogRequest.alertType,
        style: AlertStyle(
            isOverlayTapDismiss: false,
            isCloseButton: false,
            animationType: AnimationType.fromTop,
            animationDuration: Duration(milliseconds: 300)),
        title: dialogRequest.title,
        desc: dialogRequest.description,
        closeFunction: () => _dialogService.dialogCompleter(false),
        buttons: [
          DialogButton(
              color: Colors.redAccent,
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _dialogService.dialogCompleter(true);
                Navigator.of(context).pop();
              }),
          DialogButton(
              color: Colors.blue,
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _dialogService.dialogCompleter(false);
                Navigator.of(context).pop();
              })
        ]).show();
  }
}
