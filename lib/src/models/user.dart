// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.email,
    required this.state,
    required this.retry,
    required this.blocked,
    required this.firstEntry,
    required this.lastEntry,
    required this.available,
    this.otp = '',
    required this.createdAt,
    required this.updatedAt,
  });

  String email;
  bool state = true;
  int retry = 0;
  bool blocked = false;
  DateTime firstEntry;
  DateTime lastEntry;
  bool available;
  String otp;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        state: json["state"],
        retry: json["retry"],
        blocked: json["blocked"],
        firstEntry: DateTime.parse(json["firstEntry"]),
        lastEntry: DateTime.parse(json["lastEntry"]),
        available: json["available"],
        otp: json["otp"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "state": state,
        "retry": retry,
        "blocked": blocked,
        "firstEntry": firstEntry.toIso8601String(),
        "lastEntry": lastEntry.toIso8601String(),
        "available": available,
        "otp": otp,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
