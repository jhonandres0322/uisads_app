// To parse this JSON data, do
//
//     final responseAds = responseAdsFromMap(jsonString);

import 'dart:convert';

import 'package:uisads_app/src/models/ad.dart';

ResponseAds responseAdsFromMap(String str) => ResponseAds.fromMap(json.decode(str));

// String responseAdsToMap(ResponseAds data) => json.encode(data.toMap());

class ResponseAds {
    ResponseAds({
        required this.totalRows,
        required this.ads,
    });

    int totalRows;
    List<Ad> ads;

    factory ResponseAds.fromMap(Map<String, dynamic> json) => ResponseAds(
        totalRows: json["totalRows"] ?? 0,
        ads: List<Ad>.from( json['ads'].map( (x) => Ad.fromMap(x))),
    );

    // Map<String, dynamic> toMap() => {
    //     "totalRows": totalRows,
    //     "ads": json.encode( ads.map((e) => e.toMap() ).toList() ),
    // };
}
