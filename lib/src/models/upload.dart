// To parse this JSON data, do
//
//     final upload = uploadFromJson(jsonString);

import 'dart:convert';

Upload uploadFromJson(String str) => Upload.fromJson(json.decode(str));

String uploadToJson(Upload data) => json.encode(data.toJson());

class Upload {
    Upload({
        required this.name,
        required this.type,
        required this.content,
    });

    String name;
    String type;
    String content;

    factory Upload.fromJson(Map<String, dynamic> json) => Upload(
        name: json["name"],
        type: json["type"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "content": content,
    };
}
