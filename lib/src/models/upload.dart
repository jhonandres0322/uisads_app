// To parse this JSON data, do
//
//     final upload = uploadFromMap(jsonString);

import 'dart:convert';
List<Upload> uploadsFromMap(List<dynamic> list) => List<Upload>.from(list.map((x) => Upload.fromMapper(x.toString())));

Upload uploadFromMap(String str) => Upload.fromMap(json.decode(str));
// Upload uploadFromMapper(String str) => Upload.fromMapper(str);

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
    // Temporal
    factory Upload.fromMapper(String str) => Upload(
        id: str,
        // content: json["content"] ?? '',
        // type: json["type"] ?? '',
        // name: json["name"] ?? '',
        // index: json["index"] ?? ''
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "content": content,
        "type": type,
        "name": name,
        "index": index
    };
}
