// To parse this JSON data, do
//
//     final requestInterest = requestInterestFromJson(jsonString);

import 'dart:convert';

RequestInterest requestInterestFromJson(String str) => RequestInterest.fromJson(json.decode(str));

String requestInterestToJson(RequestInterest data) => json.encode(data.toJson());

class RequestInterest {
    RequestInterest({
        required this.interests,
    });

    List<String> interests;

    factory RequestInterest.fromJson(Map<String, dynamic> json) => RequestInterest(
        interests: List<String>.from(json["interests"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "interests": json.encode(List<String>.from(interests.map((x) => x))),
    };
}
