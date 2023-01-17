// To parse this JSON data, do
//
//     final stream = streamFromJson(jsonString);

import 'dart:convert';

import 'package:stream_app/models/stream/user_model.dart';

List<Stream> streamFromJson(String str) =>
    List<Stream>.from(json.decode(str).map((x) => Stream.fromJson(x)));

String streamToJson(List<Stream> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stream {
  Stream({
    this.streamPlayer,
    this.id,
    this.user,
    this.name,
    this.topics,
    this.thumbnail,
    this.status,
    this.live,
    this.secure,
    this.stream,
    this.url,
    this.count,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.rtmp,
  });

  StreamPlayer? streamPlayer;
  String? id;
  String? name;
  User? user;
  List<dynamic>? topics;
  Thumbnail? thumbnail;
  bool? status;
  String? live;
  bool? secure;
  String? stream;
  String? url;
  int? count;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  Rtmp? rtmp;

  Stream copyWith({
    StreamPlayer? streamPlayer,
    String? id,
    String? name,
    List<dynamic>? topics,
    Thumbnail? thumbnail,
    User? user,
    bool? status,
    String? live,
    bool? secure,
    String? stream,
    String? url,
    int? count,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    Rtmp? rtmp,
  }) =>
      Stream(
        streamPlayer: streamPlayer ?? this.streamPlayer,
        id: id ?? this.id,
        name: name ?? this.name,
        topics: topics ?? this.topics,
        thumbnail: thumbnail ?? this.thumbnail,
        user: user ?? this.user,
        status: status ?? this.status,
        live: live ?? this.live,
        secure: secure ?? this.secure,
        stream: stream ?? this.stream,
        url: url ?? this.url,
        count: count ?? this.count,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        rtmp: rtmp ?? this.rtmp,
      );

  factory Stream.fromRawJson(String str) => Stream.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stream.fromJson(Map<String, dynamic> json) => Stream(
        streamPlayer: StreamPlayer.fromJson(json["streamPlayer"]),
        id: json["_id"],
        name: json["name"],
        topics: List<dynamic>.from(json["topics"].map((x) => x) ?? []),
        thumbnail: Thumbnail?.fromJson(json["thumbnail"]),
        user: json["user"] == null ? null : User?.fromJson(json["user"]),
        status: json["status"],
        live: json["live"],
        secure: json["secure"],
        stream: json["stream"],
        url: json["url"],
        count: json["count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        rtmp: json["rtmp"] == null ? null : Rtmp?.fromJson(json["rtmp"]),
      );

  Map<String, dynamic> toJson() => {
        "streamPlayer": streamPlayer?.toJson(),
        "_id": id,
        "name": name,
        "topics": List<dynamic>.from(topics?.map((x) => x) ?? []),
        "thumbnail": thumbnail?.toJson(),
        "user": user?.toJson(),
        "status": status,
        "live": live,
        "secure": secure,
        "stream": stream,
        "url": url,
        "count": count,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "rtmp": rtmp?.toJson(),
      };
}

class Rtmp {
  Rtmp({
    this.app,
    this.flashVer,
    this.tcUrl,
    this.fpad,
    this.capabilities,
    this.audioCodecs,
    this.videoCodecs,
    this.videoFunction,
    this.rtmpId,
  });

  String? app;
  String? flashVer;
  String? tcUrl;
  bool? fpad;
  int? capabilities;
  int? audioCodecs;
  int? videoCodecs;
  int? videoFunction;
  String? rtmpId;

  Rtmp copyWith({
    String? app,
    String? flashVer,
    String? tcUrl,
    bool? fpad,
    int? capabilities,
    int? audioCodecs,
    int? videoCodecs,
    int? videoFunction,
    String? rtmpId,
  }) =>
      Rtmp(
        app: app ?? this.app,
        flashVer: flashVer ?? this.flashVer,
        tcUrl: tcUrl ?? this.tcUrl,
        fpad: fpad ?? this.fpad,
        capabilities: capabilities ?? this.capabilities,
        audioCodecs: audioCodecs ?? this.audioCodecs,
        videoCodecs: videoCodecs ?? this.videoCodecs,
        videoFunction: videoFunction ?? this.videoFunction,
        rtmpId: rtmpId ?? this.rtmpId,
      );

  factory Rtmp.fromRawJson(String str) => Rtmp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rtmp.fromJson(Map<String, dynamic> json) => Rtmp(
        app: json["app"],
        flashVer: json["flashVer"],
        tcUrl: json["tcUrl"],
        fpad: json["fpad"],
        capabilities: json["capabilities"],
        audioCodecs: json["audioCodecs"],
        videoCodecs: json["videoCodecs"],
        videoFunction: json["videoFunction"],
        rtmpId: json["rtmpId"],
      );

  Map<String, dynamic> toJson() => {
        "app": app,
        "flashVer": flashVer,
        "tcUrl": tcUrl,
        "fpad": fpad,
        "capabilities": capabilities,
        "audioCodecs": audioCodecs,
        "videoCodecs": videoCodecs,
        "videoFunction": videoFunction,
        "rtmpId": rtmpId,
      };
}

class StreamPlayer {
  StreamPlayer({
    this.play,
    this.mute,
    this.camera,
  });

  bool? play;
  bool? mute;
  String? camera;

  StreamPlayer copyWith({
    bool? play,
    bool? mute,
    String? camera,
  }) =>
      StreamPlayer(
        play: play ?? this.play,
        mute: mute ?? this.mute,
        camera: camera ?? this.camera,
      );

  factory StreamPlayer.fromRawJson(String str) =>
      StreamPlayer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StreamPlayer.fromJson(Map<String, dynamic> json) => StreamPlayer(
        play: json["play"],
        mute: json["mute"],
        camera: json["camera"],
      );

  Map<String, dynamic> toJson() => {
        "play": play,
        "mute": mute,
        "camera": camera,
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
