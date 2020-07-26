import 'dart:async';

import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/services/firebaseBaseAPIService.dart';

class CourseService {
  FirebaseBaseAPIService _api = FirebaseBaseAPIService('courses');

  final StreamController<List<Course>> _coursesStreamController =
      StreamController<List<Course>>.broadcast();

  Stream fetchAllCourseStream() {
    _api.ref.snapshots().listen((coursesSnapshot) {
      if (coursesSnapshot.documents.isNotEmpty) {
        var courses = coursesSnapshot.documents
            .map((snapshot) =>
                Course.fromJson(snapshot.data, snapshot.documentID))
            .where((courseItem) => courseItem.title != null)
            .toList();
        _coursesStreamController.add(courses);
      }
    });

    return _coursesStreamController.stream;
  }

  Future<void> deleteCourse(String id) async {
    await _api.removeDocumentById(id);
  }

  Future<Course> fetchCourse(String id) async {
    var course = await _api.getDocumentById(id);
    return Course.fromJson(course.data, course.documentID);
  }

  Future<void> updateCourse(Course course, String id) async {
    await _api.updateDocument(course.toJson(), id);
  }

  Future<Course> createCourse(Course course) async {
    var newCourseRef = await _api.addDocument(course.toJson());
    var newCourse = await newCourseRef.get();
    return Course.fromJson(newCourse.data, newCourse.documentID);
  }
}
