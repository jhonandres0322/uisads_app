// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

Category categoryFromMap(String str) => Category.fromMap(json.decode(str));

String categoryToMap(Category data) => json.encode(data.toMap());

class Category {
    Category({
        required this.id,
        required this.name,
        required this.key,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String name;
    String key;
    String createdAt;
    String updatedAt;

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        key: json["key"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id, 
        "name": name,
        "key": key,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}
