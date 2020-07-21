import 'package:flutter/material.dart';
import 'package:online_course_app/components/quizeOptionButton.dart';
import 'package:online_course_app/screens/QuizeResultScreen.dart';

class QuizeQuestionBody extends StatefulWidget {
  PageController pageController;
  int totalPages;
  QuizeQuestionBody({Key key, this.pageController, this.totalPages})
      : super(key: key);
  @override
  _QuizeQuestionBodyState createState() => _QuizeQuestionBodyState();
}

class _QuizeQuestionBodyState extends State<QuizeQuestionBody>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: "Question 1/",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0),
                      children: <TextSpan>[
                        TextSpan(
                            text: "10",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14.0))
                      ])),
              SizedBox(height: 25.0),
              Text(
                "What is the distace between the Sun and the Earth ?",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.89),
                    // fontWeight: FontWeight.bold,
                    fontSize: 19.0),
              ),
              SizedBox(height: 40.0),
              QuizeOptionsButtons(),
              SizedBox(height: 22.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
                child:
                    widget.pageController.page.floor() + 1 == widget.totalPages
                        ? RaisedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => QuizeResultScreen()));
                            },
                            child: Text("Finish"),
                            elevation: 20.0,
                            color: Colors.yellowAccent,
                            // highlightColor: Colors.pinkAccent,
                            splashColor: Colors.pinkAccent,
                          )
                        : RaisedButton(
                            onPressed: () {
                              widget.pageController.nextPage(
                                  duration: Duration(milliseconds: 450),
                                  curve: Curves.easeInOut);
                            },
                            child: Text("Next"),
                            elevation: 20.0,
                            color: Colors.yellowAccent,
                            // highlightColor: Colors.pinkAccent,
                            splashColor: Colors.pinkAccent,
                          ),
              )
            ],
          )),
    );
  }
}
