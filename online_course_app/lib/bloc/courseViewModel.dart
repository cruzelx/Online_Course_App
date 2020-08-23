import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/services/categoryService.dart';
import 'package:online_course_app/services/courseService.dart';
import 'package:online_course_app/services/dialogService.dart';
import 'package:online_course_app/services/firebaseBaseAPIService.dart';
import 'package:online_course_app/services/mediaService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CourseViewModel extends BaseModel {
  CourseViewModel() {
    listenToCoursesStream();
  }
  CourseService _courseService = locator<CourseService>();
  MediaService _mediaService = locator<MediaService>();
  CategoryService _catService = locator<CategoryService>();
  DialogService _dialogService = locator<DialogService>();

  List<Course> _courses = [];
  File _courseCoverImage;

  List<Course> get courses => _courses;
  File get courseCoverImage => _courseCoverImage;

  void listenToCoursesStream() {
    _courseService.fetchAllCourseStream().listen((data) {
      List<Course> newCourses = data;
      if (newCourses != null) {
        _courses = newCourses;
        notifyListeners();
      }
    });
  }

  Future<void> deleteCourse(int index) async {
    await _courseService.deleteCourse(_courses[index].id);
  }

  Future<void> updateCourse(Course course, String id) async {
    await _courseService.updateCourse(course, id);
  }

  Future<Course> createCourse(Course course) async {
    return await _courseService.createCourse(course);
  }

  Future<Course> fetchCourse(String id) async {
    return await _courseService.fetchCourse(id);
  }

  Future uploadCourseCoverImage() async {
    return uploadFile(_courseCoverImage);
  }

  Future selectCourseCoverImage() async {
    final courseCoverImage = await _mediaService.pickImage();
    if (courseCoverImage is bool) return false;
    _courseCoverImage = courseCoverImage;
    notifyListeners();
  }

  bool createModeValidation() {
    if (_title != null &&
        _description != null &&
        _categoryTitle != null &&
        _categoryId != null &&
        _createdBy != null &&
        _courseCoverImage != null &&
        _chapters != null) return true;

    return false;
  }

  bool editModeValidation() {
    if (_currentCourseId != null &&
        _title != null &&
        _description != null &&
        _categoryTitle != null &&
        (_courseCoverImageUrl != null || _courseCoverImage != null) &&
        _createdAt != null &&
        _chapters != null) return true;

    return false;
  }

  Future uploadCourse() async {
    try {
      if (_isCourseEditing) {
        if (editModeValidation()) {
          // if coverImage is reselected
          if (_courseCoverImage != null) {
            final url = await uploadCourseCoverImage();
            if (url is bool) {
              return false;
            }
            StorageReference imageRef = await FirebaseStorage.instance
                .getReferenceFromUrl(_courseCoverImageUrl);
            await imageRef.delete();
            _courseCoverImageUrl = url;
          }

          Course course = Course(
            id: _currentCourseId,
            title: _title,
            description: _description,
            coverImage: _courseCoverImageUrl,
            chapters: _chapters,
            category: _categoryTitle,
            createdBy: _createdBy,
            createdAt: _createdAt,
          );

          final res = await updateCourse(course, _currentCourseId);
        }
      } else {
        if (createModeValidation()) {
          final url = await uploadCourseCoverImage();

          if (url is bool) return false;

          _courseCoverImageUrl = url;

          Course course = Course(
              title: _title,
              description: _description,
              coverImage: _courseCoverImageUrl,
              chapters: _chapters,
              createdBy: _createdBy,
              category: _categoryTitle,
              createdAt: Timestamp.now());

          final newCourse = await createCourse(course);
          final res = await _catService.addCourseRefToCategory(
              _categoryId, newCourse.id);
          if (!res) return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  //editing
  String _categoryId;
  String _currentCourseId;
  Timestamp _createdAt;
  String _categoryTitle;
  String _title;
  String _description;
  String _createdBy;
  String _courseCoverImageUrl;
  List<Chapter> _chapters = [];
  bool _isCourseEditing = false;

  String get categoryId => _categoryId;
  String get currentCourseId => _currentCourseId;
  Timestamp get createdAt => _createdAt;
  String get categoryTitle => _categoryTitle;
  String get title => _title;
  String get description => _description;
  String get createdBy => _createdBy;
  String get courseCoverImageUrl => _courseCoverImageUrl;
  List<Chapter> get chapters => _chapters;
  bool get isCourseEditing => _isCourseEditing;

  setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  setCreatedBy(String value) {
    _createdBy = value;
    notifyListeners();
  }

  setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  setCategory(String catId, String catTitle) {
    _categoryTitle = catTitle;
    _categoryId = catId;
    notifyListeners();
  }

  deleteChapter(int index) async {
    var res = await _dialogService.showDialog(
        title: 'Delete "${_chapters[index].title}" ?',
        description: 'Are you sure ?',
        alertType: AlertType.warning);
    if (res) {
      _chapters.removeAt(index);
      notifyListeners();
    }
  }

  addChapter(Chapter chapter) {
    _chapters.add(chapter);
    notifyListeners();
  }

  updateChapterAtIndex(Chapter chapter, int index) {
    _chapters.replaceRange(index, index + 1, [chapter]);
    notifyListeners();
  }

  editCourse(Course course) {
    resetCourse();
    _isCourseEditing = true;
    _currentCourseId = course.id;
    _createdAt = course.createdAt;
    _categoryTitle = course.category;
    _title = course.title;
    _description = course.description;
    _createdBy = course.createdBy;
    _courseCoverImageUrl = course.coverImage;
    _chapters = course.chapters;
    notifyListeners();
  }

  resetCourse() {
    _isCourseEditing = false;
    _currentCourseId = null;
    _createdAt = null;
    _courseCoverImage = null;
    _categoryTitle = null;
    _categoryId = null;
    _title = null;
    _description = null;
    _createdBy = null;
    _courseCoverImageUrl = null;
    _chapters = [];
    notifyListeners();
  }
}
