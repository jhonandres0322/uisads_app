// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
    User({
        required this.state,
        required this.retry,
        required this.blocked,
        required this.firstEntry,
        required this.email,
        required this.createdAt,
        required this.updatedAt,
        required this.available,
        required this.lastEntry,
        required this.uid,
    });

    bool state;
    int retry;
    bool blocked;
    String firstEntry;
    String email;
    String createdAt;
    String updatedAt;
    bool available;
    String lastEntry;
    String uid;

    factory User.fromMap(Map<String, dynamic> json) => User(
        state: json["state"] ?? true,
        retry: json["retry"] ?? 0,
        blocked: json["blocked"] ?? false,
        firstEntry: json["firstEntry"] ?? '',
        email: json["email"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        available: json["available"] ?? true,
        lastEntry: json["lastEntry"] ?? '',
        uid: json["uid"] ?? '',
    );

    Map<String, dynamic> toMap() => {
        "state": state,
        "retry": retry,
        "blocked": blocked,
        "firstEntry": firstEntry,
        "email": email,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "available": available,
        "lastEntry": lastEntry,
        "uid": uid,
    };
}
