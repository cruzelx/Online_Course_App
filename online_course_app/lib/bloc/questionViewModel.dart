import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/models/quizeModel.dart';

class QuestionViewModel extends BaseModel {
  String _question;
  List<String> _options = [];
  int _correctAnsWerIndex;
  bool _isQuestionEditing = false;
  String _groupValue = '';
  int _currentQuestionIndex;

  String get question => _question;
  List<String> get options => _options;
  int get correctAnswerIndex => _correctAnsWerIndex;
  bool get isQuestionEditing => _isQuestionEditing;
  String get groupValue => _groupValue;
  int get currentQuestionIndex => _currentQuestionIndex;

  setQuestion(String value) {
    _question = value;
    notifyListeners();
  }

  addOption(String value) {
    _options.add(value);
    notifyListeners();
  }

  removeOption(String value) {
    _options.remove(value);
    notifyListeners();
  }

  setCorrectAnswerIndex(int index) {
    _correctAnsWerIndex = index;
    notifyListeners();
  }

  setGroupValue(String value) {
    _groupValue = value;
    _correctAnsWerIndex = _options.indexOf(_groupValue);
    notifyListeners();
  }

  createModeValidation() {
    if (_question != null &&
        _options != null &&
        _options.isNotEmpty &&
        _correctAnsWerIndex != null &&
        _correctAnsWerIndex < _options.length) return true;
    return false;
  }

  createQuizeQuestion() {
    if (createModeValidation()) {
      Question question = Question(
          question: _question,
          options: _options,
          correctAnswer: _correctAnsWerIndex);
      return question;
    }
    return false;
  }

  editQuestion(Question question, int index) {
    resetQuestion();
    _isQuestionEditing = true;
    _question = question.question;
    _options = question.options;
    _correctAnsWerIndex = question.correctAnswer;
    _groupValue = _options[_correctAnsWerIndex];
    _currentQuestionIndex = index;
    notifyListeners();
  }

  resetQuestion() {
    _isQuestionEditing = false;
    _question = null;
    _options = [];
    _correctAnsWerIndex = null;
    _groupValue = '';
    _currentQuestionIndex = null;
    notifyListeners();
  }
}
