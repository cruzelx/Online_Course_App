import 'dart:async';

import 'package:online_course_app/services/firebaseBaseAPIService.dart';
import 'package:online_course_app/models/quizeModel.dart';

class QuizeService {
  FirebaseBaseAPIService _api = FirebaseBaseAPIService('quizes');

  final StreamController<List<Quize>> _quizesStreamController =
      StreamController<List<Quize>>.broadcast();

  Stream fetchAllQuizesStream() {
    _api.ref.snapshots().listen((quizesSnapshot) {
      if (quizesSnapshot.documents.isNotEmpty) {
        var quizes = quizesSnapshot.documents
            .map((snapshot) =>
                Quize.fromJson(snapshot.data, snapshot.documentID))
            .where((quizeItem) => quizeItem.id != null)
            .toList();
        _quizesStreamController.add(quizes);
      }
    });
    return _quizesStreamController.stream;
  }

  Future<void> deleteQuize(String id) async {
    await _api.removeDocumentById(id);
  }

  Future<Quize> fetchQuize(String id) async {
    var quize = await _api.getDocumentById(id);
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
