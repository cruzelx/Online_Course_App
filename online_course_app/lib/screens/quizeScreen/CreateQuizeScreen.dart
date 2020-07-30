import 'package:flutter/material.dart';

class CreateQuizeScreen extends StatefulWidget {
  @override
  _CreateQuizeScreenState createState() => _CreateQuizeScreenState();
}

class _CreateQuizeScreenState extends State<CreateQuizeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Create Quize",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter Quize Title",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xfff0f0f0),
                ),
                onChanged: (String value) {},
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Question field cannot be empty';
                  } else if (value.length > 200) {
                    return 'Question length must be less than 200 chars';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 30.0),
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 30.0,
                    ),
                    SizedBox(width: 10.0),
                    Text("Add Question",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0))
                  ],
                ),
              ),
              SizedBox(),
              ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("question"),
                      subtitle: Column(
                        children: <Widget>[Text("option")],
                      ),
                    );
                  })
            ],
          ),
        )),
      ),
    );
  }
}
