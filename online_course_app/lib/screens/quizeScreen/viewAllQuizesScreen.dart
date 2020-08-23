import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/quizeViewModel.dart';
import 'package:online_course_app/components/editCardWidget.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/screens/quizeScreen/components/quizeCardWidget.dart';
import 'package:provider/provider.dart';

class ViewAllQuizesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizenotifier = Provider.of<QuizeViewModel>(context);
    print(quizenotifier.quizes);
    return SafeArea(
      child: Scaffold(
          body: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        child: CustomScrollView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 20.0),
              Text(
                "All Quizes",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.0),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CreateQuizeViewScreen);
                  quizenotifier.resetQuize();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        size: 30.0,
                      ),
                      SizedBox(width: 10.0),
                      Text("Add Quize",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.0),
            ])),
            SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  Quize quize = quizenotifier.quizes[index];
                  int questionsLength = quize.questions.length;
                  return EditCardWidget(
                    title: quize.title,
                    items:questionsLength == 1 ?'$questionsLength question':'$questionsLength questions',
                    onDelete: () async =>
                        await quizenotifier.deleteQuize(index),
                    onEdit: () {
                      quizenotifier.editQuize(quizenotifier.quizes[index]);
                      Navigator.pushNamed(context, CreateQuizeViewScreen);
                    },
                  );
                }, childCount: quizenotifier.quizes.length))
          ],
        ),
      )),
    );
  }
}
