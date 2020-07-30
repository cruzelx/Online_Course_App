import 'package:flutter/material.dart';
import 'package:online_course_app/screens/quizeScreen/components/radioButtonWidget.dart';

class QuizeOptionsButtons extends StatefulWidget {
  @override
  _QuizeOptionsButtonsState createState() => _QuizeOptionsButtonsState();
}

class _QuizeOptionsButtonsState extends State<QuizeOptionsButtons> {
  String groupValue = '';

  setGroupValue(String val) {
    setState(() {
      groupValue = val;
    });
  }

  List<String> _optionsValue = [
    "This is option #1",
    "This is option #2",
    "This is option #3",
    "This is option #4",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        for (String option in _optionsValue)
          buttons(groupValue, option, setGroupValue),
      ],
    );
  }
}


