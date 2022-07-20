// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.id = '',
    this.name = '',
    this.cellphone = '',
    this.city = '',
    this.image = '',
    this.description = '',
    this.user,
    this.score,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String name;
  String cellphone;
  String city;
  dynamic image;
  String description;
  dynamic user;
  dynamic score;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["uid"] ?? '',
        name: json["name"] ?? '',
        cellphone: json["cellphone"] ?? '',
        city: json["city"] ?? '',
        image: json["image"] ?? '',
        description: json["description"] ?? ''  ,
        user: json["user"] ?? '',
        score: json["score"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cellphone": cellphone,
        "city": city,
        "image": image,
        "description": description,
        "user": user,
        "score": score,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
