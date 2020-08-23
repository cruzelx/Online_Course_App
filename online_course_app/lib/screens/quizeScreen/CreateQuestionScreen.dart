import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/questionViewModel.dart';
import 'package:online_course_app/bloc/quizeViewModel.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/screens/quizeScreen/components/radioButtonWidget.dart';
import 'package:provider/provider.dart';

class CreateQuestionScreen extends StatefulWidget {
  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final questionNotifier = Provider.of<QuestionViewModel>(context);
    final quizeNotifier = Provider.of<QuizeViewModel>(context);
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Form(
                    key: _globalFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          questionNotifier.isQuestionEditing
                              ? "Edit Question"
                              : "Create Question",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          initialValue: questionNotifier.question,
                          maxLines: 4,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: "Enter Question",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xfff0f0f0),
                          ),
                          onChanged: (String value) {
                            questionNotifier.setQuestion(value);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Question field cannot be empty';
                            } else if (value.length > 200) {
                              return 'Question length must be less than 200 chars';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          initialValue: questionNotifier.question,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (String value) {
                            if (value.isNotEmpty) {
                              questionNotifier.addOption(value);
                            }

                            // setState(() {
                            //   options.add(value);
                            // });
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Option",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xfff0f0f0),
                          ),
                          validator: (String value) {
                            if (value.length > 100) {
                              return "Option must be less than 100 chars";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 30.0),
                        for (String option in questionNotifier.options)
                          GestureDetector(
                              onLongPress: () {
                                questionNotifier.removeOption(option);
                              },
                              child: buttons(questionNotifier.groupValue,
                                  option, questionNotifier.setGroupValue)),
                        SizedBox(height: 30.0),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Color(0xff121212),
                            onPressed: () {
                              if (_globalFormKey.currentState.validate()) {
                                final res =
                                    questionNotifier.createQuizeQuestion();
                                if (!(res is bool)) {
                                  questionNotifier.isQuestionEditing
                                      ? quizeNotifier.updateQuestionAtIndex(res,
                                          questionNotifier.currentQuestionIndex)
                                      : quizeNotifier.addQuestion(res);
                                  Navigator.pop(context);
                                  questionNotifier.resetQuestion();
                                }
                              }
                            },
                            child: Text("Finish"),
                          ),
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
