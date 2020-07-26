import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/locator.dart';
import 'package:online_course_app/models/categoryModel.dart';
import 'package:online_course_app/services/categoryService.dart';

class CategoryViewModel extends BaseModel {
  CategoryViewModel() {
    listenToCategoriesStream();
  }
  CategoryService _catService = locator<CategoryService>();

  List<Category> _categories;

  List<Category> get categories => _categories;

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
    _categories.removeAt(index);
    notifyListeners();
  }

  Future<void> updateCategory(Category category, String id) async {
    await _catService.updateCategory(category, id);
  }

  Future<Category> createCategory(Category category) async {
    return await _catService.createCategory(category);
  }
}
