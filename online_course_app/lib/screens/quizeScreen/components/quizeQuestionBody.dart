import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/userViewModel.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/screens/quizeScreen/QuizeResultScreen.dart';
import 'package:online_course_app/screens/quizeScreen/components/quizeOptionButton.dart';
import 'package:online_course_app/screens/quizeScreen/components/radioButtonWidget.dart';
import 'package:provider/provider.dart';

class QuizeQuestionBody extends StatefulWidget {
  Question question;
  int questionIndex;
  PageController pageController;
  int totalPages;
  QuizeQuestionBody(
      {Key key,
      this.totalPages,
      this.question,
      this.questionIndex,
      this.pageController})
      : super(key: key);
  @override
  _QuizeQuestionBodyState createState() => _QuizeQuestionBodyState();
}

class _QuizeQuestionBodyState extends State<QuizeQuestionBody>
    with AutomaticKeepAliveClientMixin {
  String groupValue = '';

  setGroupValue(String val) {
    setState(() {
      groupValue = val;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final scoreNotifier = Provider.of<UserViewModel>(context, listen: false);
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: "Question ${widget.questionIndex + 1}/",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.totalPages.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                                color: Colors.black))
                      ])),
              SizedBox(height: 25.0),
              Text(
                widget.question.question,
                style: TextStyle(fontSize: 19.0),
              ),
              SizedBox(height: 40.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  for (String option in widget.question.options)
                    buttons(groupValue, option, setGroupValue),
                ],
              ),
              SizedBox(height: 22.0),
              Container(
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
                child: widget.questionIndex + 1 == widget.totalPages
                    ? RaisedButton(
                        textColor: Colors.white,
                        onPressed: () async {
                          if (groupValue ==
                              widget.question
                                  .options[widget.question.correctAnswer]) {
                            scoreNotifier.incrementTopicScore =
                                1 / widget.totalPages;
                          }
                          await scoreNotifier.uploadScores();
                          Navigator.popAndPushNamed(
                              context, QuizeResultViewScreen);
                        },
                        child: Text("Finish"),

                        color: Color(0xff1000ff),
                        // highlightColor: Colors.pinkAccent,
                        splashColor: Color(0xff121212),
                      )
                    : RaisedButton(
                        onPressed: () {
                          if (groupValue ==
                              widget.question
                                  .options[widget.question.correctAnswer]) {
                            scoreNotifier.incrementTopicScore =
                                1 / widget.totalPages;
                          }
                          widget.pageController.nextPage(
                              duration: Duration(milliseconds: 450),
                              curve: Curves.easeInOut);
                        },
                        child: Text("Next"),
                        elevation: 20.0,
                        color: Color(0xff121212),
                        // highlightColor: Colors.pinkAccent,
                        splashColor: Color(0xff1000ff),
                      ),
              )
            ],
          )),
    );
  }
}
