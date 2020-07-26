import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/constants/enums/connectivityStatus.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/routes/routes.dart';
import 'package:online_course_app/screens/CategoryScreens.dart';
import 'package:online_course_app/screens/CourseScreen.dart';
import 'package:online_course_app/screens/CreateCategoryScreen.dart';
import 'package:online_course_app/screens/CreateCourseScreen.dart';
import 'package:online_course_app/screens/MainScreen.dart';
import 'package:online_course_app/screens/QuizScreen.dart';
import 'package:online_course_app/screens/LoginScreen.dart';
import 'package:online_course_app/screens/errorScreen.dart';
import 'package:online_course_app/services/authService.dart';
import 'package:online_course_app/services/categoryService.dart';
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
                ConnectivityService().connectionStatusController.stream),
        StreamProvider<FirebaseUser>.value(
            value: locator<AuthenticationService>().user),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ],
      child: HoldUp(),
    );
  }
}

class HoldUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Online Course App",
      home: HomePage(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Router.generateRoute,
    );
  }
}

class HomePage extends StatelessWidget {
  final CategoryService _categoryService = CategoryService();
  @override
  Widget build(BuildContext context) {
    FirebaseUser _user = Provider.of<FirebaseUser>(context);
    ConnectivityStatus _status = Provider.of<ConnectivityStatus>(context);
    return _status != ConnectivityStatus.Offline
        ? _user != null ? MainScreen() : LoginScreen()
        : ErrorScreen();

    // return CreateCategoryScreen();
    // return CreateCourseScreen();
    // return LoginScreen();
    // return MainScreen();
    // return QuizeScreen();
    // return CourseScreen();
    // return CategoryScreen();
  }
}
