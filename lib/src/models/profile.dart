// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.name,
    required this.cellphone,
    required this.city,
    required this.image,
    required this.state,
    required this.description,
    required this.user,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  String name;
  String cellphone;
  String city;
  dynamic image;
  bool state;
  String description;
  dynamic user;
  dynamic rating;
  DateTime createdAt;
  DateTime updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"],
        cellphone: json["cellphone"],
        city: json["city"],
        image: json["image"],
        state: json["state"],
        description: json["description"],
        user: json["user"],
        rating: json["rating"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "cellphone": cellphone,
        "city": city,
        "image": image,
        "state": state,
        "description": description,
        "user": user,
        "rating": rating,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
