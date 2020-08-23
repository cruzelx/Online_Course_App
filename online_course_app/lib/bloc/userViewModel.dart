import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/services/categoryService.dart';
import 'package:online_course_app/services/courseService.dart';
import 'package:online_course_app/services/quizeService.dart';
import 'package:online_course_app/services/userService.dart';

class UserViewModel extends BaseModel {
  UserService _userService = locator<UserService>();
  CourseService _courseService = locator<CourseService>();
  CategoryService _catService = locator<CategoryService>();
  QuizeService _quizeService = locator<QuizeService>();

  List<User> _users;

  List<User> get users => _users;

  void listenToUsersStream() {
    _userService.fetchAllUsersStream().listen((data) {
      List<User> newUsers = data;
      if (newUsers != null && newUsers.isNotEmpty) {
        _users = newUsers;
        notifyListeners();
      }
    });
  }

  // Future<void> deleteUser(int index) async {
  //   await _userService.deleteUser(_users[index].id);
  // }

  // Future<void> updateUser(User user, String id) async {
  //   await _userService.updateUser(user, id);
  // }

  // Future<User> createUser(User user) async {
  //   return await _userService.createUser(user);
  // }

  // Future<User> fetchUser(String id) async {
  //   return await _userService.fetchUser(id);
  // }

  Future fetchOngoingCourses(User user) async {
    return await _courseService.fetchBatchCourses(user.ongoingCourses);
  }

  Future fetchCompletedCourses(User user) async {
    return await _courseService.fetchBatchCourses(user.completedCourses);
  }

  Future fetchCreatedCourses(User user) async {
    return await _courseService.fetchBatchCourses(user.createdCourses);
  }

  Future fetchCreatedCategories(User user) async {
    return await _catService.fetchBatchCategories(user.createdCategories);
  }

  Future fetchCreatedQuizes(User user) async {
    return await _quizeService.fetchBatchQuizes(user.createdQuizes);
  }

  List<Topic> getTopicsScores(User user) {
    List<Topic> topics = [];
    if (user == null) return null;
    if (user.scores == null) return null;
    user.scores.forEach((score) {
      if (score.courses == null) return null;
      score.courses.forEach((course) {
        if (course.topics == null) return null;
        topics.addAll(course.topics);
      });
    });
    return topics;
  }

  // User takes quize

  User _currentUser;
  User get currentUser => _currentUser;

  set currentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  setCurretnUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  nullifyScore() {
    _currentTopicScore = 0;
    notifyListeners();
  }

  String _currentCourseId;
  String _currentCourseTitle;

  String _currentTopicTitle;

  double _currentTopicScore = 0.0;

  double get currentTopicScore => _currentTopicScore;

  setCurrentCourse(String courseId, String courseTitle) {
    _currentCourseId = courseId;
    _currentCourseTitle = courseTitle;
    notifyListeners();
  }

  setCurrentTopic(String topicTitle) {
    _currentTopicTitle = topicTitle;
    notifyListeners();
  }

  set incrementTopicScore(double value) {
    _currentTopicScore += value;
    notifyListeners();
  }

  Future uploadScores() async {
    Topic topic = Topic(title: _currentTopicTitle, score: _currentTopicScore);

    Course course = Course(
        id: _currentCourseId, title: _currentCourseTitle, topics: [topic]);

    Score score = Score(courses: [course]);

    if (_currentUser.scores == null) {
      _currentUser.scores = [score];

      await _userService.updateUser(_currentUser, _currentUser.id);
      return;
    }

    for (int i = 0; i < _currentUser.scores.length; i++) {
      Score tempScore = _currentUser.scores[i];
      if (tempScore.courses == null || tempScore.courses.isEmpty) {
        _currentUser.scores[i].courses = [course];
        await _userService.updateUser(_currentUser, _currentUser.id);
        return;
      }

      for (int j = 0; j < tempScore.courses.length; j++) {
        Course tempCourse = tempScore.courses[j];
        if (tempCourse.id != course.id) {
          _currentUser.scores[i].courses.add(course);
          await _userService.updateUser(_currentUser, _currentUser.id);
          return;
        }

        if (tempCourse.topics == null || tempCourse.topics.isEmpty) {
          _currentUser.scores[i].courses[j].topics = [topic];
          await _userService.updateUser(_currentUser, _currentUser.id);
          return;
        }

        for (int k = 0; k < tempCourse.topics.length; k++) {
          if (topic.title == tempCourse.topics[k].title) {
            _currentUser.scores[i].courses[j].topics[k] = topic;
            await _userService.updateUser(_currentUser, _currentUser.id);
            return;
          }
        }
        _currentUser.scores[i].courses[j].topics.add(topic);
        await _userService.updateUser(_currentUser, _currentUser.id);
        return;
      }
    }
  }
}
