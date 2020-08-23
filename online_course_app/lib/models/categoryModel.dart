import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String id;
  String title;
  String coverImage;
  String icon;
  String description;
  List<String> courses;
  Timestamp createdAt;
  String createdBy;

  Category(
      {this.title,
      this.description,
      this.courses,
      this.coverImage,
      this.icon,
      this.createdAt,
      this.id,
      this.createdBy});

  Category.fromJson(Map<String, dynamic> json, String docId) {
    if (json == null) return;
    id = docId;
    title = json['title'];
    description = json['description'];
    coverImage = json['coverImage'];
    icon = json['icon'];
    courses = json['courses'] != null ? json['courses'].cast<String>() : [];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['coverImage'] = this.coverImage;
    data['icon'] = this.icon;
    data['description'] = this.description;
    data['courses'] = this.courses;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
