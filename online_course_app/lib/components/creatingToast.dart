import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/constants/enums/connectivityStatus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget creatingToast(BuildContext context, ToastState toastState,
    Duration duration, String message) {
  Color leftBarIndicatorColor;
  if (toastState == ToastState.ERROR) {
    leftBarIndicatorColor = Colors.redAccent;
  } else if (toastState == ToastState.LOADING) {
    leftBarIndicatorColor = Colors.yellowAccent;
  } else if (toastState == ToastState.SUCCESSFUL) {
    leftBarIndicatorColor = Colors.greenAccent;
  } else {
    leftBarIndicatorColor = Colors.black;
  }
  return Flushbar(
    icon: SpinKitChasingDots(
      size: 40.0,
      color: Colors.deepPurpleAccent,
    ),
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: EdgeInsets.all(10.0),
    padding: EdgeInsets.all(20.0),
    borderRadius: 10.0,
    leftBarIndicatorColor: leftBarIndicatorColor,
    duration: duration,
    borderColor: leftBarIndicatorColor,
    message: message,
    isDismissible: false,
    backgroundColor: Color(0xff303030),
    boxShadows: [
      BoxShadow(
          color: Colors.grey,
          offset: Offset(0.5, 0.5),
          spreadRadius: 2.0,
          blurRadius: 10.0)
    ],
  )..show(context);
}
