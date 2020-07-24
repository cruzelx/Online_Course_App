import 'package:flutter/material.dart';
import 'package:online_course_app/screens/CourseScreen.dart';

class PopularCourseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => CourseScreen()));
      },
      child: Container(
          width: 250.0,
          decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black.withOpacity(0.4), width: 0.3),
              borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 125.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://static.sustainability.asu.edu/giosMS-uploads/sites/15/2019/05/teaching-resources-1024x575.jpg"),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Begineer: Introduction To Neural Network",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        Icon(Icons.blur_on),
                        SizedBox(width: 8.0),
                        Text("12 videos"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.blur_on),
                        SizedBox(width: 8.0),
                        Text("5 Chapters"),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Icon(Icons.play_circle_outline),
                        SizedBox(width: 8.0),
                        Text(
                          "Start The Course",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
