import 'package:flutter/material.dart';

Widget creationTitleWidget(createImage, item) {
  return Stack(
    alignment: Alignment.bottomRight,
    children: <Widget>[
      Container(child: createImage),
      RichText(
        text: TextSpan(
            text: "Create",
            style: TextStyle(
                color: Color(0xff121212),
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
            children: <TextSpan>[
              TextSpan(
                  text: item,
                  style: TextStyle(
                      color: Color(0xff1000ff),
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0))
            ]),
      ),
    ],
  );
}
