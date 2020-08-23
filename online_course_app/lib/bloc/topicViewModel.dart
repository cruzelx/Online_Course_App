import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/models/quizeModel.dart';
import 'package:online_course_app/services/quizeService.dart';

class TopicViewModel extends BaseModel {
  QuizeService _qService = locator<QuizeService>();

  String _title;
  String _description;
  String _videoUrl;
  Quize _selectedQuize;
  int _currentIndex;

  String get title => _title;
  String get description => _description;
  String get videoUrl => _videoUrl;
  Quize get selectedQuize => _selectedQuize;
  int get currentIndex => _currentIndex;

  bool _isTopicEditing = false;
  bool get isTopicEditing => _isTopicEditing;

  setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  setVideoUrl(String value) {
    _videoUrl = value;
    notifyListeners();
  }

  setSelectedQuize(String quizeId) async {
    final quize = await _qService.fetchQuize(quizeId);
    _selectedQuize = quize;
    notifyListeners();
  }

  createModeValidation() {
    if (_title != null &&
        _description != null &&
        _videoUrl != null &&
        _selectedQuize != null) return true;
    return false;
  }

  createTopic() {
    if (createModeValidation()) {
      Topic newTopic = Topic(
          title: _title,
          description: _description,
          videoUrl: _videoUrl,
          quize: _selectedQuize.id);
      return newTopic;
    }
    return false;
  }

  editTopic(Topic topic, int index) async {
    resetTopic();
    _isTopicEditing = true;
    _title = topic.title;
    _description = topic.description;
    _videoUrl = topic.videoUrl;
    _currentIndex = index;
    await setSelectedQuize(topic.quize);
    notifyListeners();
  }

  resetTopic() {
    _isTopicEditing = false;
    _currentIndex = null;
    _title = null;
    _description = null;
    _videoUrl = null;
    _selectedQuize = null;
    notifyListeners();
  }
}
