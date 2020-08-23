import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/categoryViewModel.dart';
import 'package:online_course_app/bloc/courseViewModel.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/components/editCardWidget.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/screens/courseScreen/components/courseCardWidget.dart';
import 'package:provider/provider.dart';

class ViewAllCategoryCoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryNotifier = Provider.of<CategoryViewModel>(context);
    final courseNotifier = Provider.of<CourseViewModel>(context);
    final loginNotifier = Provider.of<LoginViewModel>(context);

    return SafeArea(
        child: Scaffold(
      body: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: CustomScrollView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(height: 20.0),
                Text(
                  "Category Courses",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15.0),
                InkWell(
                  onTap: () {
                    courseNotifier.resetCourse();
                    courseNotifier
                        .setCreatedBy(loginNotifier.currentUser.username);
                    courseNotifier.setCategory(
                        categoryNotifier.currentCategoryId,
                        categoryNotifier.currentCategoryTitle);
                    Navigator.pushNamed(context, CreateCourseViewScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          size: 30.0,
                        ),
                        SizedBox(width: 10.0),
                        Text("Add Course",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
              ])),
              SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    Course course = categoryNotifier.courses[index];
                    int chaptersLength = course.chapters.length;
                    return EditCardWidget(
                      title: course.title,
                      items: chaptersLength == 1
                          ? '$chaptersLength chapter'
                          : '$chaptersLength chapters',
                      onDelete: () async {
                        await categoryNotifier.deleteCourseFromACategory(index);
                      },
                      onEdit: () async {
                        courseNotifier
                            .editCourse(categoryNotifier.courses[index]);
                        // courseNotifier
                        //     .setCreatedBy(loginNotifier.currentUser.username);
                        courseNotifier.setCategory(
                            categoryNotifier.currentCategoryId,
                            categoryNotifier.currentCategoryTitle);
                        Navigator.pushNamed(context, CreateCourseViewScreen);
                      },
                    );
                  }, childCount: categoryNotifier.courses.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2))
            ],
          )),
    ));
  }
}
