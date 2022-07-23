// To parse this JSON data, do
//
//     final response = responseFromMap(jsonString);

import 'dart:convert';

Response responseFromMap(String str) => Response.fromMap(json.decode(str));

String responseToMap(Response data) => json.encode(data.toMap());

class Response {
    Response({
        required this.message,
        required this.error,
    });

    String message;
    bool error;

    factory Response.fromMap(Map<String, dynamic> json) => Response(
        message: json["msg"] ?? '',
        error: json["error"] ?? true,
    );

    Map<String, dynamic> toMap() => {
        "msg": message,
        "error": error,
    };
}
