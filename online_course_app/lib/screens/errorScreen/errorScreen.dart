import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorScreen extends StatelessWidget {
  final Widget errorImage =
      SvgPicture.asset("assets/images/error.svg", height: 200.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      errorImage,
                      SizedBox(height: 60.0),
                      Text(
                        "Page Not Found",
                        style: TextStyle(
                            color: Color(0xff121212),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      )
                    ],
                  )))),
    );
  }
}
