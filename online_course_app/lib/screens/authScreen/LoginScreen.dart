import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/components/messageWidget.dart';
import 'package:online_course_app/constants/enums/connectivityStatus.dart';
import 'package:online_course_app/services/authService.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final Widget learningImage =
      SvgPicture.asset('assets/images/learning.svg', height: 200);
  final Widget googleImage =
      SvgPicture.asset('assets/images/google.svg', height: 20.0);
  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final connectionState = Provider.of<ConnectivityStatus>(context);
    final loginState = Provider.of<LoginViewModel>(context);
    return Scaffold(
        body: Stack(children: <Widget>[
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Spacer(),
            learningImage,
            Spacer(),
            Container(
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xff222222),
                splashColor: Color(0xff5000ff),
                highlightColor: Color(0xff5000ff),
                onPressed: connectionState != ConnectivityStatus.Offline
                    ? () {
                        loginState.login();
                      }
                    : null,
                disabledColor: Colors.grey,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    googleImage,
                    SizedBox(width: 20.0),
                    Text("Sign In With Google")
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      loginState.messageVisibility
          ? MessageWidget(
              message: "Welcome Back!",
              backgroundColor: Colors.redAccent,
              textStyle: TextStyle(color: Colors.white),
              leadingIcon: Icon(
                Icons.card_travel,
                size: 18.0,
                color: Colors.white,
              ),
              actionIcon: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    loginState.setMessageVisibility(false);
                  }),
            )
          : Container(),
    ]));
  }
}
