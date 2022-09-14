// To parse this JSON data, do
//
//     final profile = profileFromMap(jsonString);

import 'dart:convert';

import 'package:uisads_app/src/constants/import_models.dart';

Profile profileFromMap(String str) => Profile.fromMap(json.decode(str));

String profileToMap(Profile data) => json.encode(data.toMap());
class Profile {
    Profile({
        this.interests = const [],
        this.notifications = const [],
        this.favorites = const [],
        required this.isNotify,
        required this.name,
        required this.cellphone,
        required this.email,
        required this.state,
        required this.score,
        required this.city,
        required this.image,
        required this.createdAt,
        required this.updatedAt,
        required this.description,
        required this.uid,
    });
    // El dynamic es para que acepte cualquier tipo de dato pero es un tipo Ad
    List<String> interests;
    List<dynamic> notifications;
    List<dynamic> favorites;
    bool isNotify;
    String name;
    String cellphone;
    String email;
    bool state;
    int score;
    String city;
    Upload image;
    String createdAt;
    String updatedAt;
    String description;
    String uid;

    factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        // interests: (List<String>.from(json["interests"].map((x) => x))) ?? [],
        // notifications: List<dynamic>.from(json["notifications"].map((x) => x)) ?? [],
        // favorites: List<dynamic>.from(json["favorites"].map((x) => x)) ?? [],
        isNotify: json["isNotify"] ?? false,
        name: json["name"] ?? '',
        cellphone: json["cellphone"] ?? '',
        email: json["email"] ?? '',
        state: json["state"] ?? true,
        score: json["score"] ?? 0,
        city: json["city"] ?? '',
        image: Upload.fromMap( json["image"] ?? {}),
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        description: json["description"] ?? '',
        uid: json["uid"] ?? '',
    );

    Map<String, dynamic> toMap() => {
        // "interests": List<String>.from(interests.map((x) => x)),
        // "notifications": List<dynamic>.from(notifications.map((x) => x)),
        // "favorites": List<dynamic>.from(favorites.map((x) => x)),
        "isNotify": isNotify,
        "name": name,
        "cellphone": cellphone,
        "email": email,
        "state": state.toString(),
        "score": score.toString(),
        "city": city,
        "image":  json.encode( image.toMap() ),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "description": description,
        "uid": uid,
    };
}
