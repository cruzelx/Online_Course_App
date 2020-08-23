import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProgressDialogHandler{
  String message;
  BuildContext context;
  ProgressDialog pr;

  ProgressDialogHandler({this.message, this.context}) {
    pr = ProgressDialog(context, isDismissible: false);
    pr.style(
        message: message,
        borderRadius: 10.0,
        progressWidget: SpinKitChasingDots(
          size: 40.0,
          color: Colors.deepPurpleAccent,
        ));
  }

  showProgressDialog() async {
    await pr.show();
  }

  hideProgressDialog() async {
    await pr.hide();
  }
}
