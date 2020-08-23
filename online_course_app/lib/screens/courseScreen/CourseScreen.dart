import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/studyScreenStateViewModel.dart';
import 'package:online_course_app/bloc/userViewModel.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/screens/courseScreen/components/courseContentDrawer.dart';
import 'package:online_course_app/components/youtubeVideoPlayer.dart';
import 'package:online_course_app/screens/courseScreen/components/courseDescriptionWidget.dart';
import 'package:online_course_app/screens/courseScreen/components/descriptionBoxWidget.dart';
import 'package:online_course_app/screens/courseScreen/components/topicWidget.dart';
import 'package:online_course_app/screens/quizeScreen/QuizeScreen.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatelessWidget {
  Course course;
  CourseScreen({Key key, this.course}) : super(key: key);

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final studyScreenNotifier = Provider.of<StudyScreenStateViewModel>(context);
   
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Icon(Icons.menu),
          backgroundColor: Colors.redAccent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        drawer: Drawer(
          child: CourseDrawer(
            course: course,
          ),
        ),
        body: studyScreenNotifier.currentTopic == null
            ? CourseDescriptionWidget(course: course)
            : TopicWidget(topic: studyScreenNotifier.currentTopic));
  }
}
