import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_course_app/bloc/CreateQuizeQuestion.dart';
import 'package:online_course_app/bloc/categoryViewModel.dart';
import 'package:online_course_app/bloc/chapterViewModel.dart';
import 'package:online_course_app/bloc/courseViewModel.dart';
import 'package:online_course_app/bloc/imagePickerViewModel.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/bloc/questionViewModel.dart';
import 'package:online_course_app/bloc/quizeViewModel.dart';
import 'package:online_course_app/bloc/studyScreenStateViewModel.dart';
import 'package:online_course_app/bloc/topicViewModel.dart';
import 'package:online_course_app/bloc/userViewModel.dart';
import 'package:online_course_app/screens/mainScreen/MainScreen.dart';
import 'package:provider/provider.dart';

class MainScreenWrapper extends StatefulWidget {
  @override
  _MainScreenWrapperState createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  @override
  Widget build(BuildContext context) {
    return Wrapper();
  }
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<LoginViewModel>(context).isLoading
        ? Scaffold(
            body: Center(
              child: SpinKitChasingDots(
                size: 50.0,
                color: Colors.deepPurpleAccent,
              ),
            ),
          )
        : MainScreen();
  }
}
