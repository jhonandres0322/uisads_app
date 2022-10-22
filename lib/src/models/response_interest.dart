// To parse this JSON data, do
//
//     final responseInterest = responseInterestFromJson(jsonString);

import 'dart:convert';

ResponseInterest responseInterestFromJson(String str) => ResponseInterest.fromJson(json.decode(str));

String responseInterestToJson(ResponseInterest data) => json.encode(data.toJson());

class ResponseInterest {
    ResponseInterest({
        required this.interests,
        this.error,
    });

    List<String> interests;
    bool? error;

    factory ResponseInterest.fromJson(Map<String, dynamic> json) => ResponseInterest(
        interests: List<String>.from(json["interests"].map((x) => x)),
        error: json["error"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "interests": List<dynamic>.from(interests.map((x) => x))
    };
}
