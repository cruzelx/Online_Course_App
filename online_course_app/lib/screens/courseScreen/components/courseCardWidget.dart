import 'package:flutter/material.dart';
import 'package:online_course_app/models/categoryModel.dart';
import 'package:online_course_app/models/courseModel.dart';

class CourseCardWidget extends StatelessWidget {
  Course course;
  Function onDelete;
  Function onEdit;
  CourseCardWidget({@required this.course, this.onDelete, this.onEdit});
  @override
  Widget build(BuildContext context) {
    
    int chaptersLength = course.chapters.length;
    String courseTitle = course.title;
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
                  courseTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Icon(Icons.blur_on),
                    SizedBox(width: 5.0),
                    Text("$chaptersLength chapters")
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
