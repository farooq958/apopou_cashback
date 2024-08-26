// To parse this JSON data, do
//
//     final loginModel = loginModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class LoginModel {
  LoginModel({
    required this.data,
    required this.accessToken,
    required this.tokenType,
  });

  Data data;
  String accessToken;
  String tokenType;

  factory LoginModel.fromJson(String str) => LoginModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
    data: Data.fromMap(json["data"]),
    accessToken: json["access_token"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toMap() => {
    "data": data.toMap(),
    "access_token": accessToken,
    "token_type": tokenType,
  };
}

class Data {
  Data({
    required this.userId,
    required this.username,
    required this.email,
    required this.fname,
    required this.lname,
    required this.gender,
    required this.address,
    required this.address2,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
    required this.phone,
    required this.paymentMethod,
    required this.regSource,
    required this.refClicks,
    required this.refId,
    required this.refBonus,
    required this.newsletter,
    required this.ip,
    required this.status,
    required this.authProvider,
    required this.authUid,
    required this.unsubscribeKey,
    required this.loginSession,
    required this.lastLogin,
    required this.loginCount,
    required this.lastIp,
    required this.created,
    required this.blockReason,
    required this.validated,
    required this.sha1,
    required this.providerName,
    required this.providerId,
    required this.deletedAt,
  });

  int userId;
  String username;
  String email;
  String fname;
  String lname;
  String gender;
  String address;
  String address2;
  String city;
  String state;
  String zip;
  int country;
  String phone;
  String paymentMethod;
  String regSource;
  int refClicks;
  int refId;
  int refBonus;
  int newsletter;
  String ip;
  String status;
  String authProvider;
  String authUid;
  String unsubscribeKey;
  String loginSession;
  dynamic lastLogin;
  int loginCount;
  String lastIp;
  DateTime created;
  dynamic blockReason;
  int validated;
  int sha1;
  dynamic providerName;
  dynamic providerId;
  dynamic deletedAt;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    username: json["username"],
    email: json["email"],
    fname: json["fname"],
    lname: json["lname"],
    gender: json["gender"],
    address: json["address"],
    address2: json["address2"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
    country: json["country"],
    phone: json["phone"],
    paymentMethod: json["payment_method"],
    regSource: json["reg_source"],
    refClicks: json["ref_clicks"],
    refId: json["ref_id"],
    refBonus: json["ref_bonus"],
    newsletter: json["newsletter"],
    ip: json["ip"],
    status: json["status"],
    authProvider: json["auth_provider"],
    authUid: json["auth_uid"],
    unsubscribeKey: json["unsubscribe_key"],
    loginSession: json["login_session"],
    lastLogin: json["last_login"],
    loginCount: json["login_count"],
    lastIp: json["last_ip"],
    created: DateTime.parse(json["created"]),
    blockReason: json["block_reason"],
    validated: json["validated"],
    sha1: json["sha1"],
    providerName: json["provider_name"],
    providerId: json["provider_id"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toMap() => {
    "user_id": userId,
    "username": username,
    "email": email,
    "fname": fname,
    "lname": lname,
    "gender": gender,
    "address": address,
    "address2": address2,
    "city": city,
    "state": state,
    "zip": zip,
    "country": country,
    "phone": phone,
    "payment_method": paymentMethod,
    "reg_source": regSource,
    "ref_clicks": refClicks,
    "ref_id": refId,
    "ref_bonus": refBonus,
    "newsletter": newsletter,
    "ip": ip,
    "status": status,
    "auth_provider": authProvider,
    "auth_uid": authUid,
    "unsubscribe_key": unsubscribeKey,
    "login_session": loginSession,
    "last_login": lastLogin,
    "login_count": loginCount,
    "last_ip": lastIp,
    "created": created.toIso8601String(),
    "block_reason": blockReason,
    "validated": validated,
    "sha1": sha1,
    "provider_name": providerName,
    "provider_id": providerId,
    "deleted_at": deletedAt,
  };
}
