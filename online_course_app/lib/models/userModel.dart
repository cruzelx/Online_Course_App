class User {
  String id;
  String username;
  String email;
  String dp;
  bool isAdmin;
  List<String> completedCourses;
  List<String> ongoingCourses;
  List<String> createdCourses;
  List<String> createdCategories;
  List<String> createdQuizes;
  List<Scores> scores;

  User(
      {this.id,
      this.username,
      this.email,
      this.dp,
      this.isAdmin,
      this.completedCourses,
      this.ongoingCourses,
      this.createdCourses,
      this.createdCategories,
      this.createdQuizes,
      this.scores});

  User.fromJson(Map<String, dynamic> json, String id) {
    if (json == null) return;
    id = json['id'];
    username = json['username'];
    email = json['email'];
    dp = json['dp'];
    isAdmin = json['isAdmin'];
    completedCourses = json['completedCourses'].cast<String>();
    ongoingCourses = json['ongoingCourses'].cast<String>();
    createdCourses = json['createdCourses'].cast<String>();
    createdCategories = json['createdCategories'].cast<String>();
    createdQuizes = json['createdQuizes'].cast<String>();
    if (json['scores'] != null) {
      scores = new List<Scores>();
      json['scores'].forEach((v) {
        scores.add(new Scores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['dp'] = this.dp;
    data['isAdmin'] = this.isAdmin;
    data['completedCourses'] = this.completedCourses;
    data['ongoingCourses'] = this.ongoingCourses;
    data['createdCourses'] = this.createdCourses;
    data['createdCategories'] = this.createdCategories;
    data['createdQuizes'] = this.createdQuizes;
    if (this.scores != null) {
      data['scores'] = this.scores.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Scores {
  Course course;

  Scores({this.course});

  Scores.fromJson(Map<String, dynamic> json) {
    course =
        json['course'] != null ? new Course.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.course != null) {
      data['course'] = this.course.toJson();
    }
    return data;
  }
}

class Course {
  String id;
  List<Topics> topics;

  Course({this.id, this.topics});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['topics'] != null) {
      topics = new List<Topics>();
      json['topics'].forEach((v) {
        topics.add(new Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.topics != null) {
      data['topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
  String id;
  double score;

  Topics({this.id, this.score});

  Topics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['score'] = this.score;
    return data;
  }
}
