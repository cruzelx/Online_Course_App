import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app/bloc/CreateQuizeQuestion.dart';
import 'package:online_course_app/bloc/CreateQuizeValidationViewModel.dart';
import 'package:online_course_app/bloc/quizeViewModel.dart';
import 'package:online_course_app/components/CreationTitleWidget.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/screens/quizeScreen/components/radioButtonWidget.dart';
import 'package:provider/provider.dart';

class CreateQuestionScreen extends StatefulWidget {
  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  TextEditingController _questionTextController = TextEditingController();
  TextEditingController _optionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final createQuestionNotifier =
        Provider.of<CreateQuizeQuestionViewModel>(context);
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
                          "Create Question",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          controller: _questionTextController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "Enter Question",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xfff0f0f0),
                          ),
                          onChanged: (String value) {
                            createQuestionNotifier.setQuestion(value);
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
                          controller: _optionTextController,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (String value) {
                            if (value.isNotEmpty) {
                              createQuestionNotifier.addOption(value);
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
                        for (String option in createQuestionNotifier.options)
                          GestureDetector(
                              onLongPress: () {
                                createQuestionNotifier.removeOption(option);
                              },
                              child: buttons(
                                  createQuestionNotifier.groupValue,
                                  option,
                                  createQuestionNotifier.setGroupValue)),
                        SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Color(0xff121212),
                                onPressed: () {
                                  // _optionTextController.dispose();
                                  // _questionTextController.dispose();
                                },
                                child: Text("Finish"),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Color(0xff1000ff),
                                  onPressed: () {
                                    if (_globalFormKey.currentState
                                        .validate()) {
                                      bool res = createQuestionNotifier
                                          .createQuestion();
                                      if (res) {
                                        createQuestionNotifier.resetValues();
                                        _optionTextController.clear();
                                        _questionTextController.clear();
                                      }
                                    }
                                  },
                                  child: Text("Add More")),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
