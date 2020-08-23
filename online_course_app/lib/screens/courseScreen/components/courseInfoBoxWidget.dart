import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_course_app/components/dateFormatter.dart';
import '';

Widget courseInfoBox(String category, String createdBy, Timestamp createdAt,
    int chaptersLength) {
  final String creationDate = dateFormatter(serverDate: createdAt);
  Widget rowWidget(String parent, String child) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          Text(
            parent,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          SizedBox(width: 20.0),
          Text(child != null ? child : 'N/A')
        ],
      ),
    );
  }

  return Container(
    child: Column(
      children: <Widget>[
        rowWidget('Category:', category),
        rowWidget('Chapters:', chaptersLength.toString()),
        rowWidget('Created At:', creationDate),
        rowWidget('Created By:', createdBy)
      ],
    ),
  );
}
