import 'dart:async';

import 'package:online_course_app/models/categoryModel.dart';
import 'package:online_course_app/services/firebaseBaseAPIService.dart';
import 'package:flutter/material.dart';

class CategoryService {
  FirebaseBaseAPIService _api = FirebaseBaseAPIService('categories');

  final StreamController<List<Category>> _categoriesStreamController =
      StreamController<List<Category>>.broadcast();

  Stream fetchAllCategoriesStream() {
    _api.ref.snapshots().listen((categoriesSnapshot) {
      if (categoriesSnapshot.documents.isNotEmpty) {
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
      }
    });
    return _categoriesStreamController.stream;
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
}
