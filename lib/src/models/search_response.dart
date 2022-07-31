// To parse this JSON data, do
//
//     final searchResponse = searchResponsefromMap(jsonString);

import 'dart:convert';

import 'package:uisads_app/src/models/ad.dart';

SearchResponse searchResponsefromMap(String str) =>
    SearchResponse.fromMap(json.decode(str));

// String searchResponseToMap(SearchResponse data) => json.encode(data.toMap());

class SearchResponse {
  SearchResponse({
    required this.totalRows,
    required this.ads,
  });

  int totalRows;
  List<Ad> ads;

  factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        totalRows: json["totalRows"],
        ads: List<Ad>.from(json["ads"].map((x) => Ad.fromMapper(x)).toList()),
      );

  // Map<String, dynamic> toMap() => {
  //     "totalRows": totalRows,
  //     "ads": List<dynamic>.from(ads.map((x) => x.toMap())),
  // };
}
