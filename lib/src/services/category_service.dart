import 'dart:developer';

import 'package:uisads_app/src/models/categories_response.dart';
import 'package:uisads_app/src/models/category.dart';
import 'package:uisads_app/src/utils/http_handler.dart';



class CategoryService with HttpHandler {


  Future<List<Category>> getCategories() async {
    final resp = await getGet('/category');
    final CategoryResponse categoriesResponse = CategoryResponse.fromMap( resp );
    return categoriesResponse.categories;
  }
}