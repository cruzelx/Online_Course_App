import 'package:flutter/material.dart';

Widget buttons(String groupValue, String value, Function setGroupValue) {
  return Column(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0xfff0f0f0), blurRadius: 10.0, spreadRadius: 3.0)
            ],
            border: value == groupValue
                ? Border.all(color: Color(0xff1000ff), width: 1.5)
                : Border(),
            borderRadius: BorderRadius.circular(100.0)),
        child: RadioListTile(
          activeColor: Color(0xff1000ff),
          value: value,
          groupValue: groupValue,
          onChanged: setGroupValue,
          title: Text(value),
        ),
      ),
      SizedBox(height: 20.0),
    ],
  );
}
