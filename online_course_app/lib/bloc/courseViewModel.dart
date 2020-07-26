import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/services/courseService.dart';
import 'package:online_course_app/services/firebaseBaseAPIService.dart';

class CourseViewModel extends BaseModel {
  CourseService _courseService = locator<CourseService>();

  List<Course> _courses;

  List<Course> get courses => _courses;

  void listenToCoursesStream() {
    _courseService.fetchAllCourseStream().listen((data) {
      List<Course> newCourses = data;
      if (newCourses != null && newCourses.isNotEmpty) {
        _courses = newCourses;
        notifyListeners();
      }
    });
  }

  Future<void> deleteCourse(int index) async {
    await _courseService.deleteCourse(_courses[index].id);
  }

  Future<void> updateCourse(Course course, String id) async {
    await _courseService.updateCourse(course, id);
  }

  Future<Course> createCourse(Course course) async {
    return await _courseService.createCourse(course);
  }

  Future<Course> fetchCourse(String id) async {
    return await _courseService.fetchCourse(id);
  }
}
