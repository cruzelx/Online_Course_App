import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_course_app/models/categoryModel.dart';
import 'package:online_course_app/models/courseModel.dart';
import 'package:online_course_app/services/firebaseBaseAPIService.dart';

class CategoryService {
  FirebaseBaseAPIService _api = FirebaseBaseAPIService('categories');
  FirebaseBaseAPIService _courseApi = FirebaseBaseAPIService('courses');

  final StreamController<List<Category>> _categoriesStreamController =
      StreamController<List<Category>>.broadcast();

  Stream fetchAllCategoriesStream() {
    _api.ref.snapshots().listen((categoriesSnapshot) {
      var categories = categoriesSnapshot.documents
          .map((snapshot) =>
              Category.fromJson(snapshot.data, snapshot.documentID))
          .where((mappedItem) => mappedItem.title != null)
          .toList();
      _categoriesStreamController.add(categories);
      // categories.forEach((category) {
      //   print(category.title);
      //   print(category.id);
      // });
    });
    return _categoriesStreamController.stream;
  }

  Future<List<Category>> fetchBatchCategories(List<String> ids) async {
    if (ids == null || ids.isEmpty) return null;
    final res =
        await _api.ref.where(FieldPath.documentId, whereIn: ids).getDocuments();
    return res.documents
        .map((e) => Category.fromJson(e.data, e.documentID))
        .toList();
  }

  Future<void> deleteCategory(String id) async {
    await _api.removeDocumentById(id);
  }

  Future<Category> fetchCategory(String id) async {
    var category = await _api.getDocumentById(id);
    return Category.fromJson(category.data, category.documentID);
  }

  Future<void> updateCategory(Category category, String id) async {
    await _api.updateDocument(category.toJson(), id);
  }

  Future<Category> createCategory(Category category) async {
    var newCategoryRef = await _api.addDocument(category.toJson());
    var newCategory = await newCategoryRef.get();
    return Category.fromJson(newCategory.data, newCategory.documentID);
  }

  Future<List<Course>> getCoursesFromACategory(String categoryId) async {
    List<Course> _courses = [];
    var datum = await _api.getDocumentById(categoryId);
    var category = Category.fromJson(datum.data, datum.documentID);

    for (var courseId in category.courses) {
      var course = await _courseApi.getDocumentById(courseId);
      _courses.add(Course.fromJson(course.data, course.documentID));
    }

    return _courses.isEmpty ? null : _courses;
  }

  Future<bool> deleteCourseRefFromCategory(
      String categoryId, String courseId) async {
    try {
      var data = await _api.getDocumentById(categoryId);
      var category = Category.fromJson(data.data, data.documentID);
      if (category.courses.contains(courseId)) {
        category.courses.remove(courseId);
      } else {
        return false;
      }
      await updateCategory(category, category.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addCourseRefToCategory(
      String categoryId, String courseId) async {
    try {
      var data = await _api.getDocumentById(categoryId);
      var category = Category.fromJson(data.data, data.documentID);
      if (!category.courses.contains(courseId)) category.courses.add(courseId);
      await updateCategory(category, category.id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
