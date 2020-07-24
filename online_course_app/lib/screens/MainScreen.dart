import 'package:flutter/material.dart';
import 'package:online_course_app/components/popularCourseCard.dart';
import 'package:online_course_app/screens/CategoryScreens.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final double targetElevation = 5;
  double _elevation = 0;
  ScrollController _scrollController;
  double _categoryCardElevation;

  void _scrollListener() {
    double newElevation = _scrollController.offset > 1 ? targetElevation : 0;
    if (_elevation != newElevation) {
      setState(() {
        _elevation = newElevation;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryCardElevation = 2;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: _elevation,
          centerTitle: true,
          title: Text("HOME",
              style: TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.bold)),
          actions: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Container(
                width: 40.0,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      "https://pbs.twimg.com/profile_images/1222654825403424768/-ySQePLc.jpg"),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 25.0),
                Container(
                  height: 45.0,
                  child: TextField(
                      onTap: () {},
                      style: TextStyle(fontSize: 16.0),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                              icon: Icon(Icons.mic), onPressed: () {}),
                          hintMaxLines: 1,
                          isDense: true,
                          filled: true,
                          fillColor: Color(0xfff2f2f2),
                          hintText: "Search Courses",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide.none))),
                ),
                SizedBox(height: 25.0),
                Text("Categories",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                Container(
                  height: 130.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoryScreen()));
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "https://i.pinimg.com/originals/4c/e0/97/4ce097ee23e86b210bc036a55111c6ae.png"),
                                              radius: 30.0,
                                            ),
                                            SizedBox(height: 15.0),
                                            Text("Category $index")
                                          ],
                                        ))),
                                  ),
                                  SizedBox(width: 10.0)
                                ],
                              ),
                            ));
                      }),
                ),
                SizedBox(height: 20.0),
                Text("Popular Courses",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                Container(
                  height: 280.0,
                  child: ListView.separated(
                      itemCount: 10,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 20.0);
                      },
                      itemBuilder: (context, index) {
                        return PopularCourseCard();
                        // GestureDetector(
                        //     onTap: () {},
                        //     child: Container(
                        //       child: Row(
                        //         children: <Widget>[
                        //           Card(
                        //             shape: RoundedRectangleBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(20.0)),
                        //             child: Container(
                        //                 width: 200,
                        //                 height: 260.0,
                        //                 decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(20.0)),
                        //                 child: Column(
                        //                   children: <Widget>[
                        //                     Container(
                        //                       height: 125,
                        //                       width: double.infinity,
                        //                       child: ClipRRect(
                        //                           borderRadius:
                        //                               BorderRadius.only(
                        //                                   topLeft:
                        //                                       Radius.circular(
                        //                                           20.0),
                        //                                   topRight:
                        //                                       Radius.circular(
                        //                                           20.0)),
                        //                           child: Image.network(
                        //                               "https://static.sustainability.asu.edu/giosMS-uploads/sites/15/2019/05/teaching-resources-1024x575.jpg",
                        //                               fit: BoxFit.cover)),
                        //                       decoration: BoxDecoration(
                        //                           color: Colors.blue,
                        //                           borderRadius:
                        //                               BorderRadius.circular(
                        //                                   20.0)),
                        //                     ),
                        //                     Padding(
                        //                       padding: EdgeInsets.all(8.0),
                        //                       child: Column(
                        //                         crossAxisAlignment:
                        //                             CrossAxisAlignment.start,
                        //                         mainAxisAlignment:
                        //                             MainAxisAlignment
                        //                                 .spaceBetween,
                        //                         children: <Widget>[
                        //                           Text(
                        //                             "Begineer: Introduction To Neural Network",
                        //                             style: TextStyle(
                        //                                 fontWeight:
                        //                                     FontWeight.bold),
                        //                             overflow:
                        //                                 TextOverflow.ellipsis,
                        //                             maxLines: 2,
                        //                           ),
                        //                           // SizedBox(height: 5.0),
                        //                           Row(
                        //                             children: <Widget>[
                        //                               Icon(Icons.blur_on),
                        //                               SizedBox(width: 8.0),
                        //                               Text("12 videos"),
                        //                             ],
                        //                           ),

                        //                           Divider(),
                        //                           Row(
                        //                             children: <Widget>[
                        //                               Icon(Icons
                        //                                   .play_circle_outline),
                        //                               SizedBox(width: 8.0),
                        //                               Text(
                        //                                 "Start The Course",
                        //                                 style: TextStyle(
                        //                                     fontWeight:
                        //                                         FontWeight
                        //                                             .bold),
                        //                               )
                        //                             ],
                        //                           )
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 )),
                        //           ),
                        //           SizedBox(width: 15.0)
                        //         ],
                        //       ),
                        //     ));
                      }),
                ),
                SizedBox(height: 20.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
