import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/models/categoryModel.dart';
import 'package:online_course_app/screens/categoryScreen/CategoryScreens.dart';

class CategoryCardWidget extends StatelessWidget {
  Category category;
  CategoryCardWidget({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategoryScreen(category: category)));
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Card(
                elevation: 2.0,
                child: Container(
                    width: 100.0,
                    height: 120.0,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: CachedNetworkImage(
                            imageUrl: category.icon,
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Text(category.title)
                      ],
                    ))),
              ),
              SizedBox(width: 10.0)
            ],
          ),
        ));
  }
}
