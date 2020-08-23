import 'package:flutter/cupertino.dart';

Widget descriptionBox(String title, String description) {
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          maxLines: 2,
        ),
        SizedBox(height: 10.0),
        Text(description),
      ],
    ),
  );
}
