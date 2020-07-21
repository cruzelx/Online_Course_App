import 'package:flutter/material.dart';

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
          _buttons(groupValue, option, setGroupValue),
      ],
    );
  }
}

Widget _buttons(String groupValue, String value, Function setGroupValue) {
  return Column(
    children: <Widget>[
      Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(100.0),
        color: Color(0xff252525),
        shadowColor: Color(0xff101010),
        child: Container(
          decoration: BoxDecoration(
              border: value == groupValue
                  ? Border.all(color: Colors.yellowAccent)
                  : Border(),
              borderRadius: BorderRadius.circular(100.0)),
          child: RadioListTile(
            activeColor: Colors.pinkAccent,
            value: value,
            groupValue: groupValue,
            onChanged: setGroupValue,
            title: Text(value, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 18.0),
    ],
  );
}
