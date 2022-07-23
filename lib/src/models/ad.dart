// To parse this JSON data, do
//
//     final ad = adFromJson(jsonString);

import 'dart:convert';

import 'package:uisads_app/src/models/upload.dart';


Ad adFromJson(String str) => Ad.fromJson(json.decode(str));

String adToJson(Ad data) => json.encode(data.toJson());

class Ad {
  Ad({
    this.id = '',
    required this.title,
    required this.description,
    required this.publisher,
    required this.images,
    required this.category,
    required this.state,
    required this.rating,
    required this.positivePoints,
    required this.negativePoints,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String title;
  String description;
  dynamic publisher;
  List<Upload> images;
  dynamic category;
  bool state;
  int rating;
  int positivePoints;
  int negativePoints;
  String createdAt;
  String updatedAt;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json["_id"] ?? '',
        title: json["title"],
        description: json["description"],
        publisher: json["publisher"],
        images: List<Upload>.from(json["images"].map((x) => x)),
        category: json["category"],
        state: json["state"],
        positivePoints: json["positive_points"],
        negativePoints: json["negative_pints"],
        rating: json["rating"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "publisher": publisher,
        "images": List<Upload>.from(images.map((x) => x)),
        "category": category,
        "state": state,
        "rating": rating,
        "positive_points": positivePoints,
        "negative_pints": negativePoints,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
