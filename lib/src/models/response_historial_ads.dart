
// To parse this JSON data, do
//
//     final responseHistorialAds = responseHistorialAdsFromMap(jsonString);

import 'dart:convert';

import 'package:uisads_app/src/models/ad.dart';

ResponseHistorialAds responseHistorialAdsFromMap(String str) => ResponseHistorialAds.fromMap(json.decode(str));

String responseHistorialAdsToMap(ResponseHistorialAds data) => json.encode(data.toMap());

class ResponseHistorialAds {
    ResponseHistorialAds({
        required this.historial,
        required this.totalRows,
    });

    List<Ad> historial;
    int totalRows;

    factory ResponseHistorialAds.fromMap(Map<String, dynamic> json) => ResponseHistorialAds(
        historial: List<Ad>.from(json["historial"].map((x) => x)),
        totalRows: json["totalRows"] ?? 0,
    );

    Map<String, dynamic> toMap() => {
        "historial": List<Ad>.from(historial.map((x) => x)),
        "totalRows": totalRows,
    };
}
