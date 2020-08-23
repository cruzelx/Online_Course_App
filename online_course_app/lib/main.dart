import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:online_course_app/components/dialogManager.dart';
import 'package:online_course_app/constants/enums/connectivityStatus.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/routes/routes.dart';
import 'package:online_course_app/screens/authScreen/LoginScreen.dart';

import 'package:online_course_app/screens/categoryScreen/CreateCategoryScreen.dart';
import 'package:online_course_app/screens/categoryScreen/ViewAllCategoriesScreen.dart';
import 'package:online_course_app/screens/mainScreen/MainScreen.dart';
import 'package:online_course_app/screens/mainScreen/wrapper.dart';
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
        StreamProvider<NetworkStatus>(
            create: (context) =>
                ConnectivityService().networkStatusController.stream),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),

        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => ImagePickerViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => QuizeViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => CourseViewModel()),
        ChangeNotifierProvider(create: (_) => ChapterViewModel()),
        ChangeNotifierProvider(create: (_) => TopicViewModel()),
        ChangeNotifierProvider(create: (_) => QuestionViewModel()),
        ChangeNotifierProvider(create: (_) => StudyScreenStateViewModel())
        // StreamProvider<User>(
        //     create: (_) => locator<AuthenticationService>().onAuthStateChange),
        // ChangeNotifierProvider(create: (_) => LoginViewModel()),
        // ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: HoldUp(),
    );
  }
}

class HoldUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(
                  child: widget,
                )),
      ),
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NetworkStatus _status = Provider.of<NetworkStatus>(context);

    // AuthenticationService _authService = locator<AuthenticationService>();
    final loginNotifier = Provider.of<LoginViewModel>(context);

    return loginNotifier.isLoading
        ? Scaffold(
            body: Center(
                child: SpinKitChasingDots(
                    size: 50.0, color: Colors.deepPurpleAccent)))
        : loginNotifier.currentUser == null ? LoginScreen() : MainScreen();

    // return StreamBuilder<User>(
    //     stream: _authService.onAuthStateChange,
    //     builder: (_, AsyncSnapshot<User> snapshot) {
    //       print(snapshot.connectionState);
    //       print(snapshot.data);
    //       if (snapshot.connectionState == ConnectionState.active)
    //         return snapshot.data != null ? MainScreenWrapper() : LoginScreen();
    //       else
    //         return Scaffold(
    //           body: Center(
    //             child: SpinKitChasingDots(
    //               size: 50.0,
    //               color: Colors.deepPurpleAccent,
    //             ),
    //           ),
    //         );
    //     });

    // loginNotifier.isLoading
    //     ? Scaffold(
    //         body: Center(
    //             child: Scaffold(
    //                 body: Center(
    //                     child: SpinKitChasingDots(
    //           size: 50.0,
    //           color: Colors.deepPurpleAccent,
    //         )))),
    //       )
    //     : loginNotifier.currentUser == null ? LoginScreen() : MainScreen();

    // return CreateCategoryScreen();
    // return CreateCourseScreen();
    // return LoginScreen();
    // return MainScreen();
    // return QuizeScreen();
    // return CourseScreen();
    // return CategoryScreen();
    // return CreateQuestionScreen();
    // return CreateQuizeScreen();
    // return ViewAllQuizesScreen();
    // return ViewAllCategoriesScreen();
  }
}
