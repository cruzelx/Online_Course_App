import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/chapterViewModel.dart';
import 'package:online_course_app/bloc/courseViewModel.dart';
import 'package:online_course_app/bloc/topicViewModel.dart';
import 'package:online_course_app/components/ListViewDataWidget.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:provider/provider.dart';

class CreateChapterScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final chapterNotifier = Provider.of<ChapterViewModel>(context);
    final topicNotifier = Provider.of<TopicViewModel>(context);
    final courseNotifier = Provider.of<CourseViewModel>(context);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapterNotifier.isChapterEditing
                        ? "Edit Chapter"
                        : "Create Chapter",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      // controller: _quizeTitleController,
                      textCapitalization: TextCapitalization.words,
                      initialValue: chapterNotifier.title,

                      decoration: InputDecoration(
                        hintText: "Enter Chapter Title",
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xfff0f0f0),
                      ),
                      onChanged: (String value) {
                        chapterNotifier.setTitle(value);
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Chapter Title cannot be empty';
                        } else if (value.length > 200) {
                          return 'Chapter Title length must be less than 200 chars';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CreateTopicViewScreen);
                      topicNotifier.resetTopic();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            size: 30.0,
                          ),
                          SizedBox(width: 10.0),
                          Text("Add Topic",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                      child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: chapterNotifier.topics.length,
                    itemBuilder: (context, index) {
                      return ListViewDataWidget(
                          title: chapterNotifier.topics[index].title,
                          onDelete: () => chapterNotifier.removeTopic(index),
                          onEdit: () async {
                            await topicNotifier.editTopic(
                                chapterNotifier.topics[index], index);
                            Navigator.pushNamed(context, CreateTopicViewScreen);
                          });
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  )),
                  Container(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            final res = chapterNotifier.createChapter();
                            if (res is bool) {
                            } else if (res is Chapter) {
                              chapterNotifier.isChapterEditing
                                  ? courseNotifier.updateChapterAtIndex(
                                      res, chapterNotifier.currentIndex)
                                  : courseNotifier.addChapter(res);
                              Navigator.pop(context);
                              // chapterNotifier.resetChapter();
                            }
                          }
                        },
                        child: chapterNotifier.isChapterEditing
                            ? Text("Update")
                            : Text("Create"),
                        color: Color(0xff1000ff),
                        textColor: Colors.white,
                      ))
                ],
              ),
            ),
          )),
    ));
  }
}
