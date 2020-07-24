import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app/screens/CourseScreen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuizeResultScreen extends StatefulWidget {
  @override
  _QuizeResultScreenState createState() => _QuizeResultScreenState();
}

class _QuizeResultScreenState extends State<QuizeResultScreen> {
  Future<bool> _willPopScope() async {
    return false;
  }

  final Widget rocketImage =
      SvgPicture.asset('assets/images/rocket.svg', width: 100.0);
  final double progress = 65.0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopScope,
      child: SafeArea(
          child: Scaffold(
              body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Quize Results",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              "Congratulations Alex!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            CircularPercentIndicator(
              radius: 175.0,
              lineWidth: 8.0,
              animation: true,
              animationDuration: 400,
              percent: progress / 100.0,
              center: rocketImage,
              circularStrokeCap: CircularStrokeCap.round,
              footer: Text("$progress %",
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseScreen()));
                  },
                  child: Text("Okay!"),
                  color: Colors.pinkAccent,
                  textColor: Colors.white,
                )),
          ],
        ),
      ))),
    );
  }
}
