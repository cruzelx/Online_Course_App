import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/categoryViewModel.dart';
import 'package:online_course_app/bloc/loginViewModel.dart';
import 'package:online_course_app/components/editCardWidget.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:online_course_app/models/categoryModel.dart';
import 'package:online_course_app/screens/categoryScreen/components/CategoryCardWidget.dart';
import 'package:provider/provider.dart';

class ViewAllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryNotifier = Provider.of<CategoryViewModel>(context);
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
                  "All Categories",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15.0),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, CreateCategoryViewScreen);
                    categoryNotifier.resetCategory();
                    categoryNotifier
                        .setCreatedBy(loginNotifier.currentUser.username);
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
                        Text("Add Category",
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
                    Category category = categoryNotifier.categories[index];
                    int coursesLength = category.courses.length;
                    return EditCardWidget(
                      title: category.title,
                      items: coursesLength == 1
                          ? '$coursesLength course'
                          : '$coursesLength courses',
                      onDelete: () async =>
                          await categoryNotifier.deleteCategory(index),
                      onEdit: () async {
                        await categoryNotifier
                            .editCategory(categoryNotifier.categories[index]);
                        // categoryNotifier
                        //     .setCreatedBy(loginNotifier.currentUser.username);
                        Navigator.pushNamed(context, CreateCategoryViewScreen);
                      },
                    );
                  }, childCount: categoryNotifier.categories.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2))
            ],
          )),
    ));
  }
}
