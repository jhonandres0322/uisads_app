// To parse this JSON data, do
//
//     final profile = profileFromMap(jsonString);

import 'dart:convert';

Profile profileFromMap(String str) => Profile.fromMap(json.decode(str));

String profileToMap(Profile data) => json.encode(data.toMap());

class Profile {
    Profile({
        required this.name,
        required this.cellphone,
        required this.email,
        required this.state,
        required this.score,
        required this.city,
        required this.createdAt,
        required this.updatedAt,
        required this.description,
        required this.uid,
    });

    String name;
    String cellphone;
    String email;
    bool state;
    int score;
    String city;
    String createdAt;
    String updatedAt;
    String description;
    String uid;

    factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        name: json["name"] ?? '',
        cellphone: json["cellphone"] ?? '',
        email: json["email"] ?? '',
        state: json["state"] ?? true,
        score: json["score"] ?? 0,
        city: json["city"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        description: json["description"] ?? '',
        uid: json["uid"] ?? '',
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "cellphone": cellphone,
        "email": email,
        "state": state.toString(),
        "score": score.toString(),
        "city": city,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "description": description,
        "uid": uid,
    };
}
