import 'package:flutter/material.dart';
import 'package:online_course_app/models/categoryModel.dart';

class EditCardWidget extends StatelessWidget {
  String title;
  String items;
  Function onDelete;
  Function onEdit;
  EditCardWidget({this.title, this.items, this.onDelete, this.onEdit});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 2.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Icon(Icons.blur_on),
                      SizedBox(width: 5.0),
                      Text(items),
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
      ),
    );
  }
}
