class Category {
  String id;
  String title;
  String coverImage;
  String icon;
  String description;
  List<String> courses;

  Category(
      {this.title, this.description, this.courses, this.coverImage, this.icon});

  Category.fromJson(Map<String, dynamic> json, String docId) {
    if (json == null) return;
    id = docId;
    title = json['title'];
    description = json['description'];
    coverImage = json['coverImage'];
    icon = json['icon'];
    courses = json['courses'] != null ? json['courses'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['coverImage'] = this.coverImage;
    data['icon'] = this.icon;
    data['description'] = this.description;
    data['courses'] = this.courses;
    return data;
  }
}
