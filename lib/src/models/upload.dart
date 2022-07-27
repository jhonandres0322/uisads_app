// To parse this JSON data, do
//
//     final upload = uploadFromMap(jsonString);

import 'dart:convert';

Upload uploadFromMap(String str) => Upload.fromMap(json.decode(str));

String uploadToMap(Upload data) => json.encode(data.toMap());

class Upload {
    Upload({
        this.id = '',
        this.content = '',
        this.type = '',
        this.name = '',
        this.index = ''
    });

    String id;
    String content;
    String type;
    String name;
    String index;

    factory Upload.fromMap(Map<String, dynamic> json) => Upload(
        id: json["_id"] ?? '',
        content: json["content"] ?? '',
        type: json["type"] ?? '',
        name: json["name"] ?? '',
        index: json["index"] ?? ''
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "content": content,
        "type": type,
        "name": name,
        "index": index
    };
}
