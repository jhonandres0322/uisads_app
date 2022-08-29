// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';

UserRegister userRegisterFromJson(String str) => UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
    UserRegister({
        required this.name,
        required this.email,
        required this.city,
        required this.password,
        required this.cellphone,
    });

    String name;
    String email;
    String city;
    String password;
    String cellphone;

    factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        name: json["name"],
        email: json["email"],
        city: json["city"],
        password: json["password"],
        cellphone: json["cellphone"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "city": city,
        "password": password,
        "cellphone": cellphone,
    };
}
