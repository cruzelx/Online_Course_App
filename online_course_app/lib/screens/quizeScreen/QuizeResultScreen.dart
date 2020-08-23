import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app/bloc/userViewModel.dart';
import 'package:online_course_app/screens/courseScreen/CourseScreen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class QuizeResultScreen extends StatefulWidget {
  @override
  _QuizeResultScreenState createState() => _QuizeResultScreenState();
}

class _QuizeResultScreenState extends State<QuizeResultScreen> {
  final Widget rocketImage =
      SvgPicture.asset('assets/images/rocket.svg', width: 100.0);

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserViewModel>(context);
    final double progress = userNotifier.currentTopicScore;
    print(progress);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: SafeArea(
          child: Scaffold(
              body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Quize Results",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Congratulations !",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  userNotifier.currentUser.username,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ],
            ),
            CircularPercentIndicator(
              radius: 175.0,
              lineWidth: 8.0,
              animation: true,
              animationDuration: 800,
              percent: progress,
              center: rocketImage,
              circularStrokeCap: CircularStrokeCap.round,
              footer: Text("${(progress * 100).toStringAsFixed(1)} %",
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
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
