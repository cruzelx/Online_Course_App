import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app/components/CreationTitleWidget.dart';

class CreateCourseScreen extends StatefulWidget {
  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final Widget createImage =
      SvgPicture.asset('assets/images/create.svg', width: 260.0);

  List<String> categories = ["Humanities", "Arts", "Science"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              creationTitleWidget(createImage, 'Course'),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50.0),
                      TextFormField(
                        maxLength: 100,
                        decoration: InputDecoration(
                          hintText: "Enter Course Title",
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xfff0f0f0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        maxLength: 400,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Enter Course Description",
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xfff1f1f1),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff404040),
                                  borderRadius: BorderRadius.circular(100.0)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              child: Text(
                                "Category",
                                style: TextStyle(color: Colors.white),
                              )),
                          Spacer(),
                          DropdownButton(
                              underline: Container(
                                height: 2.0,
                                color: Colors.black87,
                              ),
                              items: categories
                                  .map((e) => DropdownMenuItem(
                                      child: Text(e.toString())))
                                  .toList(),
                              onChanged: (val) {}),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            textColor: Colors.white,
                            color: Color(0xff1000ff),
                            onPressed: () {},
                            child: Text("Pick Cover Image")),
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: RaisedButton(
                            textColor: Colors.white,
                            color: Color(0xff353535),
                            onPressed: () {},
                            child: Text("Create")),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
