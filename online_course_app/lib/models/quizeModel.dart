// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Quize {
  String id;
  String title;
  String createdBy;
  List<Question> questions;
  Timestamp createdAt;

  Quize({this.id, this.questions, this.createdBy, this.title, this.createdAt});

  Quize.fromJson(Map<String, dynamic> json, String documentID) {
    if (json == null) return;
    id = documentID;
    title = json['title'];
    createdBy = json['createdBy'];
    if (json['questions'] != null) {
      questions = new List<Question>();
      json['questions'].forEach((v) {
        questions.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  String question;
  List<String> options;
  int correctAnswer;

  Question({this.question, this.options, this.correctAnswer});

  Question.fromJson(Map<String, dynamic> json) {
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
