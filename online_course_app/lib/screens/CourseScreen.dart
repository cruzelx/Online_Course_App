import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  ScrollController _scrollController;
  double _desCardPosition;

  void _descriptionCardPosition() {
    print(_scrollController.offset);
    setState(() {
      if (_scrollController.offset >=
          MediaQuery.of(context).size.height * 0.4-100.0) {
        _desCardPosition = 0.0;
      }
      // else if(_scrollController.offset <0){
      //   _desCardPosition = MediaQuery.of(context).size.height*0.35;

      // }
      else {
        _desCardPosition = -_scrollController.offset +
            MediaQuery.of(context).size.height * 0.4-100.0;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _desCardPosition = MediaQuery.of(context).size.height*0.35;
    _scrollController = ScrollController();
    _scrollController.addListener(_descriptionCardPosition);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController?.removeListener(_descriptionCardPosition);
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: <Widget>[
          NestedScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            headerSliverBuilder: (context, isScrolled) {
              return <Widget>[
                SliverAppBar(
                  floating: true,
                  title: Text("Course"),
                  expandedHeight: MediaQuery.of(context).size.height*0.4,
                  centerTitle: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/close-up-of-tulips-blooming-in-field-royalty-free-image-1584131603.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: ListView.builder(itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://scontent.fktm7-1.fna.fbcdn.net/v/t1.0-9/s960x960/61895741_1030831727110119_8215917200502947840_o.jpg?_nc_cat=102&_nc_sid=85a577&_nc_ohc=7IBS5n55dRMAX_hsWJv&_nc_ht=scontent.fktm7-1.fna&_nc_tp=7&oh=ec6c600fef683cef5c3f03fa6684426b&oe=5F1AC22B"),
                          ),
                          title: Text("Course Topics $index"),
                          subtitle: Text(". 2 vids")),
                      Divider(
                        indent: 70.0,
                      ),
                    ],
                  );
                })),
          ),
          Positioned(
            top: _desCardPosition,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.995,
              height: 200.0,
              child: Card(
                  elevation: 2.0,
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text("Course Description"),
                          Divider(),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              child: Text(
                                  "jskjfs kjsfhjskd fjksdfhskjd fjskdfhksjd fsjdkf sdkjf ksdjf hkjsd fjksd fjksdh fjksdhfjksdh fkjsdhfkjsd fhksdjh fsjkdfh ksjdf hksjdfhksjdfh ksjd fsjkdfhsdjkf sdkjfhsjkdf sjdkf sdkjfhs fjsjkdf hsdkjf hskjdf sdkjf sdkjfh ksjdfhskjdf sdjfhksdjfhksjdf skjdfhskjdf sdkjfhskdjfh sdfjhskdf skjdfhskdfhskjdf ksjdhfkj sdfkjsdfhkjsdf ksjdfhsjkdf skjdfhkjsdfhkjsdfh skjdf skjdfhlakshflkasjfhksj dfksjdhfaskjdhfklajsdhf sfdskjd fkajhdjkahfjkafh dsfjsdkjfhsdkjf sdjkfhsdfj jkdfghkjdfhgdfkjghdfkjgdfjkghdfkjghdkjfhgdkjfghkdfjghkjdghdkfjg"),
                            ),
                          ),
                        ],
                      ))),
            ),
          ),
        ]),
      ),
    );
  }
}
