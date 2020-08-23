import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/categoryModel.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/services/categoryService.dart';
import 'package:online_course_app/services/courseService.dart';
import 'package:online_course_app/services/dialogService.dart';
import 'package:online_course_app/services/mediaService.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CategoryViewModel extends BaseModel {
  CategoryViewModel() {
    listenToCategoriesStream();
  }
  CategoryService _catService = locator<CategoryService>();
  MediaService _mediaService = locator<MediaService>();
  CourseService _courseService = locator<CourseService>();
  DialogService _dialogService = locator<DialogService>();

  List<Category> _categories = [];

  File _categoryCoverImage;
  File _categoryIcon;

  List<Category> get categories => _categories;
  File get categoryCoverImage => _categoryCoverImage;
  File get categoryIcon => _categoryIcon;

  void listenToCategoriesStream() {
    _catService.fetchAllCategoriesStream().listen((data) {
      List<Category> newCategories = data;
      if (newCategories != null) {
        _categories = newCategories;
        notifyListeners();
      }
    });
  }

  Future<void> deleteCategory(int index) async {
    var res = await _dialogService.showDialog(
        title: 'Delete "${_categories[index].title}" ?',
        description: 'Are you sure ?',
        alertType: AlertType.warning);
    if (res) await _catService.deleteCategory(_categories[index].id);
  }

  Future<void> updateCategory(Category category, String id) async {
    await _catService.updateCategory(category, id);
  }

  Future<Category> createCategory(Category category) async {
    return await _catService.createCategory(category);
  }

  Future<Category> fetchCategory(String id) async {
    return await _catService.fetchCategory(id);
  }

  Future uploadCategoryCoverImage() async {
    print("inside cover image upload");
    return uploadFile(_categoryCoverImage);
  }

  Future uploadCategoryIcon() async {
    print("inside icon upload");
    return uploadFile(_categoryIcon);
  }

  Future selectCategoryCoverImage() async {
    final categoryCoverImage = await _mediaService.pickImage();
    if (categoryCoverImage is bool) return false;
    _categoryCoverImage = categoryCoverImage;
    notifyListeners();
  }

  Future selectCategoryIcon() async {
    final categoryIcon = await _mediaService.pickImage();
    if (categoryIcon is bool) return false;
    _categoryIcon = categoryIcon;
    notifyListeners();
  }

  Future getCategoryCourses(String categoryId) async {
    return await _catService.getCoursesFromACategory(categoryId);
  }

  Future getAllCoursesFromACategory() async {
    _courses = await _catService.getCoursesFromACategory(_currentCategoryId);
    _courses = _courses == null ? [] : _courses;
    generateCoursesIds();
    notifyListeners();
    return _courses;
  }

  bool editModeValidation() {
    if (_currentCategoryId != null &&
        _title != null &&
        _description != null &&
        (_categoryCoverImage != null || _categoryCoverImageUrl != null) &&
        (_categoryIcon != null || _categoryIconUrl != null) &&
        _createdAt != null &&
        _courses != null) return true;

    return false;
  }

  bool createModeValidation() {
    if (_title != null &&
        _description != null &&
        _categoryCoverImage != null &&
        _categoryIcon != null) return true;

    return false;
  }

  Future uploadCategory() async {
    try {
      if (_isCategoryEditing) {
        if (editModeValidation()) {
          if (_categoryCoverImage != null) {
            final url = await uploadCategoryCoverImage();
            if (url is bool) return false;

            StorageReference coverImageRef = await FirebaseStorage.instance
                .getReferenceFromUrl(_categoryCoverImageUrl);

            await coverImageRef.delete();

            _categoryCoverImageUrl = url;
          }

          if (_categoryIcon != null) {
            final url = await uploadCategoryIcon();
            if (url is bool) return false;

            StorageReference iconImageRef = await FirebaseStorage.instance
                .getReferenceFromUrl(_categoryIconUrl);
            await iconImageRef.delete();

            _categoryIconUrl = url;
          }

          Category updatedCategory = Category(
            id: _currentCategoryId,
            title: _title,
            description: _description,
            coverImage: _categoryCoverImageUrl,
            icon: _categoryIconUrl,
            createdAt: _createdAt,
            createdBy: _createdBy,
            courses: _coursesIdsList,
          );
          await updateCategory(updatedCategory, _currentCategoryId);
        }
      } else {
        if (createModeValidation()) {
          final coverImageUrl = await uploadCategoryCoverImage();
          final iconImageUrl = await uploadCategoryIcon();

          if (coverImageUrl is bool || iconImageUrl is bool) return false;

          Category newCategory = Category(
              title: _title,
              description: _description,
              coverImage: coverImageUrl,
              icon: iconImageUrl,
              createdAt: Timestamp.now(),
              courses: [],
              createdBy: _createdBy);

          final res = await createCategory(newCategory);
          if (!(res is Category)) return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  // editing
  String _currentCategoryId;
  String _currentCategoryTitle;
  bool _isCategoryEditing = false;
  String _title;
  String _description;
  String _categoryIconUrl;
  String _categoryCoverImageUrl;
  Timestamp _createdAt;
  String _createdBy;
  List<Course> _courses = [];
  List<String> _coursesIdsList = [];

  String get currentCategoryId => _currentCategoryId;
  String get currentCategoryTitle => _currentCategoryTitle;
  bool get isCategoryEditing => _isCategoryEditing;
  String get title => _title;
  String get description => _description;
  String get categoryIconUrl => _categoryIconUrl;
  String get categoryCoverImageUrl => _categoryCoverImageUrl;
  String get createdBy => _createdBy;
  List<Course> get courses => _courses;

  generateCoursesIds() {
    _coursesIdsList = [];
    for (var course in _courses) {
      _coursesIdsList.add(course.id);
    }
  }

  setCreatedBy(String value) {
    _createdBy = value;
    notifyListeners();
  }

  setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  Future setCurrentCategoryId(String value) async {
    _currentCategoryId = value;
    final res = await getAllCoursesFromACategory();
    return res;
    // notifyListeners();
  }

  Future<bool> deleteCourseFromACategory(int index) async {
    var dRes = await _dialogService.showDialog(
        title: 'Delete "${_courses[index].title}" ?',
        description: 'Are you sure ?',
        alertType: AlertType.warning);
    if (dRes) {
      Course toDelete = _courses[index];
      final res = await _catService.deleteCourseRefFromCategory(
          _currentCategoryId, toDelete.id);
      await _courseService.deleteCourse(_courses[index].id);
      StorageReference courseCoverImageRef = await FirebaseStorage.instance
          .getReferenceFromUrl(_courses[index].coverImage);
      await courseCoverImageRef.delete();
      if (res) {
        _courses.removeAt(index);
        getAllCoursesFromACategory();
      }
      return res;
    }
    return false;
  }

  editCategory(Category category) async {
    resetCategory();
    _isCategoryEditing = true;
    _currentCategoryId = category.id;
    _currentCategoryTitle = category.title;
    _title = category.title;
    _description = category.description;
    _categoryIconUrl = category.icon;
    _categoryCoverImageUrl = category.coverImage;
    _createdAt = category.createdAt;
    await getAllCoursesFromACategory();
    notifyListeners();
  }

  resetCategory() {
    _isCategoryEditing = false;
    _currentCategoryId = null;
    _currentCategoryTitle = null;
    _title = null;
    _description = null;
    _categoryIconUrl = null;
    _categoryCoverImageUrl = null;
    _categoryCoverImage = null;
    _categoryIcon = null;
    _createdAt = null;
    _courses = [];
    _coursesIdsList = [];
    notifyListeners();
  }
}
