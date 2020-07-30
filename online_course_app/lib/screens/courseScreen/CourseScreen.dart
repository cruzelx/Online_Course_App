import 'package:flutter/material.dart';
import 'package:online_course_app/components/drawer.dart';
import 'package:online_course_app/components/youtubeVideoPlayer.dart';
import 'package:online_course_app/screens/quizeScreen/QuizeScreen.dart';

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _drawerAnimationController;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _drawerAnimationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
        reverseDuration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _drawerAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // if (!_scaffoldKey.currentState.isDrawerOpen) {
            //   _drawerAnimationController.forward();
            //   _scaffoldKey.currentState.openDrawer();
            // } else {
            //   _drawerAnimationController.reverse();
            //   Navigator.pop(context);
            // }
            _scaffoldKey.currentState.openDrawer();
          },
          child: Icon(Icons.menu),
          // AnimatedIcon(
          //     icon: AnimatedIcons.menu_close,
          //     progress: _drawerAnimationController),
          backgroundColor: Colors.redAccent,
        ),
        drawer: Drawer(
          child: CourseDrawer(),
        ),
        body: Column(
          children: <Widget>[
            YoutubeVideoPlayer(),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => QuizeScreen()));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: Colors.green,
              splashColor: Colors.pinkAccent,
              hoverElevation: 10.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Center(
                    child: Text(
                  "Take a quiz",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
