import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_course_app/services/firebaseBaseAPIService.dart';
import 'package:online_course_app/models/quizeModel.dart';

class QuizeService {
  FirebaseBaseAPIService _api = FirebaseBaseAPIService('quizes');

  final StreamController<List<Quize>> _quizesStreamController =
      StreamController<List<Quize>>.broadcast();

  Stream fetchAllQuizesStream() {
    _api.ref
        .orderBy('createdAt', descending: false)
        .snapshots()
        .listen((quizesSnapshot) {
      print("debug2");
      print(quizesSnapshot.documents.length);
      // if (quizesSnapshot.documents.isNotEmpty) {
      var quizes = quizesSnapshot.documents
          .map((snapshot) => Quize.fromJson(snapshot.data, snapshot.documentID))
          .where((quizeItem) => quizeItem.id != null)
          .toList();
      _quizesStreamController.add(quizes);
    });
    return _quizesStreamController.stream;
  }

  Future<List<Quize>> fetchBatchQuizes(List<String> ids) async {
    if (ids == null || ids.isEmpty) return null;
    final res =
        await _api.ref.where(FieldPath.documentId, whereIn: ids).getDocuments();
    return res.documents
        .map((e) => Quize.fromJson(e.data, e.documentID))
        .toList();
  }

  Future<void> deleteQuize(String id) async {
    await _api.removeDocumentById(id);
  }

  Future<Quize> fetchQuize(String id) async {
    var quize = await _api.getDocumentById(id);
    if (quize == null) return null;
    return Quize.fromJson(quize.data, quize.documentID);
  }

  Future<void> updateQuize(Quize quize, String id) async {
    await _api.updateDocument(quize.toJson(), id);
  }

  Future<Quize> createQuize(Quize quize) async {
    var newQuizeRef = await _api.addDocument(quize.toJson());
    var newQuize = await newQuizeRef.get();
    return Quize.fromJson(newQuize.data, newQuize.documentID);
  }
}
