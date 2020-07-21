import 'package:flutter/material.dart';
import 'package:online_course_app/components/quizeOptionButton.dart';
import 'package:online_course_app/components/quizeQuestionBody.dart';

class QuizeScreen extends StatefulWidget {
  @override
  _QuizeScreenState createState() => _QuizeScreenState();
}

class _QuizeScreenState extends State<QuizeScreen> {
  PageController _pageController = PageController();
  var currentPageNumber = 0.0;

  int totalPages = 5;

  @override
  void initState() {
    // TODO: implement initState

    _pageController.addListener(() {
      setState(() {
        currentPageNumber = _pageController.page;
        print(currentPageNumber);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _pageController.removeListener(() { });
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xff121212),
            body: PageView.builder(
                controller: _pageController,
                physics: BouncingScrollPhysics(),
                itemCount: totalPages,
                itemBuilder: (context, index) {
                  return QuizeQuestionBody(
                    pageController: _pageController,
                    totalPages: totalPages,
                  );
                })));
  }
}
