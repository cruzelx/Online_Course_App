import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/CreateQuizeQuestion.dart';
import 'package:online_course_app/bloc/categoryViewModel.dart';
import 'package:online_course_app/bloc/imagePickerViewModel.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/bloc/quizeViewModel.dart';
import 'package:online_course_app/constants/enums/connectivityStatus.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/routes/routes.dart';

import 'package:online_course_app/screens/categoryScreen/CreateCategoryScreen.dart';
import 'package:online_course_app/screens/quizeScreen/CreateQuestionScreen.dart';
import 'package:online_course_app/screens/quizeScreen/CreateQuizeScreen.dart';
import 'package:online_course_app/screens/quizeScreen/viewAllQuizesScreen.dart';
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
        ChangeNotifierProvider(create: (context) => ImagePickerViewModel()),
        ChangeNotifierProvider(create: (context) => CategoryViewModel()),
        ChangeNotifierProvider(create: (context) => QuizeViewModel()),
        ChangeNotifierProvider(
            create: (context) => CreateQuizeQuestionViewModel()),
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
      initialRoute: InitialRoute,
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
    // return _status != ConnectivityStatus.Offline
    //     ? _user != null ? MainScreen() : LoginScreen()
    //     : ErrorScreen();

    // return CreateCategoryScreen();
    // return CreateCourseScreen();
    // return LoginScreen();
    // return MainScreen();
    // return QuizeScreen();
    // return CourseScreen();
    // return CategoryScreen();
    // return CreateQuestionScreen();
    // return CreateQuizeScreen();
    return ViewAllQuizesScreen();
  }
}
