import 'package:online_course_app/components/progressDialogManager.dart';
import 'package:online_course_app/components/showSelectedImageWidget.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:flutter/material.dart';
import 'package:online_course_app/bloc/categoryViewModel.dart';
import 'package:online_course_app/models/categoryModel.dart';
import 'package:provider/provider.dart';

class CreateCategoryScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final categoryNotifier = Provider.of<CategoryViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  categoryNotifier.isCategoryEditing
                      ? "Edit Category"
                      : "Create Category",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                categoryNotifier.isCategoryEditing
                    ? InkWell(
                        onTap: () {
                          categoryNotifier.getAllCoursesFromACategory();
                          Navigator.pushNamed(
                              context, ViewAllCategoryCoursesViewScreen);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.local_library,
                                size: 20.0,
                              ),
                              SizedBox(width: 10.0),
                              Text("View Courses",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0)),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(height: 20.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          textCapitalization: TextCapitalization.words,
                          // controller: _titleController,
                          initialValue: categoryNotifier.title,
                          decoration: InputDecoration(
                            hintText: "Enter Category Title",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Color(0xfff0f0f0),
                          ),
                          onChanged: (String value) {
                            categoryNotifier.setTitle(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Category Title must not be empty";
                            } else if (value.length > 200) {
                              return "Category Title length mustbe less than 200";
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(height: 20.0),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        // controller: _descriptionController,
                        initialValue: categoryNotifier.description,
                        maxLength: 400,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Enter Category Description",
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xfff1f1f1),
                        ),
                        onChanged: (String value) {
                          categoryNotifier.setDescription(value);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Category Description must not be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            textColor: Colors.white,
                            color: Color(0xff121212),
                            onPressed: () async {
                              final categoryIcon =
                                  await categoryNotifier.selectCategoryIcon();
                            },
                            child: Text("Pick Category Icon")),
                      ),
                      categoryNotifier.categoryIcon != null
                          ? ShowSelectedImage(
                              imageFile: categoryNotifier.categoryIcon,
                            )
                          : categoryNotifier.categoryIconUrl != null
                              ? ShowSelectedImage(
                                  imageUrl: categoryNotifier.categoryIconUrl)
                              : Container(),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            textColor: Colors.white,
                            color: Color(0xff1000ff),
                            onPressed: () async {
                              final categoryCoverImage = await categoryNotifier
                                  .selectCategoryCoverImage();
                            },
                            child: Text("Pick Cover Image")),
                      ),
                      categoryNotifier.categoryCoverImage != null
                          ? ShowSelectedImage(
                              imageFile: categoryNotifier.categoryCoverImage,
                            )
                          : categoryNotifier.categoryCoverImageUrl != null
                              ? ShowSelectedImage(
                                  imageUrl:
                                      categoryNotifier.categoryCoverImageUrl)
                              : Container(),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                      textColor: Colors.white,
                      color: Color(0xff353535),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final ProgressDialogHandler pdh =
                              ProgressDialogHandler(
                                  context: context,
                                  message: categoryNotifier.isCategoryEditing
                                      ? 'Updating Category...'
                                      : 'Creating Category...');
                          await pdh.showProgressDialog();
                          final res = await categoryNotifier.uploadCategory();
                          await pdh.hideProgressDialog();
                          if (res is bool) {
                          } else {
                            Navigator.pop(context);
                            // categoryNotifier.resetCategory();
                          }
                        }
                      },
                      child: categoryNotifier.isCategoryEditing
                          ? Text("Update")
                          : Text("Create")),
                ),
              ],
            )),
      ),
    );
  }
}
