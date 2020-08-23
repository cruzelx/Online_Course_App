import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/bloc/studyScreenStateViewModel.dart';
import 'package:online_course_app/bloc/userViewModel.dart';
import 'package:online_course_app/components/youtubeVideoPlayer.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/screens/courseScreen/components/descriptionBoxWidget.dart';
import 'package:online_course_app/screens/quizeScreen/QuizeScreen.dart';
import 'package:provider/provider.dart';

class TopicWidget extends StatelessWidget {
  Topic topic;
  TopicWidget({Key key, this.topic}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("here");
    print(topic.quize);

    final userNotifier = Provider.of<UserViewModel>(context, listen: false);
    final loginNotifier = Provider.of<LoginViewModel>(context, listen: false);
    final studyScreenNotifier =
        Provider.of<StudyScreenStateViewModel>(context, listen: false);

    return Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            YoutubeVideoPlayer(
              youtubeUrl: topic.videoUrl,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: descriptionBox(topic.title, topic.description),
            ),
            RaisedButton(
              onPressed: () {
                userNotifier.nullifyScore();
                userNotifier.setCurretnUser(loginNotifier.currentUser);
                userNotifier.setCurrentCourse(
                    studyScreenNotifier.currentCourse.id,
                    studyScreenNotifier.currentCourse.title);
                userNotifier
                    .setCurrentTopic(studyScreenNotifier.currentTopic.title);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QuizeScreen(
                          quizeId: topic.quize,
                        )));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Colors.green,
              splashColor: Colors.pinkAccent,
              hoverElevation: 10.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Center(
                    child: Text(
                  "Take a quiz",
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
