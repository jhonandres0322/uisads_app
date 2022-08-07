// To parse this JSON data, do
//
//     final requestChangePassword = requestChangePasswordFromMap(jsonString);

import 'dart:convert';

RequestChangePassword requestChangePasswordFromMap(String str) => RequestChangePassword.fromMap(json.decode(str));

String requestChangePasswordToMap(RequestChangePassword data) => json.encode(data.toMap());

class RequestChangePassword {
    RequestChangePassword({
        required this.oldPassword,
        required this.newPassword,
    });

    String oldPassword;
    String newPassword;

    factory RequestChangePassword.fromMap(Map<String, dynamic> json) => RequestChangePassword(
        oldPassword: json["oldPassword"],
        newPassword: json["newPassword"],
    );

    Map<String, dynamic> toMap() => {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
    };
}
