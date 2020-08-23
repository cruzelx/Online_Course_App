import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/models/validationModel.dart';
import 'package:online_course_app/services/authService.dart';
import 'package:online_course_app/services/dialogService.dart';
import 'package:online_course_app/services/quizeService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizeViewModel extends BaseModel {
  QuizeViewModel() {
    listenToCategoriesStream();
  }
  QuizeService _quizeService = locator<QuizeService>();
  AuthenticationService _authService = locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();

  List<Quize> _quizes = [];
  List<Quize> get quizes => _quizes;

  List<Question> _questions = [];
  List<Question> get questions => _questions;

  String _title;
  String get title => _title;

  String _createdBy;
  String get createdBy => _createdBy;

  Timestamp _createdAt;
  Timestamp get createdAt => _createdAt;

  bool _isQuizeEditing = false;
  bool get isQuizeEditing => _isQuizeEditing;

  String _quizeId;
  String get quizeId => _quizeId;

  setQuizeTitle(String value) {
    _title = value;
    notifyListeners();
  }

  setCreatedBy(String value) {
    _createdBy = value;
    notifyListeners();
  }

  void listenToCategoriesStream() {
    _quizeService.fetchAllQuizesStream().listen((data) {
      List<Quize> newQuizes = data;
      if (newQuizes != null) {
        _quizes = newQuizes;
        notifyListeners();
      }
    });
  }

  Future uploadQuize() async {
    try {
      if (_isQuizeEditing) {
        if (editModeValidation()) {
          Quize quize = Quize(
              title: _title,
              questions: _questions,
              id: _quizeId,
              createdAt: _createdAt);
          final res = await _quizeService.updateQuize(quize, quize.id);
        }
      } else {
        if (createModeValidation()) {
          Quize quize = Quize(
              title: _title, questions: _questions, createdAt: Timestamp.now());
          var res = await _quizeService.createQuize(quize);
          if (!(res is Quize)) return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> createQuize() async {
    if (createModeValidation()) {
      Quize quize = Quize(
          title: _title, questions: _questions, createdAt: Timestamp.now());
      var res = await _quizeService.createQuize(quize);
      if (res is Quize) {
        return true;
      }
    }
    return false;
  }

  Future<bool> updateQuize() async {
    if (editModeValidation()) {
      Quize quize = Quize(
          title: _title,
          questions: _questions,
          id: _quizeId,
          createdAt: _createdAt);
      final res = await _quizeService
          .updateQuize(quize, quize.id)
          .then((value) => true)
          .catchError((onError) => false);
      return res;
    }
    return false;
  }

  Future<void> deleteQuize(int index) async {
    var res = await _dialogService.showDialog(
        title: 'Delete "${_quizes[index].title}" ?',
        description: "Are you sure?",
        alertType: AlertType.warning);
    print(res);
    if (res) await _quizeService.deleteQuize(_quizes[index].id);
  }

  Future<Quize> fetchQuize(String id) async {
    return await _quizeService.fetchQuize(id);
  }

  // Future<Quize> fetchQuize(String id) async {
  //   return await _quizeService.fetchQuize(id);
  // }

  createModeValidation() {
    if (_title != null &&
        _title.isNotEmpty &&
        _questions.isNotEmpty &&
        _questions != null) return true;
    return false;
  }

  editModeValidation() {
    if (_title != null &&
        _title.isNotEmpty &&
        _questions.isNotEmpty &&
        _questions != null &&
        _quizeId != null &&
        _quizeId.isNotEmpty) return true;
    return false;
  }

  addQuestion(Question value) {
    _questions.add(value);
    notifyListeners();
  }

  updateQuestionAtIndex(Question question, int index) {
    _questions.replaceRange(index, index + 1, [question]);
    notifyListeners();
  }

  removeQuestion(int index) async {
    var res = await _dialogService.showDialog(
        title: 'Delete "${_questions[index].question}" ?',
        description: 'Are you sure ?',
        alertType: AlertType.warning);
    if (res) {
      _questions.removeAt(index);
      notifyListeners();
    }
  }

  editQuize(Quize quize) {
    resetQuize();
    _isQuizeEditing = true;
    _title = quize.title;
    _questions = quize.questions;
    _quizeId = quize.id;
    _createdAt = quize.createdAt;
    notifyListeners();
  }

  resetQuize() {
    _title = null;
    _questions = [];
    _createdBy = null;
    _quizeId = null;
    _isQuizeEditing = false;
    notifyListeners();
  }
}
