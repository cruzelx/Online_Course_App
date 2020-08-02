import 'package:flutter/material.dart';
import 'package:online_course_app/models/quizeModel.dart';

class QuizeCardWidget extends StatelessWidget {
  Quize quize;
  Function onDelete;
  Function onEdit;
  QuizeCardWidget({@required this.quize, this.onDelete, this.onEdit});
  @override
  Widget build(BuildContext context) {
    int questionsLength = quize.questions.length;
    String quizeTitle = quize.title;
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Color(0xfff0f0f0), blurRadius: 10.0, spreadRadius: 3.0)
          ]),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  quizeTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Icon(Icons.blur_on),
                    SizedBox(width: 5.0),
                    Text("$questionsLength questions")
                  ],
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(8.0),
            // color: Colors.red,
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: onEdit,
                  child: CircleAvatar(
                    radius: 18,
                    child: Icon(
                      Icons.edit,
                      size: 18.0,
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green.withOpacity(0.9),
                  ),
                ),
                Spacer(),
                InkWell(
                  onLongPress: onDelete,
                  child: CircleAvatar(
                    radius: 18.0,
                    child: Icon(
                      Icons.delete,
                      size: 18.0,
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent.withOpacity(0.9),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
