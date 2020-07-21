import 'package:flutter/material.dart';

class CourseDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://answerswithjoe.com/wp-content/uploads/2019/01/science.png"),
          ),
          title: Text(
            "Course Title",
            textScaleFactor: 1.3,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(".5 chapters .12 vids"),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                ExpansionTile(
                  title: Text(
                    "Chapter 1: Newton's Laws",
                    textScaleFactor: 1.1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  children: <Widget>[
                    ListTile(leading: Icon(Icons.ondemand_video)),
                    ListTile(leading: Icon(Icons.ondemand_video)),
                    ListTile(leading: Icon(Icons.ondemand_video)),
                    ListTile(leading: Icon(Icons.ondemand_video)),
                    ListTile(leading: Icon(Icons.ondemand_video)),
                    ListTile(leading: Icon(Icons.ondemand_video)),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "Chapter 2: Faraday's Laws",
                    textScaleFactor: 1.1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  children: <Widget>[
                    ListTile(leading: Icon(Icons.ondemand_video)),
                  ],
                ),
              ],
            ),
          ),
        )
        // Expanded(
        //     child: ListView(
        //   children: <Widget>[
        //     ExpansionPanelList(
        //       children: <ExpansionPanel>[
        //         ExpansionPanel(
        //             headerBuilder: (context, isExpanded) {
        //               return Text("header");
        //             },
        //             body: Container(child: Text("child")),
        //             isExpanded: true,
        //             canTapOnHeader: true)
        //       ],
        //       animationDuration: Duration(milliseconds: 400),
        //     )
        //   ],
        // ))
      ],
    );
  }
}
