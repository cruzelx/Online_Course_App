import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/studyScreenStateViewModel.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/screens/courseScreen/CourseScreen.dart';
import 'package:provider/provider.dart';

class CategoryCourseCard extends StatelessWidget {
  Course course;
  bool isDisabled;
  CategoryCourseCard({Key key, this.course, this.isDisabled = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final int chaptersLength = course.chapters.length;
    final studyScreenNotifier = Provider.of<StudyScreenStateViewModel>(context);

    return GestureDetector(
        onTap: isDisabled
            ? null
            : () {
                if (studyScreenNotifier.currentCourseId != course.id) {
                  studyScreenNotifier.resetValue();
                  studyScreenNotifier.setCurrentCourseId(course.id);
                  studyScreenNotifier.setCurrentCourse(course);
                }

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CourseScreen(course: course)));
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
                            child: Hero(
                              tag: 'courseImage',
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                      imageUrl: course.coverImage,
                                      fit: BoxFit.cover)),
                            )),
                        SizedBox(width: 8.0),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(course.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5.0),
                              Text(
                                chaptersLength == 1
                                    ? '.$chaptersLength chapter'
                                    : '.$chaptersLength chapters',
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
                        course.description,
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
