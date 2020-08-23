import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/bloc/userViewModel.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:provider/provider.dart';

class ScoresWidget extends StatefulWidget {
  @override
  _ScoresWidgetState createState() => _ScoresWidgetState();
}

class _ScoresWidgetState extends State<ScoresWidget> {
  bool sort;
  List<Topic> testData = [
    Topic(title: "This is a short title", score: 60),
    Topic(
        title:
            "This is a very very very very long long long long long long long long long long long long long long title title title title",
        score: 61),
    Topic(title: "This is a short title", score: 62),
    Topic(title: "This is a short title", score: 63),
    Topic(title: "This is a short title", score: 64),
    Topic(title: "This is a short title", score: 65),
    Topic(title: "This is a short title", score: 66),
    Topic(title: "This is a short title", score: 67),
    Topic(title: "This is a short title", score: 68),
    Topic(title: "This is a short title", score: 69),
    Topic(title: "This is a short title", score: 70)
  ];

  sortScores(int colIndex, bool ascending) {
    if (ascending) {
      testData.sort((a, b) => a.score.compareTo(b.score));
    } else {
      testData.sort((a, b) => b.score.compareTo(a.score));
    }
  }

  @override
  void initState() {
    sort = true;
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginNotifier = Provider.of<LoginViewModel>(context);
    final userNotifier = Provider.of<UserViewModel>(context);
    final topics = userNotifier.getTopicsScores(loginNotifier.currentUser);
    
    return topics != null
        ? SingleChildScrollView(
            child: DataTable(
                sortAscending: sort,
                sortColumnIndex: 1,
                columns: [
                  DataColumn(
                      label: Text(
                    "Topics",
                    textScaleFactor: 1.5,
                  )),
                  DataColumn(
                      onSort: (colIndex, ascending) {
                        setState(() {
                          sort = !sort;
                        });
                        sortScores(colIndex, ascending);
                      },
                      numeric: true,
                      label: Text(
                        "Scores",
                        textScaleFactor: 1.5,
                      ))
                ],
                rows: topics
                    .map((e) => DataRow(cells: [
                          DataCell(Text(
                            e.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                          DataCell(
                            Text('${(e.score * 100).toStringAsFixed(1)} %'),
                          )
                        ]))
                    .toList()))
        : Center(
            child: Text("No Data"),
          );
  }
}
