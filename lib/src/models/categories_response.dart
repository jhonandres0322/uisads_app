// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

import 'package:uisads_app/src/models/category.dart';

Category categoryFromMap(String str) => Category.fromMap(json.decode(str));

String categoryToMap(Category data) => json.encode(data.toMap());

class CategoryResponse {
    CategoryResponse({
        required this.categories,
    });

    List<Category> categories;

    factory CategoryResponse.fromMap(Map<String, dynamic> json) => CategoryResponse(
        categories: List<Category>.from( json['categories'].map( (x) => Category.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "categories": categories,
    };
}
