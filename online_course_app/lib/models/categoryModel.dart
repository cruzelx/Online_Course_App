class Category {
  String title;
  String description;
  List<String> courses;

  Category({this.title, this.description, this.courses});

  Category.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    courses = json['courses'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['courses'] = this.courses;
    return data;
  }
}
