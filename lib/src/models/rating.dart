// To parse this JSON data, do
//
//     final rating = ratingFromJson(jsonString);

import 'dart:convert';

Rating ratingFromJson(String str) => Rating.fromJson(json.decode(str));

String ratingToJson(Rating data) => json.encode(data.toJson());

class Rating {
  Rating({
    required this.score,
    required this.positivePoints,
    required this.negativePoints,
    required this.createdAt,
    required this.updatedAt,
  });

  int score;
  int positivePoints;
  int negativePoints;
  DateTime createdAt;
  DateTime updatedAt;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        score: json["score"],
        positivePoints: json["positive_points"],
        negativePoints: json["negative_points"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "positive_points": positivePoints,
        "negative_points": negativePoints,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
