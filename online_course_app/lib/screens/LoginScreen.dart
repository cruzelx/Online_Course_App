import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app/services/authService.dart';

class LoginScreen extends StatelessWidget {
  final Widget learningImage =
      SvgPicture.asset('assets/images/learning.svg', height: 200);
  final Widget googleImage =
      SvgPicture.asset('assets/images/google.svg', height: 20.0);
  AuthenticationService _authService = AuthenticationService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
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
              onPressed: () {
                _authService.signIn();
              },
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
    ));
  }
}
