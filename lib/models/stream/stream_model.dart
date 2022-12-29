// To parse this JSON data, do
//
//     final stream = streamFromJson(jsonString);

import 'dart:convert';

List<Stream> streamFromJson(String str) =>
    List<Stream>.from(json.decode(str).map((x) => Stream.fromJson(x)));

String streamToJson(List<Stream> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stream {
  Stream({
    this.url,
    this.secure,
    this.stream,
    this.topics,
    this.status,
    this.user,
    this.thumbnail,
    this.name,
  });

  String? url;
  bool? secure;
  String? stream;
  List<String?>? topics;
  bool? status;
  String? user;
  Thumbnail? thumbnail;
  String? name;

  Stream copyWith({
    String? url,
    bool? secure,
    String? stream,
    List<String?>? topics,
    bool? status,
    String? user,
    Thumbnail? thumbnail,
    String? name,
  }) =>
      Stream(
        url: url ?? this.url,
        secure: secure ?? this.secure,
        stream: stream ?? this.stream,
        topics: topics ?? this.topics,
        status: status ?? this.status,
        user: user ?? this.user,
        thumbnail: thumbnail ?? this.thumbnail,
        name: name ?? this.name,
      );

  factory Stream.fromRawJson(String str) => Stream.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stream.fromJson(Map<String, dynamic> json) => Stream(
        url: json["url"],
        secure: json["secure"],
        stream: json["stream"],
        topics: json["topics"] == null
            ? null
            : List<String>.from(json["topics"].map((x) => x)),
        status: json["status"],
        user: json["user"],
        thumbnail: json["thumbnail"] == null
            ? null
            : Thumbnail.fromJson(json["thumbnail"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "secure": secure,
        "stream": stream,
        "topics": List<String>.from(topics!.map((x) => x)),
        "status": status,
        "user": user,
        "thumbnail": thumbnail?.toJson(),
        "name": name,
      };
}

class Thumbnail {
  Thumbnail({
    this.name,
    this.size,
    this.file,
  });

  String? name;
  int? size;
  String? file;

  Thumbnail copyWith({
    String? name,
    int? size,
    String? file,
  }) =>
      Thumbnail(
        name: name ?? this.name,
        size: size ?? this.size,
        file: file ?? this.file,
      );

  factory Thumbnail.fromRawJson(String str) =>
      Thumbnail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        name: json["name"],
        size: json["size"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "size": size,
        "file": file,
      };
}
