// To parse this JSON data, do
//
//     final city = cityFromMap(jsonString);

import 'dart:convert';

City cityFromMap(String str) => City.fromMap(json.decode(str));

String cityToMap(City data) => json.encode(data.toMap());

class City {
    City({
        required this.id,
        required this.name,
    });

    String id;
    String name;

    factory City.fromMap(Map<String, dynamic> json) => City(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
    };
}
