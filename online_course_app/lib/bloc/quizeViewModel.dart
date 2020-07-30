import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/models/validationModel.dart';
import 'package:online_course_app/services/quizeService.dart';

class QuizeViewModel extends BaseModel {
  QuizeService _quizeService = locator<QuizeService>();

  List<Quize> _quizes = [];

  List<Quize> get quizes => _quizes;

  List<Question> _questions = [];

  List<Question> get questions => _questions;

  void listenToCategoriesStream() {
    _quizeService.fetchAllQuizesStream().listen((data) {
      List<Quize> newQuizes = data;
      if (newQuizes != null && newQuizes.isNotEmpty) {
        _quizes = newQuizes;
        notifyListeners();
      }
    });
  }


  void addQuestion(Question value) {
    _questions.add(value);
    notifyListeners();
    print(_questions);
  }

  Future<void> deleteQuize(int index) async {
    await _quizeService.deleteQuize(_quizes[index].id);
  }

  Future<void> updateQuize(Quize quize, String id) async {
    await _quizeService.updateQuize(quize, id);
  }

  Future<Quize> createQuize(Quize quize) async {
    return await _quizeService.createQuize(quize);
  }

  Future<Quize> fetchQuize(String id) async {
    return await _quizeService.fetchQuize(id);
  }
}
