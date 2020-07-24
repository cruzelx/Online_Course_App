import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  String message;
  Icon leadingIcon;
  Color backgroundColor;
  TextStyle textStyle;
  IconButton actionIcon;

  MessageWidget({
    Key key,
    @required this.message,
    @required this.leadingIcon,
    @required this.actionIcon,
    this.backgroundColor = const Color(0xffffff),
    this.textStyle,
  })  : assert(message.isNotEmpty),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Material(
          elevation: 10.0,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                leadingIcon,
                Text(
                  message,
                  style: textStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                actionIcon
              ],
            ),
          ),
        ),
      ),
    );
  }
}
