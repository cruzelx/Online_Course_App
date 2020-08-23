import 'package:flutter/cupertino.dart';
import 'package:online_course_app/models/courseModel.dart';

class StudyScreenStateViewModel extends ChangeNotifier {
  String _currentCourseId;
  int _currentChapterIndex;
  int _currentTopicIndex;
  Topic _currentTopic;
  Course _currentCourse;

  String get currentCourseId => _currentCourseId;
  int get currentChapterIndex => _currentChapterIndex;
  int get currentTopicIndex => _currentTopicIndex;

  Course get currentCourse => _currentCourse;
  Topic get currentTopic => _currentTopic;

  setCurrentTopic(Topic topic) {
    _currentTopic = topic;
    notifyListeners();
  }

  setCurrentCourse(Course course) {
    _currentCourse = course;
    notifyListeners();
  }

  setCurrentCourseId(String value) {
    _currentCourseId = value;
    notifyListeners();
  }

  setCurrentChapterIndex(int index) {
    _currentChapterIndex = index;
    notifyListeners();
  }

  setCurrentTopicIndex(int index) {
    _currentTopicIndex = index;
    notifyListeners();
  }

  resetValue() {
    _currentTopic = null;
    _currentChapterIndex = null;
    _currentTopicIndex = null;
    _currentCourse = null;
    // _currentCourseId = null;
    notifyListeners();
  }
}
