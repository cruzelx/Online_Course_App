import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course_app/bloc/categoryViewModel.dart';
import 'package:online_course_app/bloc/chapterViewModel.dart';
import 'package:online_course_app/bloc/courseViewModel.dart';
import 'package:online_course_app/components/ListViewDataWidget.dart';
import 'package:online_course_app/components/progressDialogManager.dart';
import 'package:online_course_app/components/showSelectedImageWidget.dart';
import 'package:online_course_app/constants/routesName.dart';
import 'package:provider/provider.dart';

class CreateCourseScreen extends StatefulWidget {
  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  List<String> categories = [];
  @override
  Widget build(BuildContext context) {
    List<String> categories = [];
    final categoryNotifier = Provider.of<CategoryViewModel>(context);
    for (var cat in categoryNotifier.categories) {
      categories.add(cat.title);
    }
    final courseNotifier = Provider.of<CourseViewModel>(context);
    final chapterNotifier = Provider.of<ChapterViewModel>(context);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                courseNotifier.isCourseEditing
                    ? "Edit Course"
                    : "Create Course",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                        textCapitalization: TextCapitalization.words,
                        initialValue: courseNotifier.title,
                        decoration: InputDecoration(
                          hintText: "Enter Course Title",
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xfff0f0f0),
                        ),
                        onChanged: (String value) {
                          courseNotifier.setTitle(value);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Course Title must not be empty";
                          } else if (value.length > 200) {
                            return "Course Title length mustbe less than 200";
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      initialValue: courseNotifier.description,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Enter Course Description",
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xfff1f1f1),
                      ),
                      onChanged: (String value) {
                        courseNotifier.setDescription(value);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Course Description must not be empty";
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
                          color: Color(0xff1000ff),
                          onPressed: () {
                            courseNotifier.selectCourseCoverImage();
                          },
                          child: Text("Pick Cover Image")),
                    ),
                    courseNotifier.courseCoverImage != null
                        ? ShowSelectedImage(
                            imageFile: courseNotifier.courseCoverImage)
                        : courseNotifier.courseCoverImageUrl != null
                            ? ShowSelectedImage(
                                imageUrl: courseNotifier.courseCoverImageUrl,
                              )
                            : Container(),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CreateChapterViewScreen);
                  chapterNotifier.resetChapter();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        size: 30.0,
                      ),
                      SizedBox(width: 10.0),
                      Text("Add Chapter",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 250.0,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListViewDataWidget(
                        title:
                            "Chapter ${index + 1}: ${courseNotifier.chapters[index].title}",
                        onDelete: () async {
                          await courseNotifier.deleteChapter(index);
                        },
                        onEdit: () {
                          chapterNotifier.editChapter(
                              courseNotifier.chapters[index], index);
                          Navigator.pushNamed(context, CreateChapterViewScreen);
                        },
                      );
                      // return Text("test");
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: courseNotifier.chapters.length),
              ),
              SizedBox(height: 30.0),
              Container(
                width: double.infinity,
                child: RaisedButton(
                    textColor: Colors.white,
                    color: Color(0xff353535),
                    onPressed: () async {
                      final ProgressDialogHandler pdh = ProgressDialogHandler(
                          context: context,
                          message: courseNotifier.isCourseEditing
                              ? 'Updating Course...'
                              : 'Creating Course...');
                      await pdh.showProgressDialog();
                      final res = await courseNotifier.uploadCourse();
                      await pdh.hideProgressDialog();
                      if (res is bool) {
                      } else {
                        Navigator.pop(context);
                        // courseNotifier.resetCourse();
                        categoryNotifier.getAllCoursesFromACategory();
                      }
                    },
                    child: courseNotifier.isCourseEditing
                        ? Text("Update")
                        : Text("Create")),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
