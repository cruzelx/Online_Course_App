import 'package:flutter/material.dart';
import 'package:online_course_app/screens/CourseScreen.dart';

class CategoryCourseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CourseScreen()));
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
            height: 150.0,
            width: double.infinity,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 50.0,
                            width: 50.0,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  "https://www.paperstreet.com/blog/wp-content/uploads/2017/07/spaceapegames_img-1-compressor.jpg",
                                  fit: BoxFit.cover,
                                ))),
                        SizedBox(width: 8.0),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Beginner: Introduction To Neural Network",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5.0),
                              Text(
                                ".5 Chapters  .12 Videos",
                                style: TextStyle(fontSize: 13.0),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7.0),
                    Container(
                      height: 35.0,
                      child: Text(
                        "Some info about the course. Some info about the course.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Icon(Icons.play_circle_outline),
                        SizedBox(width: 8.0),
                        Text("Start The Course",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                )),
          ),
        ));
  }
}
