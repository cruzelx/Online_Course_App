import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/chapterViewModel.dart';
import 'package:online_course_app/bloc/quizeViewModel.dart';
import 'package:online_course_app/bloc/topicViewModel.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:provider/provider.dart';

class CreateTopicScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final quizeNotifier = Provider.of<QuizeViewModel>(context);
    final topicNotifier = Provider.of<TopicViewModel>(context);
    final chapterNotifier = Provider.of<ChapterViewModel>(context);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topicNotifier.isTopicEditing
                        ? "Edit Topic"
                        : "Create Topic",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 20.0),
                          TextFormField(
                              textCapitalization: TextCapitalization.words,
                              initialValue: topicNotifier.title,
                              decoration: InputDecoration(
                                hintText: "Enter Topic Title",
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0xfff0f0f0),
                              ),
                              onChanged: (String value) {
                                topicNotifier.setTitle(value);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Topic Title must not be empty";
                                } else if (value.length > 200) {
                                  return "Topic Title length mustbe less than 200";
                                } else {
                                  return null;
                                }
                              }),
                          SizedBox(height: 20.0),
                          TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            initialValue: topicNotifier.description,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: "Enter Topic Description",
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color(0xfff1f1f1),
                            ),
                            onChanged: (String value) {
                              topicNotifier.setDescription(value);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Topic Description must not be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                              initialValue: topicNotifier.videoUrl,
                              decoration: InputDecoration(
                                hintText: "Paste YouTube Url",
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0xfff0f0f0),
                              ),
                              onChanged: (String value) {
                                topicNotifier.setVideoUrl(value);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Url must not be empty";
                                } else if (value.length > 200) {
                                  return "Url length must be less than 200";
                                } else {
                                  return null;
                                }
                              }),
                          SizedBox(height: 20.0),
                        ],
                      )),
                  Text(
                    "Select Quize:",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButton<String>(
                      isExpanded: true,
                      underline: Container(
                        height: 2.0,
                        color: Colors.black87,
                      ),
                      hint: Text("Select Quize"),
                      value: topicNotifier.selectedQuize?.id,
                      selectedItemBuilder: (BuildContext context) {
                        return quizeNotifier.quizes
                            .map<Widget>((Quize quize) => Text(
                                  quize.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ))
                            .toList();
                      },
                      items: quizeNotifier.quizes
                          .map<DropdownMenuItem<String>>(
                              (Quize quize) => DropdownMenuItem<String>(
                                  value: quize.id,
                                  child: Text(
                                    quize.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )))
                          .toList(),
                      onChanged: (value) async {
                        topicNotifier.setSelectedQuize(value);
                      }),
                  Spacer(),
                  Container(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            final res = topicNotifier.createTopic();
                            if (res is bool) {
                            } else if (res is Topic) {
                              topicNotifier.isTopicEditing
                                  ? chapterNotifier.updateTopicAtIndex(
                                      res, topicNotifier.currentIndex)
                                  : chapterNotifier.addTopic(res);
                              Navigator.pop(context);
                              // topicNotifier.resetTopic();
                            }
                          }
                        },
                        child: topicNotifier.isTopicEditing
                            ? Text("Update")
                            : Text("Create"),
                        color: Color(0xff1000ff),
                        textColor: Colors.white,
                      ))
                ],
              )),
            )));
  }
}
