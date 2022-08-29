// To parse this JSON data, do
//
//     final searchRequest = searchRequestFromJson(jsonString);

import 'dart:convert';

SearchRequest searchRequestFromJson(String str) => SearchRequest.fromJson(json.decode(str));

String searchRequestToJson(SearchRequest data) => json.encode(data.toJson());

class SearchRequest {
    SearchRequest({
        required this.query,
        this.publisher,
        this.time,
        this.category,
        this.order,
    });

    String  query;
    String? publisher;
    String? time;
    String? category;
    String? order;

    factory SearchRequest.fromJson(Map<String, dynamic> json) => SearchRequest(
        query: json["query"] ?? '',
        publisher: json["publisher"] ?? '',
        time: json["time"] ?? '',
        category: json["category"]?? '',
        order: json["order"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "query": query,
        "publisher": publisher ?? '',
        "time": time ?? '',
        "category": category ?? '',
        "order": order ?? '',
    };
}
