import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/bloc/userViewModel.dart';
import 'package:online_course_app/screens/categoryScreen/components/categoryCourseCard.dart';
import 'package:provider/provider.dart';

class CompletedCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (_, loginNotifier, child) {
        return Consumer<UserViewModel>(builder: (_, userNotifier, child) {
          return FutureBuilder(
              future:
                  userNotifier.fetchCompletedCourses(loginNotifier.currentUser),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null)
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return CategoryCourseCard(
                          course: snapshot.data[index],
                          isDisabled: true,
                        );
                      });
                else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SpinKitChasingDots(
                    size: 40.0,
                    color: Colors.deepPurpleAccent,
                  ));
                } else
                  return Center(
                    child: Text("No Data"),
                  );
              });
        });
      },
    );
  }
}
