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
        required this.category,
        required this.state,
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
    String category;
    bool state;
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
        images: json['images'] ,
        category: json["category"] ?? '',
        state: json["state"] ?? true,
        positvePoints: json["positvePoints"] ?? 0,
        negativePoints: json["negativePoints"] ?? 0,
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
        "category": category,
        "state": state.toString(),
        "positvePoints": positvePoints.toString(),
        "negativePoints": negativePoints.toString(),
        "rating": rating.toString(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}
