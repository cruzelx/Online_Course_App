import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String username;
  String email;
  String dp;
  bool isAdmin;
  String token;
  List<String> completedCourses;
  List<String> ongoingCourses;
  List<String> createdCourses;
  List<String> createdCategories;
  List<String> createdQuizes;
  List<Score> scores;
  Timestamp createdAt;

  User(
      {this.id,
      this.username,
      this.email,
      this.dp,
      this.isAdmin,
      this.token,
      this.completedCourses,
      this.ongoingCourses,
      this.createdCourses,
      this.createdCategories,
      this.createdQuizes,
      this.scores,
      this.createdAt});

  User.fromJson(Map<String, dynamic> json, String docId) {
    if (json == null) return;
    id = docId;
    token = json['token'];
    username = json['username'];
    email = json['email'];
    dp = json['dp'];
    isAdmin = json['isAdmin'];
    completedCourses = json['completedCourses'] != null
        ? json['completedCourses'].cast<String>()
        : [];
    ongoingCourses = json['ongoingCourses'] != null
        ? json['ongoingCourses'].cast<String>()
        : [];
    createdCourses = json['createdCourses'] != null
        ? json['createdCourses'].cast<String>()
        : [];
    createdCategories = json['createdCategories'] != null
        ? json['createdCategories'].cast<String>()
        : [];
    createdQuizes = json['createdQuizes'] != null
        ? json['createdQuizes'].cast<String>()
        : [];
    if (json['scores'] != null) {
      scores = new List<Score>();
      json['scores'].forEach((v) {
        scores.add(new Score.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['dp'] = this.dp;
    data['isAdmin'] = this.isAdmin;
    data['token'] = this.token;
    data['completedCourses'] = this.completedCourses ?? [];
    data['ongoingCourses'] = this.ongoingCourses ?? [];
    data['createdCourses'] = this.createdCourses ?? [];
    data['createdCategories'] = this.createdCategories ?? [];
    data['createdQuizes'] = this.createdQuizes ?? [];
    if (this.scores != null) {
      data['scores'] = this.scores.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Score {
  List<Course> courses;

  Score({this.courses});

  Score.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = new List<Course>();
      json['courses'].forEach((v) {
        courses.add(new Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['courses'] = this.courses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Course {
  String id;
  String title;
  List<Topic> topics;

  Course({this.id, this.title, this.topics});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['topics'] != null) {
      topics = new List<Topic>();
      json['topics'].forEach((v) {
        topics.add(new Topic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.topics != null) {
      data['topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topic {
  String title;
  double score;

  Topic({this.title, this.score});

  Topic.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['score'] = this.score;
    return data;
  }
}