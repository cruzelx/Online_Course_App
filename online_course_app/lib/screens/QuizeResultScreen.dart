import 'package:flutter/material.dart';


class QuizeResultScreen extends StatefulWidget {
  @override
  _QuizeResultScreenState createState() => _QuizeResultScreenState();
}

class _QuizeResultScreenState extends State<QuizeResultScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text("Quize Results"),
          Text("Congratulations Alex!"),

        ],
      ),
    )));
  }
}
