// To parse this JSON data, do
//
//     final responseScoreProfile = responseScoreProfileFromMap(jsonString);

import 'dart:convert';

ResponseScoreProfile responseScoreProfileFromMap(String str) => ResponseScoreProfile.fromMap(json.decode(str));

String responseScoreProfileToMap(ResponseScoreProfile data) => json.encode(data.toMap());

class ResponseScoreProfile {
    ResponseScoreProfile({
        required this.publications,
        required this.score,
        required this.calification,
    });

    int publications;
    int score;
    int calification;

    factory ResponseScoreProfile.fromMap(Map<String, dynamic> json) => ResponseScoreProfile(
        publications: json["publications"],
        score: json["score"],
        calification: json["calification"],
    );

    Map<String, dynamic> toMap() => {
        "publications": publications,
        "score": score,
        "calification": calification,
    };
}
