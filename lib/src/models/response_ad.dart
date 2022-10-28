// To parse this JSON data, do
//
//     final responseAdUnique = responseAdUniqueFromMap(jsonString);

import 'dart:convert';

import 'package:uisads_app/src/constants/import_models.dart';

ResponseAdUnique responseAdUniqueFromMap(String str) => ResponseAdUnique.fromMap(json.decode(str));

String responseAdUniqueToMap(ResponseAdUnique data) => json.encode(data.toMap());

class ResponseAdUnique {
    ResponseAdUnique({
        required this.ad,
        required this.showFavorite,
    });

    Ad ad;
    bool showFavorite;

    factory ResponseAdUnique.fromMap(Map<String, dynamic> json) => ResponseAdUnique(
        ad: Ad.fromMap(json["ad"]),
        showFavorite: json["showFavorite"],
    );

    Map<String, dynamic> toMap() => {
        "ad": ad.toMap(),
        "showFavorite": showFavorite,
    };
}