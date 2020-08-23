import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/components/dialogManager.dart';
import 'package:online_course_app/constants/enums/connectivityStatus.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/main.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/services/authService.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final Widget learningImage =
      SvgPicture.asset('assets/images/learning.svg', height: 200);
  final Widget googleImage =
      SvgPicture.asset('assets/images/google.svg', height: 20.0);

  @override
  Widget build(BuildContext context) {
    final loginNotifier = Provider.of<LoginViewModel>(context);
    print("Inside login screen");
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                onPressed: () async {
                  User user = await loginNotifier.login();
                  if (user != null) {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  }
                },
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
      )),
    );
  }
}
