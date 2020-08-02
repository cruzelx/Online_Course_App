import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/models/userModel.dart';
import 'package:online_course_app/models/validationModel.dart';
import 'package:online_course_app/services/authService.dart';
import 'package:online_course_app/services/quizeService.dart';

class QuizeViewModel extends BaseModel {
  QuizeViewModel() {
    listenToCategoriesStream();
  }
  QuizeService _quizeService = locator<QuizeService>();
  AuthenticationService _authService = locator<AuthenticationService>();

  List<Quize> _quizes = [];

  List<Quize> get quizes => _quizes;

  List<Question> _questions = [];

  List<Question> get questions => _questions;

  String _title;

  String get title => _title;

  User _createdBy;

  User get createdBy => _createdBy;

  Timestamp _createdAt;

  Timestamp get createdAt => _createdAt;

  bool _isEditing = false;

  bool get isEditing => _isEditing;

  String _quizeId;

  String get quizeId => _quizeId;

  setCreatedBy() {
    _createdBy = _authService.currentUser;
    notifyListeners();
  }

  setQuizeTitle(String value) {
    _title = value;
    notifyListeners();
  }

  resetQuize() {
    _title = null;
    _questions = [];
    _createdBy = null;
    _quizeId = null;
    _isEditing = false;
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

  void addQuestion(Question value) {
    _questions.add(value);
    notifyListeners();
  }

  Future<void> deleteQuize(int index) async {
    await _quizeService.deleteQuize(_quizes[index].id);
  }

  Future<bool> updateQuize() async {
    if (_title != null &&
        _title.isNotEmpty &&
        _questions.isNotEmpty &&
        _questions != null &&
        _quizeId != null &&
        _quizeId.isNotEmpty) {
      Quize quize = Quize(
          title: _title,
          questions: _questions,
          id: _quizeId,
          createdAt: _createdAt);
      final res =
          await _quizeService.updateQuize(quize, quize.id).then((value) {
        return true;
      });
      return res ? true : false;
    }
    return false;
  }

  editQuize(Quize quize) {
    _isEditing = true;
    _title = quize.title;
    _questions = quize.questions;
    _quizeId = quize.id;
    _createdAt = quize.createdAt;
    notifyListeners();
  }

  Future<bool> createQuize() async {
    if (_title != null &&
        _title.isNotEmpty &&
        _questions.isNotEmpty &&
        _questions != null) {
      Quize quize = Quize(
          title: _title, questions: _questions, createdAt: Timestamp.now());
      var res = await _quizeService.createQuize(quize);
      if (res is Quize) {
        return true;
      }
    }
    return false;
  }

  Future<Quize> fetchQuize(String id) async {
    return await _quizeService.fetchQuize(id);
  }

  // create question

  String _question;
  List<String> _options = [];
  int _correctIndex;
  String _groupValue = '';

  String get question => _question;
  List<String> get options => _options;
  int get correctIndex => _correctIndex;
  String get groupValue => _groupValue;

  setQuestion(String value) {
    _question = value;
    notifyListeners();
  }

  removeQuestion(int index) {
    _questions.removeAt(index);
    notifyListeners();
  }

  addOption(String value) {
    _options.add(value);
    notifyListeners();
  }

  setGroupValue(String value) {
    _groupValue = value;
    _correctIndex = _options.indexOf(_groupValue);
    notifyListeners();
  }

  removeOption(String value) {
    _options.remove(value);
    notifyListeners();
  }

  bool createQuestion() {
    print(_question);
    print(_options);
    print(_correctIndex);
    if (_question != null &&
        _question.isNotEmpty &&
        _options != null &&
        _options.isNotEmpty &&
        _correctIndex != null &&
        _correctIndex < _options.length) {
      Question question = Question(
          question: _question, options: options, correctAnswer: _correctIndex);
      addQuestion(question);
      return true;
    }
    return false;
  }

  resetValues() {
    _question = null;
    _options = [];
    _correctIndex = null;
    _groupValue = '';
  }
}
