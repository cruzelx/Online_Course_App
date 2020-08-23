import 'dart:io';
import 'package:flutter/material.dart';

class ShowSelectedImage extends StatelessWidget {
  final File imageFile;
  final String imageUrl;
  ShowSelectedImage({this.imageFile, this.imageUrl})
      : assert(imageFile != null || imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 200.0,
      width: 200.0,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: imageUrl != null
              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/images/imagePlaceholder.png',
                  image: imageUrl,
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                )
              : FadeInImage(
                  placeholder: AssetImage('assets/images/imagePlaceholder.png'),
                  image: FileImage(imageFile),
                )),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // image: DecorationImage(
        //     image: imageUrl != null
        //         ? NetworkImage(imageUrl)
        //         : FileImage(imageFile),
        //     fit: BoxFit.cover),
      ),
    );
  }
}
