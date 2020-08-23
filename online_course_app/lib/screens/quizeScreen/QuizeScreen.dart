import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_course_app/bloc/quizeViewModel.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/screens/quizeScreen/components/quizeOptionButton.dart';
import 'package:online_course_app/screens/quizeScreen/components/quizeQuestionBody.dart';
import 'package:provider/provider.dart';

class QuizeScreen extends StatefulWidget {
  String quizeId;
  QuizeScreen({Key key, this.quizeId}) : super(key: key);
  @override
  _QuizeScreenState createState() => _QuizeScreenState();
}

class _QuizeScreenState extends State<QuizeScreen> {
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final quizeNotifier = Provider.of<QuizeViewModel>(context);
    print(widget.quizeId);
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder<Quize>(
                future: quizeNotifier.fetchQuize(widget.quizeId),
                builder: (context, AsyncSnapshot<Quize> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: SpinKitChasingDots(
                          size: 50.0, color: Colors.deepPurpleAccent),
                    );
                  else if (snapshot.data != null)
                    return PageView.builder(
                        controller: _pageController,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.questions.length,
                        itemBuilder: (context, index) {
                          return QuizeQuestionBody(
                              question: snapshot.data.questions[index],
                              questionIndex: index,
                              pageController: _pageController,
                              totalPages: snapshot.data.questions.length);
                        });
                  else
                    return Center(child: Text("No Data"));
                })));
  }
}
