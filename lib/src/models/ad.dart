// To parse this JSON data, do
//
//     final ad = adFromJson(jsonString);

import 'dart:convert';


Ad adFromJson(String str) => Ad.fromJson(json.decode(str));

String adToJson(Ad data) => json.encode(data.toJson());

class Ad {
  Ad({
    required this.title,
    required this.description,
    required this.publisher,
    required this.images,
    required this.postDate,
    required this.category,
    required this.state,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  String title;
  String description;
  dynamic publisher;
  List<dynamic> images;
  DateTime postDate;
  dynamic category;
  bool state;
  dynamic rating;
  DateTime createdAt;
  DateTime updatedAt;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        title: json["title"],
        description: json["description"],
        publisher: json["publisher"],
        images: List<String>.from(json["images"].map((x) => x)),
        postDate: DateTime.parse(json["post_date"]),
        category: json["category"],
        state: json["state"],
        rating: json["rating"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "publisher": publisher,
        "images": List<dynamic>.from(images.map((x) => x)),
        "post_date": postDate.toIso8601String(),
        "category": category,
        "state": state,
        "rating": rating,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
