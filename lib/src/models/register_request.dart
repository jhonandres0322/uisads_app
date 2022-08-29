// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromMap(jsonString);

import 'dart:convert';

RegisterRequest registerRequestFromMap(String str) => RegisterRequest.fromMap(json.decode(str));

String registerRequestToMap(RegisterRequest data) => json.encode(data.toMap());

class RegisterRequest {
    RegisterRequest({
        required this.name,
        required this.cellphone,
        required this.email,
        required this.city,
        required this.password,
    });

    String name;
    String cellphone;
    String email;
    String city;
    String password;

    factory RegisterRequest.fromMap(Map<String, dynamic> json) => RegisterRequest(
        name: json["name"] ?? '',
        cellphone: json["cellphone"] ?? '',
        email: json["email"] ?? '',
        city: json["city"] ?? '',
        password: json["password"] ?? '',
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "cellphone": cellphone,
        "email": email,
        "city": city,
        "password": password,
    };
}
