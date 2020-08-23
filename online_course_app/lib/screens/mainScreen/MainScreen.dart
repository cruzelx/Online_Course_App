import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/categoryViewModel.dart';
import 'package:online_course_app/bloc/courseViewModel.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/bloc/studyScreenStateViewModel.dart';
import 'package:online_course_app/bloc/userViewModel.dart';
import 'package:online_course_app/screens/categoryScreen/CategoryScreens.dart';
import 'package:online_course_app/screens/mainScreen/components/categoryCardWidget.dart';
import 'package:online_course_app/screens/mainScreen/components/popularCourseCard.dart';
import 'package:online_course_app/screens/profileScreen/profileScreen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final double targetElevation = 5;
  double _elevation = 0;
  ScrollController _scrollController;
  double _categoryCardElevation;

  void _scrollListener() {
    double newElevation = _scrollController.offset > 1 ? targetElevation : 0;
    if (_elevation != newElevation) {
      setState(() {
        _elevation = newElevation;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryCardElevation = 2;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginNotifier = Provider.of<LoginViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(),
          appBar: AppBar(
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: _elevation,
            centerTitle: true,
            title: Text("HOME",
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: InkWell(
                  onTap: () {
                    print(loginNotifier.currentUser.username);
                    // loginNotifier.logout();

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                              value: loginNotifier,
                              child: ProfileScreen(
                                user: loginNotifier.currentUser,
                              ),
                            )));
                    // await loginNotifier.logout();
                  },
                  child: Hero(
                    tag: 'userImage',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: CachedNetworkImage(
                          imageUrl: loginNotifier.currentUser.dp),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 25.0),
                  Container(
                    height: 45.0,
                    child: TextField(
                        onTap: () {},
                        style: TextStyle(fontSize: 16.0),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.mic), onPressed: () {}),
                            hintMaxLines: 1,
                            isDense: true,
                            filled: true,
                            fillColor: Color(0xfff2f2f2),
                            hintText: "Search Courses",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: BorderSide.none))),
                  ),
                  SizedBox(height: 25.0),
                  Text("Categories",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  SizedBox(
                    height: 130.0,
                    child: Consumer<CategoryViewModel>(
                      builder: (contex, categoryNotifier, child) {
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: categoryNotifier.categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCardWidget(
                                  category: categoryNotifier.categories[index]);
                            });
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text("Recent Courses",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  SizedBox(
                    height: 290.0,
                    child: Consumer<CourseViewModel>(
                      builder: (context, courseNotifier, child) {
                        return ListView.separated(
                            itemCount: courseNotifier.courses.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            // physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 8.0);
                            },
                            itemBuilder: (context, index) {
                              return PopularCourseCard(
                                course: courseNotifier.courses[index],
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
