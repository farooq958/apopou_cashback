// To parse this JSON data, do
//
//     final subscriptionAmount = subscriptionAmountFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WalletUrl walletUrlFromJson(String str) => WalletUrl.fromJson(json.decode(str));

String walletUrlToJson(WalletUrl data) => json.encode(data.toJson());

class WalletUrl {
  final bool success;
  final String data;

  WalletUrl({
    required this.success,
    required this.data,
  });

  factory WalletUrl.fromJson(Map<String, dynamic> json) => WalletUrl(
    success: json["success"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
  };
}
