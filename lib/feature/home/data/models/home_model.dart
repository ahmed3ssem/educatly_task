// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

List<HomeModel> homeModelFromJson(String str) => List<HomeModel>.from(json.decode(str).map((x) => HomeModel.fromJson(x)));

String homeModelToJson(List<HomeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeModel {
  String uid;
  String email;
  bool emailVerified;
  bool disabled;
  Metadata metadata;
  String passwordHash;
  String passwordSalt;
  String tokensValidAfterTime;
  List<ProviderDatum> providerData;

  HomeModel({
    required this.uid,
    required this.email,
    required this.emailVerified,
    required this.disabled,
    required this.metadata,
    required this.passwordHash,
    required this.passwordSalt,
    required this.tokensValidAfterTime,
    required this.providerData,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    uid: json["uid"],
    email: json["email"],
    emailVerified: json["emailVerified"],
    disabled: json["disabled"],
    metadata: Metadata.fromJson(json["metadata"]),
    passwordHash: json["passwordHash"],
    passwordSalt: json["passwordSalt"],
    tokensValidAfterTime: json["tokensValidAfterTime"],
    providerData: List<ProviderDatum>.from(json["providerData"].map((x) => ProviderDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "emailVerified": emailVerified,
    "disabled": disabled,
    "metadata": metadata.toJson(),
    "passwordHash": passwordHash,
    "passwordSalt": passwordSalt,
    "tokensValidAfterTime": tokensValidAfterTime,
    "providerData": List<dynamic>.from(providerData.map((x) => x.toJson())),
  };
}

class Metadata {
  String lastSignInTime;
  String creationTime;
  String lastRefreshTime;

  Metadata({
    required this.lastSignInTime,
    required this.creationTime,
    required this.lastRefreshTime,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    lastSignInTime: json["lastSignInTime"],
    creationTime: json["creationTime"],
    lastRefreshTime: json["lastRefreshTime"],
  );

  Map<String, dynamic> toJson() => {
    "lastSignInTime": lastSignInTime,
    "creationTime": creationTime,
    "lastRefreshTime": lastRefreshTime,
  };
}

class ProviderDatum {
  String uid;
  String email;
  String providerId;

  ProviderDatum({
    required this.uid,
    required this.email,
    required this.providerId,
  });

  factory ProviderDatum.fromJson(Map<String, dynamic> json) => ProviderDatum(
    uid: json["uid"],
    email: json["email"],
    providerId: json["providerId"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "providerId": providerId,
  };
}
