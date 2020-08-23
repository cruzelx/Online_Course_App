import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_course_app/bloc/categoryViewModel.dart';
import 'package:online_course_app/models/categoryModel.dart';
import 'package:online_course_app/screens/categoryScreen/components/categoryCourseCard.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  Category category;
  CategoryScreen({Key key, this.category}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryNotifier = Provider.of<CategoryViewModel>(context);

    return SafeArea(
        child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      floating: true,
                      snap: true,
                      title: Text(widget.category.title),
                      expandedHeight: MediaQuery.of(context).size.height * 0.40,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: <Widget>[
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                  imageUrl: widget.category.coverImage,
                                  fit: BoxFit.cover),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.black.withOpacity(0.15),
                                    Colors.black.withOpacity(0.4)
                                  ])),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 60.0,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      widget.category.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ];
                },
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FutureBuilder(
                    future:
                        categoryNotifier.getCategoryCourses(widget.category.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: SpinKitChasingDots(
                          size: 50.0,
                          color: Colors.deepPurpleAccent,
                        ));
                      } else if (snapshot.hasData && snapshot.data != null)
                      return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return CategoryCourseCard(
                                course: snapshot.data[index],
                              );
                            });

                      
                     else 
                     return Center(
                          child: Text("No Data"));

                      
                        
                    },
                  ),
                ))));
  }
}
