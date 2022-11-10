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
         this.user,
         this.profile,
         this.token,
        required this.error
    });

    String message;
    User? user;
    Profile? profile;
    String? token;
    bool error;

    factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        message: json["msg"] ?? '',
        user: json["user"] != null ? User.fromMap(json["user"] ?? {}): null,
        profile: json["profile"] != null ? Profile.fromMap( json["profile"] ?? {}) : null,
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
