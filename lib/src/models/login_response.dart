// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromMap(jsonString);

import 'dart:convert';

import 'package:uisads_app/src/constants/import_models.dart';

LoginResponse loginResponseFromMap(String str) => LoginResponse.fromMap(json.decode(str));

String loginResponseToMap(LoginResponse data) => json.encode(data.toMap());

class LoginResponse {
    LoginResponse({
        required this.message,
        required this.user,
        required this.profile,
        required this.token,
        required this.error
    });

    String message;
    User user;
    Profile profile;
    String token;
    bool error;

    factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        message: json["msg"] ?? '',
        user: User.fromMap(json["user"] ?? {}),
        profile: Profile.fromMap( json["profile"] ?? {}),
        token: json["token"] ?? '',
        error: json["error"] ?? ''
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "user": user,
        "profile": profile,
        "token": token,
        "error": error
    };
}
