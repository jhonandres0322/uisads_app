// To parse this JSON data, do
//
//     final userRequest = userRequestFromJson(jsonString);

import 'dart:convert';

UserRequest userRequestFromJson(String str) =>
    UserRequest.fromJson(json.decode(str));

String userRequestToJson(UserRequest data) => json.encode(data.toJson());

class UserRequest {
  UserRequest({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  @override
  String toString() => "email --> $email --- password $password";
  
}
