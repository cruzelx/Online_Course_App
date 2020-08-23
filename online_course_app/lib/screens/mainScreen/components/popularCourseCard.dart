import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/studyScreenStateViewModel.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/screens/courseScreen/CourseScreen.dart';
import 'package:provider/provider.dart';

class PopularCourseCard extends StatelessWidget {
  Course course;
  PopularCourseCard({Key key, @required this.course}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final int chaptersLength = course.chapters.length;
    final studyScreenNotifier = Provider.of<StudyScreenStateViewModel>(context);

    return GestureDetector(
      onTap: () {
        if (studyScreenNotifier.currentCourseId != course.id) {
          studyScreenNotifier.resetValue();
          studyScreenNotifier.setCurrentCourseId(course.id);
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => CourseScreen(course: course)));
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
              width: 250.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 125.0,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      child: CachedNetworkImage(
                        imageUrl: course.coverImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      // image: DecorationImage(
                      //     image: NetworkImage(course.coverImage),
                      //     fit: BoxFit.cover)
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          course.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: <Widget>[
                            Icon(Icons.blur_on),
                            SizedBox(width: 8.0),
                            Text(chaptersLength == 1
                                ? '$chaptersLength Chapter'
                                : '$chaptersLength Chapters')
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.blur_on),
                            SizedBox(width: 8.0),
                            Text(course.category),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Divider(),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10.0),
                      Icon(Icons.play_circle_outline),
                      SizedBox(width: 8.0),
                      Text(
                        "Start The Course",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 8.0)
                ],
              )),
        ),
      ),
    );
  }
}
