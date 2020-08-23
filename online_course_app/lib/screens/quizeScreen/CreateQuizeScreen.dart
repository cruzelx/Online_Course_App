import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:online_course_app/bloc/questionViewModel.dart';
import 'package:online_course_app/bloc/quizeViewModel.dart';
import 'package:online_course_app/components/ListViewDataWidget.dart';
import 'package:online_course_app/components/progressDialogManager.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/screens/quizeScreen/CreateQuestionScreen.dart';
import 'package:online_course_app/screens/quizeScreen/viewAllQuizesScreen.dart';
import 'package:provider/provider.dart';

class CreateQuizeScreen extends StatefulWidget {
  @override
  _CreateQuizeScreenState createState() => _CreateQuizeScreenState();
}

class _CreateQuizeScreenState extends State<CreateQuizeScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _quizeTitleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quizeNotifier = Provider.of<QuizeViewModel>(context);
    final questionNotifier = Provider.of<QuestionViewModel>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    quizeNotifier.isQuizeEditing
                        ? "Edit Quize"
                        : "Create Quize",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    // controller: _quizeTitleController,
                    textCapitalization: TextCapitalization.words,
                    initialValue:
                        quizeNotifier.isQuizeEditing ? quizeNotifier.title : '',
                    decoration: InputDecoration(
                      hintText: "Enter Quize Title",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xfff0f0f0),
                    ),
                    onChanged: (String value) {
                      quizeNotifier.setQuizeTitle(value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Quize Title cannot be empty';
                      } else if (value.length > 200) {
                        return 'Quize Title length must be less than 200 chars';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CreateQuestionViewScreen);
                      questionNotifier.resetQuestion();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            size: 30.0,
                          ),
                          SizedBox(width: 10.0),
                          Text("Add Question",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                      child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: quizeNotifier.questions.length,
                    itemBuilder: (context, index) {
                      return ListViewDataWidget(
                          title: quizeNotifier.questions[index].question,
                          onDelete: () => quizeNotifier.removeQuestion(index),
                          onEdit: () {
                            questionNotifier.editQuestion(
                                quizeNotifier.questions[index], index);
                            Navigator.pushNamed(
                                context, CreateQuestionViewScreen);
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
                            final ProgressDialogHandler pdh =
                                ProgressDialogHandler(
                                    context: context,
                                    message: quizeNotifier.isQuizeEditing
                                        ? 'Updating Quize...'
                                        : 'Creating Quize...');
                            await pdh.showProgressDialog();
                            final res = await quizeNotifier.uploadQuize();
                            await pdh.hideProgressDialog();
                            if (!(res is bool)) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: quizeNotifier.isQuizeEditing
                            ? Text("Update")
                            : Text("Create"),
                        color: quizeNotifier.isQuizeEditing
                            ? Color(0xff121212)
                            : Color(0xff1000ff),
                        textColor: Colors.white,
                      ))
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
