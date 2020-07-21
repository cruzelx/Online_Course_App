import 'package:flutter/material.dart';
import 'package:online_course_app/screens/CategoryScreens.dart';
import 'package:online_course_app/screens/CourseScreen.dart';
import 'package:online_course_app/screens/MainScreen.dart';
import 'package:online_course_app/screens/QuizScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(OnlineCourseApp());
}

class OnlineCourseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Online Course App",
      home: HomePage(),
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuizeScreen();
    // return CourseScreen();
    // return CategoryScreen();
  }
}
