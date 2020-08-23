import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/screens/courseScreen/components/courseInfoBoxWidget.dart';
import 'package:online_course_app/screens/courseScreen/components/descriptionBoxWidget.dart';

class CourseDescriptionWidget extends StatelessWidget {
  Course course;
  CourseDescriptionWidget({Key key, @required this.course}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(course.createdBy);
    print(course.title);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Join"),
        icon: Icon(Icons.add),
      ),
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                floating: true,
                title: Text(course.title),
                expandedHeight: MediaQuery.of(context).size.height * 0.40,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Hero(
                        tag: 'coverImage',
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: CachedNetworkImage(
                              imageUrl: course.coverImage, fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.black.withOpacity(0.15),
                              Colors.black.withOpacity(0.4)
                            ])),
                      )
                    ],
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  descriptionBox(course.title, course.description),
                  SizedBox(height: 30.0),
                  Divider(),
                  courseInfoBox(course.category, course.createdBy,
                      course.createdAt, course.chapters.length),
                ],
              ),
            ),
          )),
    );
  }
}
