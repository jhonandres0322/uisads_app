// To parse this JSON data, do
//
//     final responseAds = responseAdsFromMap(jsonString);

import 'dart:convert';



import 'package:uisads_app/src/constants/import_models.dart';


ResponseFavoriteAds responseAdsFromMap(String str) => ResponseFavoriteAds.fromMap(json.decode(str));

// String responseAdsToMap(ResponseAds data) => json.encode(data.toMap());

class ResponseFavoriteAds {
    ResponseFavoriteAds({
        required this.totalRows,
        required this.favorites,
    });

    int totalRows;
    List<Ad> favorites;

    factory ResponseFavoriteAds.fromMap(Map<String, dynamic> json) => ResponseFavoriteAds(
        totalRows: json["totalRows"] ?? 0,
        favorites: List<Ad>.from( json['favorites'].map( (x) => Ad.fromMap(x))),
    );

    // Map<String, dynamic> toJson() => {
    //     "totalRows": totalRows,
    //     "favorites": List<Ad>.from(favorites.map((x) => x)),
    // };
}