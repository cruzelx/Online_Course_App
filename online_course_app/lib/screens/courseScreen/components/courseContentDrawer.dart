import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/studyScreenStateViewModel.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:provider/provider.dart';

class CourseDrawer extends StatelessWidget {
  final Course course;
  CourseDrawer({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studyScreenNotifier = Provider.of<StudyScreenStateViewModel>(context);
    final chaptersLength = course.chapters.length;

    final List<Widget> _chapters = [
      for (Chapter chapter in course.chapters)
        ExpansionTile(
          title: Text(
            chapter.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          onExpansionChanged: (bool) {},
          children: <Widget>[
            for (Topic topic in chapter.topics)
              ListTile(
                leading: Icon(Icons.ondemand_video),
                title: Text(topic.title),
                onTap: () {
                  studyScreenNotifier.setCurrentTopic(topic);
                  Navigator.pop(context);
                },
              )
          ],
        )
    ];

    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        ListTile(
          onTap: () {
            studyScreenNotifier.resetValue();
            Navigator.pop(context);
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(course.coverImage),
          ),
          title: Text(
            course.title,
            textScaleFactor: 1.3,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(chaptersLength == 1
              ? '.$chaptersLength chapter'
              : '.$chaptersLength chapters'),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: _chapters,
            ),
          ),
        )
      ],
    );
  }
}
