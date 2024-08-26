// To parse this JSON data, do
//
//     final signup = signupFromMap(jsonString);

import 'dart:convert';
import 'dart:developer';

class Signup {
  Signup({
    required this.data,
    required this.accessToken,
    required this.tokenType,
  });

  Data data;
  String accessToken;
  String tokenType;

  factory Signup.fromJson(String str) => Signup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Signup.fromMap(Map<String, dynamic> json) {
    log("testing .... map ${json}");
    return Signup(
      data: Data.fromMap(json["data"]),
      accessToken: json["access_token"],
      tokenType: json["token_type"],
    );
  }

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class Data {
  Data({
    required this.fname,
    required this.username,
    required this.sha1,
    required this.ip,
    required this.created,
    required this.userId,
  });

  String fname;
  String username;
  int sha1;
  String ip;
  DateTime created;
  int userId;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) {
    log("testing json ${json}");
    var test = Data(
      fname: json["fname"],
      username: json["username"],
      sha1: json["sha1"],
      ip: json["ip"],
      created: DateTime.now(),
      userId: json["user_id"],
    );

    log("testing json 2 ${test.toJson()}");

    return Data(
      fname: json["fname"],
      username: json["username"],
      sha1: json["sha1"],
      ip: json["ip"],
      created: DateTime.now(),
      userId: json["user_id"],
    );
  }

  Map<String, dynamic> toMap() => {
        "fname": fname,
        "username": username,
        "sha1": sha1,
        "ip": ip,
        "created": created.toIso8601String(),
        "user_id": userId,
      };
}
