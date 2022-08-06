// To parse this JSON data, do
//
//     final ad = adFromMap(jsonString);

import 'dart:convert';

import 'package:uisads_app/src/models/upload.dart';


Ad adFromMap(String str) => Ad.fromMap(json.decode(str));

String adToMap(Ad data) => json.encode(data.toMap());

class Ad {
    Ad({
        required this.id,
        required this.title,
        required this.description,
        required this.publisher,
        required this.images,
        required this.mainPage,
        required this.category,
        required this.state,
        required this.visible,
        required this.positvePoints,
        required this.negativePoints,
        required this.rating,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String title;
    String description;
    String publisher;
    List<Upload> images;
    Upload mainPage;
    String category;
    bool state;
    bool visible;
    int positvePoints;
    int negativePoints;
    int rating;
    String createdAt;
    String updatedAt;

    factory Ad.fromMap(Map<String, dynamic> json) => Ad(
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        publisher: json["publisher"] ?? '',
        images: json['images'] ?? [],
        mainPage: Upload.fromMap( json['main_page'] ?? {} ) ,
        category: json["category"] ?? '',
        state: json["state"] ?? true,
        visible: json["visible"] ?? true,
        positvePoints: json["positive_points"] ?? 0,
        negativePoints: json["negative_points"] ?? 0,
        rating: json["rating"] ?? 0,
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "description": description,
        "publisher": publisher,
        "images":   json.encode( images.map((e) => e.toMap() ).toList() ) ,
        "main_page": json.encode( mainPage.toMap() ),
        "category": category,
        "state": state.toString(),
        "visible": visible.toString(),
        "positvePoints": positvePoints.toString(),
        "negativePoints": negativePoints.toString(),
        "rating": rating.toString(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}
