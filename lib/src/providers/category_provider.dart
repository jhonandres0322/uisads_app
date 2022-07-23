


import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {

  String _categorySelected = '';

  
  String get categorySelect => _categorySelected;

  set categorySelect( String value ) {
    _categorySelected = value;
    notifyListeners();
  }

}