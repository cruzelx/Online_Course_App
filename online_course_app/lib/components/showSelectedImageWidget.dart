import 'dart:io';

import 'package:flutter/material.dart';

class ShowSelectedImage extends StatelessWidget {
  final File imageFile;
  ShowSelectedImage(this.imageFile);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover),
      ),
    );
  }
}
