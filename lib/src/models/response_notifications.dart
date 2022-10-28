// To parse this JSON data, do
//
//     final responseAds = responseAdsFromMap(jsonString);

import 'dart:convert';

import 'package:uisads_app/src/constants/import_models.dart';

ResponseNotificationAds responseNotificationsAdsFromMap(String str) => ResponseNotificationAds.fromMap(json.decode(str));

// String responseAdsToMap(ResponseAds data) => json.encode(data.toMap());

class ResponseNotificationAds {
    ResponseNotificationAds({
        required this.totalRows,
        required this.notifications,
    });

    int totalRows;
    List<Ad> notifications;

    factory ResponseNotificationAds.fromMap(Map<String, dynamic> json) => ResponseNotificationAds(
        totalRows: json["totalRows"] ?? 0,
        notifications: List<Ad>.from( json['notifications'].map( (x) => Ad.fromMap(x))),
    );

    // Map<String, dynamic> toMap() => {
    //     "totalRows": totalRows,
    //     "ads": json.encode( ads.map((e) => e.toMap() ).toList() ),
    // };
}