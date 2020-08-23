import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/main.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/screens/authScreen/LoginScreen.dart';
import 'package:online_course_app/screens/profileScreen/componenets/completedCoursesWidget.dart';
import 'package:online_course_app/screens/profileScreen/componenets/ongoingCoursesWidget.dart';
import 'package:online_course_app/screens/profileScreen/componenets/scoresWidget.dart';
import 'package:online_course_app/services/authService.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  User user;
  ProfileScreen({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loginNotifier = Provider.of<LoginViewModel>(context);
    AuthenticationService _authService = locator<AuthenticationService>();
    return SafeArea(
        child: Scaffold(
      body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    actions: [
                      PopupMenuButton(
                        onSelected: (a) async {
                          print("loggin out");
                          loginNotifier.logout();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => LoginScreen()));
                        },
                        itemBuilder: (_) {
                          return [
                            PopupMenuItem(
                                value: 'log out', child: Text("Sign out"))
                          ];
                        },
                      ),
                    ],
                    expandedHeight: MediaQuery.of(context).size.height * 0.45,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                              Color(0xffff6086),
                              Color(0xffff2b62)
                            ])),
                        child: Column(
                          children: [
                            SizedBox(height: 30.0),
                            Hero(
                              tag: 'userImage',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: CachedNetworkImage(imageUrl: user.dp),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              user.username,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.8)),
                            ),
                            SizedBox(height: 10.0),
                            user.isAdmin
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FlatButton(
                                          padding: EdgeInsets.all(3.0),
                                          color: Colors.black38,
                                          textColor:
                                              Colors.white.withOpacity(0.7),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                ViewAllCategoriesViewScreen);
                                          },
                                          child: Text("Category")),
                                      SizedBox(width: 20.0),
                                      FlatButton(
                                          padding: EdgeInsets.all(3.0),
                                          color: Colors.black38,
                                          textColor:
                                              Colors.white.withOpacity(0.7),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                ViewAllQuizesViewScreen);
                                          },
                                          child: Text("Quize")),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    elevation: 10.0,
                    bottom: TabBar(tabs: [
                      Tab(text: "Ongoing"),
                      Tab(
                        text: "Completed",
                      ),
                      Tab(
                        text: "Scores",
                      ),
                    ]),
                  )
                ];
              },
              body: Padding(
                padding: EdgeInsets.all(10.0),
                child: TabBarView(children: [
                  OngoingCourses(),
                  CompletedCourses(),
                  ScoresWidget(),
                ]),
              ))),
    ));
  }
}
