import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/services/dialogService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChapterViewModel extends BaseModel {
  DialogService _dialogService = locator<DialogService>();

  List<Topic> _topics = [];
  bool _isChapterEditing = false;
  String _title;
  int _currentIndex;

  List<Topic> get topics => _topics;
  String get title => _title;
  bool get isChapterEditing => _isChapterEditing;
  int get currentIndex => _currentIndex;

  setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  createChapter() {
    if (_title != null && _topics.isNotEmpty) {
      Chapter newChapter = Chapter(title: _title, topics: _topics);
      return newChapter;
    }
    return false;
  }

  addTopic(Topic topic) {
    _topics.add(topic);
    notifyListeners();
  }

  updateTopicAtIndex(Topic topic, int index) {
    _topics.replaceRange(index, index + 1, [topic]);
    notifyListeners();
  }

  editChapter(Chapter chapter, int index) {
    resetChapter();
    _isChapterEditing = true;
    _title = chapter.title;
    _topics = chapter.topics;
    _currentIndex = index;
    notifyListeners();
  }

  removeTopic(int index) async {
    var res = await _dialogService.showDialog(
      title: 'Delete "${_topics[index].title}" ?',
      description: 'Are you sure ?',
      alertType: AlertType.warning,
    );
    if (res) {
      _topics.removeAt(index);
      notifyListeners();
    }
  }

  resetChapter() {
    _title = null;
    _topics = [];
    _isChapterEditing = false;
    _currentIndex = null;
    notifyListeners();
  }
}
