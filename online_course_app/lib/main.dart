import 'package:flutter/material.dart';
import 'package:online_course_app/constants/enums/connectivityStatus.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/screens/CategoryScreens.dart';
import 'package:online_course_app/screens/CourseScreen.dart';
import 'package:online_course_app/screens/CreateCategoryScreen.dart';
import 'package:online_course_app/screens/MainScreen.dart';
import 'package:online_course_app/screens/QuizScreen.dart';
import 'package:online_course_app/screens/LoginScreen.dart';
import 'package:online_course_app/services/connectivityService.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(OnlineCourseApp());
}

class OnlineCourseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
            create: (context) =>
                ConnectivityService().connectionStatusController.stream)
      ],
      child: MaterialApp(
        title: "Online Course App",
        home: HomePage(),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return CreateCategoryScreen();
    return LoginScreen();
    // return MainScreen();
    // return QuizeScreen();
    // return CourseScreen();
    // return CategoryScreen();
  }
}
