// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'package:uisads_app/src/constants/import_models.dart';

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
