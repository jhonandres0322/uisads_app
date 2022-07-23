// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromMap(jsonString);

import 'dart:convert';

import 'package:uisads_app/src/models/profile.dart';
import 'package:uisads_app/src/models/user.dart';

RegisterResponse registerResponseFromMap(String str) => RegisterResponse.fromMap(json.decode(str));

String registerResponseToMap(RegisterResponse data) => json.encode(data.toMap());

class RegisterResponse {
    RegisterResponse({
        required this.msg,
        required this.error,
        required this.token,
        required this.user,
        required this.profile,
    });

    String msg;
    bool error;
    String token;
    User user;
    Profile profile;

    factory RegisterResponse.fromMap(Map<String, dynamic> json) => RegisterResponse(
        msg: json["msg"] ?? '',
        error: json["error"] ?? false,
        token: json["token"] ?? '',
        user: User.fromMap(json["user"] ?? {}),
        profile: Profile.fromMap( json["profile"] ?? {}),
    );

    Map<String, dynamic> toMap() => {
        "msg": msg,
        "error": error,
        "token": token,
        "user": user,
        "profile": profile,
    };
}
