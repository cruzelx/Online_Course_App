import 'dart:io';
import 'package:online_course_app/components/creatingToast.dart';
import 'package:online_course_app/components/showSelectedImageWidget.dart';
import 'package:online_course_app/constants/enums/connectivityStatus.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app/bloc/categoryViewModel.dart';
import 'package:online_course_app/bloc/imagePickerViewModel.dart';
import 'package:online_course_app/components/CreationTitleWidget.dart';
import 'package:online_course_app/models/categoryModel.dart';
import 'package:provider/provider.dart';

class CreateCategoryScreen extends StatefulWidget {
  @override
  _CreateCategoryScreenState createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  final Widget createImage =
      SvgPicture.asset('assets/images/create.svg', width: 260.0);

  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool isCategoryCoverImagePicked = false;
  bool isCategoryIconPicked = false;

  Future uploadData(BuildContext context) async {
    try {
      final categoryNotifier =
          Provider.of<CategoryViewModel>(context, listen: false);

      if (isCategoryCoverImagePicked && isCategoryIconPicked) {
        final uploadCategoryCoverImage =
            await categoryNotifier.uploadCategoryCoverImage();
        final uploadCategoryIcon = await categoryNotifier.uploadCategoryIcon();
        if (uploadCategoryCoverImage is bool && uploadCategoryIcon is bool) {
          return false;
        } else {
          Category newCategory = Category(
              title: _titleController.text,
              description: _descriptionController.text,
              coverImage: uploadCategoryCoverImage,
              icon: uploadCategoryIcon);
          return await categoryNotifier.createCategory(newCategory);
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryNotifier = Provider.of<CategoryViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Column(
              children: <Widget>[
                creationTitleWidget(createImage, 'Category'),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 50.0),
                          TextFormField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                hintText: "Enter Category Title",
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color(0xfff0f0f0),
                              ),
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
                            controller: _descriptionController,
                            maxLength: 400,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: "Enter Category Description",
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Color(0xfff1f1f1),
                            ),
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
                                  final categoryIcon = await categoryNotifier
                                      .selectCategoryIcon();
                                  setState(() {
                                    categoryIcon is bool
                                        ? isCategoryIconPicked = false
                                        : isCategoryIconPicked = true;
                                  });
                                },
                                child: Text("Pick Category Icon")),
                          ),
                          isCategoryIconPicked
                              ? ShowSelectedImage(categoryNotifier.categoryIcon)
                              : Container(),
                          Container(
                            width: double.infinity,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                textColor: Colors.white,
                                color: Color(0xff1000ff),
                                onPressed: () async {
                                  final categoryCoverImage =
                                      await categoryNotifier
                                          .selectCategoryCoverImage();
                                  setState(() {
                                    categoryCoverImage is bool
                                        ? isCategoryCoverImagePicked = false
                                        : isCategoryCoverImagePicked = true;
                                  });
                                },
                                child: Text("Pick Cover Image")),
                          ),
                          isCategoryCoverImagePicked
                              ? ShowSelectedImage(
                                  categoryNotifier.categoryCoverImage)
                              : Container(),
                          SizedBox(height: 30.0),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: RaisedButton(
                                textColor: Colors.white,
                                color: Color(0xff353535),
                                onPressed: () async {
                                  categoryNotifier.setBusy(true);
                                  if (_formKey.currentState.validate() &&
                                      isCategoryCoverImagePicked &&
                                      isCategoryIconPicked) {
                                    creatingToast(
                                        context,
                                        ToastState.LOADING,
                                        Duration(milliseconds: 2000),
                                        'Creating Category');
                                    final res = await uploadData(context);
                                    if (res is bool) {
                                      creatingToast(
                                          context,
                                          ToastState.ERROR,
                                          Duration(milliseconds: 2000),
                                          'Error Creating Category');
                                    } else {
                                      creatingToast(
                                          context,
                                          ToastState.SUCCESSFUL,
                                          Duration(milliseconds: 2000),
                                          'Category Created Successfully');
                                    }
                                    categoryNotifier.setBusy(false);
                                  } else {
                                    creatingToast(
                                        context,
                                        ToastState.ERROR,
                                        Duration(milliseconds: 2000),
                                        'Input Failure');

                                    categoryNotifier.setBusy(false);
                                  }
                                },
                                child: Text("Create")),
                          ),
                        ],
                      ),
                    ))
              ],
            ))),
      ),
    );
  }
}
