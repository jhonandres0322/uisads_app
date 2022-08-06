// To parse this JSON data, do
//
//     final requestManageCalification = requestManageCalificationFromMap(jsonString);

import 'dart:convert';

RequestManageCalification requestManageCalificationFromMap(String str) => RequestManageCalification.fromMap(json.decode(str));

String requestManageCalificationToMap(RequestManageCalification data) => json.encode(data.toMap());

class RequestManageCalification {
    RequestManageCalification({
        required this.choice,
        required this.adId,
    });

    String choice;
    String adId;

    factory RequestManageCalification.fromMap(Map<String, dynamic> json) => RequestManageCalification(
        choice: json["choice"],
        adId: json["ad"],
    );

    Map<String, dynamic> toMap() => {
        "choice": choice,
        "adId": adId,
    };
}
