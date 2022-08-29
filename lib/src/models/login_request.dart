// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromMap(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromMap(String str) => LoginRequest.fromMap(json.decode(str));

String loginRequestToMap(LoginRequest data) => json.encode(data.toMap());

class LoginRequest {
    LoginRequest({
        required this.email,
        required this.password,
    });

    String email;
    String password;

    factory LoginRequest.fromMap(Map<String, dynamic> json) => LoginRequest(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
    };
}
