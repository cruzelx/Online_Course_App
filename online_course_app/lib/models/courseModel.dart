class Course {
  String id;
  String title;
  String description;
  String coverImage;
  List<Chapters> chapters;
  String category;
  String createdBy;

  Course(
      {this.id,
      this.title,
      this.description,
      this.coverImage,
      this.chapters,
      this.category,
      this.createdBy});

  Course.fromJson(Map<String, dynamic> json, String id) {
    if (json == null) return;
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverImage = json['coverImage'];
    if (json['chapters'] != null) {
      chapters = new List<Chapters>();
      json['chapters'].forEach((v) {
        chapters.add(new Chapters.fromJson(v));
      });
    }
    category = json['category'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['coverImage'] = this.coverImage;
    if (this.chapters != null) {
      data['chapters'] = this.chapters.map((v) => v.toJson()).toList();
    }
    data['category'] = this.category;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class Chapters {
  String title;
  List<Topics> topics;

  Chapters({this.title, this.topics});

  Chapters.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['topics'] != null) {
      topics = new List<Topics>();
      json['topics'].forEach((v) {
        topics.add(new Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.topics != null) {
      data['topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
  String title;
  String description;
  String videoUrl;
  String quizes;

  Topics({this.title, this.description, this.videoUrl, this.quizes});

  Topics.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    quizes = json['quizes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['videoUrl'] = this.videoUrl;
    data['quizes'] = this.quizes;
    return data;
  }
}
