import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:online_course_app/models/quizeModel.dart';

class ListViewQuestionWidget extends StatelessWidget {
  Question question;
  Function onEdit;
  Function onDelete;
  ListViewQuestionWidget(
      {@required this.question,
      @required this.onEdit,
      @required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          secondaryActions: <Widget>[
            GestureDetector(
              onTap: onEdit,
              child: CircleAvatar(
                child: Icon(Icons.edit),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: onDelete,
              child: CircleAvatar(
                child: Icon(Icons.delete),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            )
          ],
          child: ListTile(
            title: Text(question.question,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14.0,
                )),
          )),
    );
  }
}
