import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/bloc/quizeViewModel.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/models/validationModel.dart';

class CreateQuizeQuestionViewModel extends QuizeViewModel {
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
