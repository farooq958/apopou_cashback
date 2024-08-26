// To parse this JSON data, do
//
//     final subscriptionAmount = subscriptionAmountFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SubscriptionAmount subscriptionAmountFromJson(String str) => SubscriptionAmount.fromJson(json.decode(str));

String subscriptionAmountToJson(SubscriptionAmount data) => json.encode(data.toJson());

class SubscriptionAmount {
  final bool success;
  final String data;

  SubscriptionAmount({
    required this.success,
    required this.data,
  });

  factory SubscriptionAmount.fromJson(Map<String, dynamic> json) => SubscriptionAmount(
    success: json["success"],
    data: (double.parse(json["data"])/100).toStringAsFixed(2).toString(),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
  };
}
