import 'dart:io';
import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/categoryModel.dart';
import 'package:online_course_app/services/categoryService.dart';
import 'package:online_course_app/services/mediaService.dart';

class CategoryViewModel extends BaseModel {
  CategoryService _catService = locator<CategoryService>();
  MediaService _mediaService = locator<MediaService>();

  List<Category> _categories;
  File _categoryCoverImage;
  File _categoryIcon;

  List<Category> get categories => _categories;
  File get categoryCoverImage => _categoryCoverImage;
  File get categoryIcon => _categoryIcon;

  void listenToCategoriesStream() {
    _catService.fetchAllCategoriesStream().listen((data) {
      List<Category> newCategories = data;
      if (newCategories != null && newCategories.isNotEmpty) {
        _categories = newCategories;
        notifyListeners();
      }
    });
  }

  Future<void> deleteCategory(int index) async {
    await _catService.deleteCategory(_categories[index].id);
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
}
