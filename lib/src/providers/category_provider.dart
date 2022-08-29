import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';

class CategoryProvider with ChangeNotifier {
  String _categorySelected = '';
  List<Category> categories = [
    Category(id: '', name: 'Todos', key: 'todos', createdAt: '', updatedAt: '')
  ];

  CategoryProvider() {
    getCategories();
  }

  String get categorySelect => _categorySelected;

  set categorySelect(String value) {
    _categorySelected = value;
    notifyListeners();
  }

  getCategories() async {
    final categoryService = CategoryService();
    final resp = await categoryService.getCategories();
    categories.addAll(resp);
    // categories = await categoryService.getCategories();
    notifyListeners();
  }
}
