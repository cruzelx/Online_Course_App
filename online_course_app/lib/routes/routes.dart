import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:online_course_app/main.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/screens/authScreen/LoginScreen.dart';
import 'package:online_course_app/screens/categoryScreen/CategoryScreens.dart';
import 'package:online_course_app/screens/categoryScreen/CreateCategoryScreen.dart';
import 'package:online_course_app/screens/categoryScreen/ViewAllCategoriesScreen.dart';
import 'package:online_course_app/screens/chapterScreen/CreateChapterScreen.dart';
import 'package:online_course_app/screens/courseScreen/CourseScreen.dart';
import 'package:online_course_app/screens/courseScreen/CreateCourseScreen.dart';
import 'package:online_course_app/screens/courseScreen/ViewAllCoursesScreen.dart';
import 'package:online_course_app/screens/mainScreen/MainScreen.dart';
import 'package:online_course_app/screens/quizeScreen/CreateQuestionScreen.dart';
import 'package:online_course_app/screens/quizeScreen/CreateQuizeScreen.dart';
import 'package:online_course_app/screens/quizeScreen/QuizeScreen.dart';
import 'package:online_course_app/screens/quizeScreen/QuizeResultScreen.dart';
import 'package:online_course_app/screens/quizeScreen/viewAllQuizesScreen.dart';
import 'package:online_course_app/screens/topicScreen/CreateTopicScreen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case InitialRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
        break;
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
      case CreateCategoryViewScreen:
        return MaterialPageRoute(builder: (_) => CreateCategoryScreen());
        break;
      case CreateCourseViewScreen:
        return MaterialPageRoute(builder: (_) => CreateCourseScreen());
        break;
      case ViewAllQuizesViewScreen:
        return MaterialPageRoute(builder: (_) => ViewAllQuizesScreen());
        break;
      case CreateQuizeViewScreen:
        return MaterialPageRoute(builder: (_) => CreateQuizeScreen());
        break;
      case CreateQuestionViewScreen:
        return MaterialPageRoute(builder: (_) => CreateQuestionScreen());
        break;
      case ViewAllCategoryCoursesViewScreen:
        return MaterialPageRoute(
            builder: (_) => ViewAllCategoryCoursesScreen());
        break;
      case CreateChapterViewScreen:
        return MaterialPageRoute(builder: (_) => CreateChapterScreen());
        break;
      case CreateTopicViewScreen:
        return MaterialPageRoute(builder: (_) => CreateTopicScreen());
        break;
      case ViewAllCategoriesViewScreen:
        return MaterialPageRoute(builder: (_) => ViewAllCategoriesScreen());
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text("No route defined for ${settings.name}"))));
    }
  }
}
