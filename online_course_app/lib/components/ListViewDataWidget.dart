import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListViewDataWidget extends StatelessWidget {
  String title;
  Function onEdit;
  Function onDelete;
  ListViewDataWidget({@required this.title, this.onEdit, this.onDelete});
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
            leading: Icon(Icons.star),
            title: Text(title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                )),
          )),
    );
  }
}
