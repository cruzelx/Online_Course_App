import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app/components/CreationTitleWidget.dart';

class CreateCategoryScreen extends StatefulWidget {
  @override
  _CreateCategoryScreenState createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  final Widget createImage =
      SvgPicture.asset('assets/images/create.svg', width: 260.0);

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
                creationTitleWidget(createImage, 'Category'),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50.0),
                        TextFormField(
                          maxLength: 100,
                          decoration: InputDecoration(
                            hintText: "Enter Category Title",
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
                            hintText: "Enter Category Description",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xfff1f1f1),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              textColor: Colors.white,
                              color: Color(0xff121212),
                              onPressed: () {},
                              child: Text("Pick Category Icon")),
                        ),
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
            ))),
      ),
    );
  }
}
