


import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_services.dart';

class CategoryProvider with ChangeNotifier {

  String _categorySelected = '';
  List<Category> categories = [];

  CategoryProvider() {
    getCategories();
  }
  
  String get categorySelect => _categorySelected;

  set categorySelect( String value ) {
    _categorySelected = value;
    notifyListeners();
  }

  getCategories() async {
    final categoryService = CategoryService();
    categories = await categoryService.getCategories(); 
    notifyListeners();
  }

}