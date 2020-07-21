import 'dart:ui';

import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leading: Icon(Icons.arrow_back),
                      floating: true,
                      snap: true,
                      title: Text("Category Title"),
                      expandedHeight: MediaQuery.of(context).size.height * 0.40,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: <Widget>[
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://www.unitednow.com/media/homepage/art.jpg"),
                                      fit: BoxFit.cover)),
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
                                      "Some info about the course.",
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
                  child: ListView.builder(itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Container(
                            height: 150.0,
                            width: double.infinity,
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            height: 50.0,
                                            width: 50.0,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  "https://www.paperstreet.com/blog/wp-content/uploads/2017/07/spaceapegames_img-1-compressor.jpg",
                                                  fit: BoxFit.cover,
                                                ))),
                                        SizedBox(width: 8.0),
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  "Beginner: Introduction To Neural Network",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5.0),
                                              Text(
                                                ".5 Chapters  .12 Videos",
                                                style:
                                                    TextStyle(fontSize: 13.0),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7.0),
                                    Container(
                                      height: 35.0,
                                      child: Text(
                                        "Some info about the course. Some info about the course.",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Divider(),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.play_circle_outline),
                                        SizedBox(width: 8.0),
                                        Text("Start The Course",
                                            style: TextStyle(color:Colors.black87,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ));
                  }),
                )
                // body: GridView.builder(
                //   physics: BouncingScrollPhysics(),
                //   gridDelegate:
                //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                //   itemBuilder: (BuildContext context, int index) {
                //     return new Card(
                //         margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(15.0),
                //         ),
                //         child: Stack(
                //           children: <Widget>[
                //             Container(
                //                 height: double.infinity,
                //                 child: ClipRRect(
                //                     borderRadius: BorderRadius.circular(15.0),
                //                     child: Image.network(
                //                       "https://leverageedu.com/blog/wp-content/uploads/2019/10/BBA-MBA-Integrated-Course.png",
                //                       fit: BoxFit.cover,
                //                     ))),
                //             Container(
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(15.0),
                //                   gradient: LinearGradient(
                //                       begin: Alignment.topCenter,
                //                       end: Alignment.bottomCenter,
                //                       colors: [
                //                         Colors.black.withOpacity(0),
                //                         Colors.black.withOpacity(0.7)
                //                       ])),
                //             ),
                //             Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Column(
                //                   children: <Widget>[
                //                     Expanded(
                //                       child: Center(
                //                         child: Text("Course Title $index",
                //                             style: TextStyle(fontSize: 18.0,
                //                                 color: Colors.white,
                //                                 fontWeight: FontWeight.bold)),
                //                       ),
                //                     ),
                //                     Divider(
                //                       color: Colors.white,
                //                     ),
                //                     Row(
                //                       children: <Widget>[
                //                         Icon(
                //                           Icons.play_circle_outline,
                //                           color: Colors.white,
                //                         ),
                //                         SizedBox(width: 8.0),
                //                         Text("Start The Course",
                //                             style: TextStyle(
                //                                 color: Colors.white,
                //                                 fontWeight: FontWeight.bold))
                //                       ],
                //                     )
                //                   ],
                //                 ))
                //           ],
                //         ));
                //   },
                // ),
                )));
  }
}
