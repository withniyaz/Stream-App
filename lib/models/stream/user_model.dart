// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  User({
    this.profile,
    this.id,
    this.username,
    this.providerData,
    this.uid,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Profile? profile;
  String? id;
  String? username;
  List<ProviderDatum?>? providerData;
  String? uid;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User copyWith({
    Profile? profile,
    String? id,
    String? username,
    List<ProviderDatum?>? providerData,
    String? uid,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      User(
        profile: profile ?? this.profile,
        id: id ?? this.id,
        username: username ?? this.username,
        providerData: providerData ?? this.providerData,
        uid: uid ?? this.uid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
        id: json["_id"],
        username: json["username"],
        providerData: json["providerData"] == null
            ? null
            : List<ProviderDatum>.from(
                json["providerData"].map((x) => ProviderDatum.fromJson(x))),
        uid: json["uid"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile?.toJson(),
        "_id": id,
        "username": username,
        "providerData": providerData == null
            ? null
            : List<dynamic>.from(providerData!.map((x) => x?.toJson())),
        "uid": uid,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Profile {
  Profile({
    this.name,
    this.email,
    this.profileImage,
  });

  String? name;
  String? email;
  String? profileImage;

  Profile copyWith({
    String? name,
    String? email,
    String? profileImage,
  }) =>
      Profile(
        name: name ?? this.name,
        email: email ?? this.email,
        profileImage: profileImage ?? this.profileImage,
      );

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"],
        email: json["email"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "profileImage": profileImage,
      };
}

class ProviderDatum {
  ProviderDatum({
    this.uid,
    this.displayName,
    this.email,
    this.photoUrl,
    this.providerId,
    this.phoneNumber,
  });

  String? uid;
  String? displayName;
  String? email;
  String? photoUrl;
  String? providerId;
  dynamic phoneNumber;

  ProviderDatum copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? photoUrl,
    String? providerId,
    dynamic phoneNumber,
  }) =>
      ProviderDatum(
        uid: uid ?? this.uid,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
        providerId: providerId ?? this.providerId,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory ProviderDatum.fromRawJson(String str) =>
      ProviderDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProviderDatum.fromJson(Map<String, dynamic> json) => ProviderDatum(
        uid: json["uid"],
        displayName: json["displayName"],
        email: json["email"],
        photoUrl: json["photoURL"],
        providerId: json["providerId"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "displayName": displayName,
        "email": email,
        "photoURL": photoUrl,
        "providerId": providerId,
        "phoneNumber": phoneNumber,
      };
}
