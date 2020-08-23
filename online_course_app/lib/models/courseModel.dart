import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String id;
  String title;
  String description;
  String coverImage;
  List<Chapter> chapters;
  String category;
  String createdBy;
  Timestamp createdAt;

  Course(
      {this.id,
      this.title,
      this.description,
      this.coverImage,
      this.chapters,
      this.category,
      this.createdBy,
      this.createdAt});

  Course.fromJson(Map<String, dynamic> json, String docId) {
    if (json == null) return;
    id = docId;
    title = json['title'];
    description = json['description'];
    coverImage = json['coverImage'];
    if (json['chapters'] != null) {
      chapters = new List<Chapter>();
      json['chapters'].forEach((v) {
        chapters.add(new Chapter.fromJson(v));
      });
    }
    category = json['category'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['coverImage'] = this.coverImage;
    if (this.chapters != null) {
      data['chapters'] = this.chapters.map((v) => v.toJson()).toList();
    }
    data['category'] = this.category;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Chapter {
  String title;
  List<Topic> topics;

  Chapter({this.title, this.topics});

  Chapter.fromJson(Map<String, dynamic> json) {
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
    data['title'] = this.title;
    if (this.topics != null) {
      data['topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topic {
  String title;
  String description;
  String videoUrl;
  String quize;

  Topic({this.title, this.description, this.videoUrl, this.quize});

  Topic.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    quize = json['quize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['videoUrl'] = this.videoUrl;
    data['quize'] = this.quize;
    return data;
  }
}
