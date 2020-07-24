import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:online_course_app/screens/CategoryScreens.dart';
import 'package:online_course_app/screens/CourseScreen.dart';
import 'package:online_course_app/screens/MainScreen.dart';
import 'package:online_course_app/screens/LoginScreen.dart';
import 'package:online_course_app/screens/QuizScreen.dart';
import 'package:online_course_app/screens/QuizeResultScreen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeViewScreen:
        return MaterialPageRoute(builder: (_) => MainScreen());
        break;
      case LoginViewScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
      case CourseViewScreen:
        return MaterialPageRoute(builder: (_) => CourseScreen());
        break;
      case QuizeViewScreen:
        return MaterialPageRoute(builder: (_) => QuizeScreen());
        break;
      case QuizeResultViewScreen:
        return MaterialPageRoute(builder: (_) => QuizeResultScreen());
        break;
      case CategoryViewScreen:
        return MaterialPageRoute(builder: (_) => CategoryScreen());
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text("Noroute defined for ${settings.name}"))));
    }
  }
}
