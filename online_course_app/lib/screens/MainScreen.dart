import 'package:flutter/material.dart';

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
                      "https://scontent.fktm7-1.fna.fbcdn.net/v/t1.0-9/s960x960/61895741_1030831727110119_8215917200502947840_o.jpg?_nc_cat=102&_nc_sid=85a577&_nc_ohc=7IBS5n55dRMAX_hsWJv&_nc_ht=scontent.fktm7-1.fna&_nc_tp=7&oh=ec6c600fef683cef5c3f03fa6684426b&oe=5F1AC22B"),
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
                Text("Categories"),
                SizedBox(height: 10.0),
                Container(
                  height: 130.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {},
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
                  height: 250.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Container(
                                        width: 200,
                                        height: 245.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              height: 122.5,
                                              width: double.infinity,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  20.0)),
                                                  child: Image.network(
                                                      "https://media3.s-nbcnews.com/i/newscms/2019_41/3044956/191009-cooking-vegetables-al-1422_ae181a762406ae9dce02dd0d5453d1ba.jpg",
                                                      fit: BoxFit.cover)),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "Begineer: Introduction To Neural Network",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(Icons.blur_on),
                                                      SizedBox(width: 8.0),
                                                      Text("12 videos"),
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(Icons
                                                          .play_circle_outline),
                                                      SizedBox(width: 8.0),
                                                      Text(
                                                        "Start The Course",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(width: 15.0)
                                ],
                              ),
                            ));
                      }),
                ),
                SizedBox(height: 20.0),
                Text("Hot Topics"),
                SizedBox(height: 10.0),
                Container(
                  height: 250.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                  subtitle: Text(". 2 vids"),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://scontent.fktm7-1.fna.fbcdn.net/v/t1.0-9/s960x960/61895741_1030831727110119_8215917200502947840_o.jpg?_nc_cat=102&_nc_sid=85a577&_nc_ohc=7IBS5n55dRMAX_hsWJv&_nc_ht=scontent.fktm7-1.fna&_nc_tp=7&oh=6d689acff846f8f9575a21cf736e8c88&oe=5F16CDAB"),
                                  ),
                                  title: Text("Hot Topic $index")),
                              Divider(indent: 70.0),
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(height: 20.0),
                Text("Recent Topics"),
                SizedBox(height: 10.0),
                Container(
                  height: 250.0,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                  subtitle: Text(". 2 vids"),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://scontent.fktm7-1.fna.fbcdn.net/v/t1.0-9/s960x960/61895741_1030831727110119_8215917200502947840_o.jpg?_nc_cat=102&_nc_sid=85a577&_nc_ohc=7IBS5n55dRMAX_hsWJv&_nc_ht=scontent.fktm7-1.fna&_nc_tp=7&oh=6d689acff846f8f9575a21cf736e8c88&oe=5F16CDAB"),
                                  ),
                                  title: Text("Recents Topic $index")),
                              Divider(indent: 70.0),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
