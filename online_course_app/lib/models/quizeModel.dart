class Quize {
  String id;
  List<Questions> questions;

  Quize({this.id, this.questions});

  Quize.fromJson(Map<String, dynamic> json,String id) {
    if (json == null) return;
    id = json['id'];
    if (json['questions'] != null) {
      questions = new List<Questions>();
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String question;
  List<String> options;
  int correctAnswer;

  Questions({this.question, this.options, this.correctAnswer});

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    options = json['options'].cast<String>();
    correctAnswer = json['correctAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['options'] = this.options;
    data['correctAnswer'] = this.correctAnswer;
    return data;
  }
}
