// To parse this JSON data, do
//
//     final unsubscribeModel = unsubscribeModelFromMap(jsonString);

import 'dart:convert';

UnsubscribeModel unsubscribeModelFromMap(String str) => UnsubscribeModel.fromMap(json.decode(str));

String unsubscribeModelToMap(UnsubscribeModel data) => json.encode(data.toMap());

class UnsubscribeModel {
  final bool? success;
  final Data? data;
  final String? message;

  UnsubscribeModel({
    this.success,
    this.data,
    this.message,
  });

  factory UnsubscribeModel.fromMap(Map<String, dynamic> json) => UnsubscribeModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "data": data?.toMap(),
    "message": message,
  };
}

class Data {
  final int? id;
  final int? userId;
  final String? paymentEmail;
  final String? paymentMethod;
  final String? orderCode;
  final String? initialTransactionId;
  final DateTime? initialpaymentAt;
  final String? initialAmount;
  final String? latestTransactionId;
  final DateTime? latestpaymentAt;
  final String? latestAmount;
  final String? latestStatusId;
  final String? reason;
  final String? details;
  final DateTime? activatedAt;
  final DateTime? expiredAt;
  final dynamic latestFailedAttemptAt;
  final int? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.paymentEmail,
    this.paymentMethod,
    this.orderCode,
    this.initialTransactionId,
    this.initialpaymentAt,
    this.initialAmount,
    this.latestTransactionId,
    this.latestpaymentAt,
    this.latestAmount,
    this.latestStatusId,
    this.reason,
    this.details,
    this.activatedAt,
    this.expiredAt,
    this.latestFailedAttemptAt,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    paymentEmail: json["payment_email"],
    paymentMethod: json["payment_method"],
    orderCode: json["orderCode"],
    initialTransactionId: json["initial_transaction_id"],
    initialpaymentAt: json["initialpayment_at"] == null ? null : DateTime.parse(json["initialpayment_at"]),
    initialAmount: json["initial_amount"],
    latestTransactionId: json["latest_transaction_id"],
    latestpaymentAt: json["latestpayment_at"] == null ? null : DateTime.parse(json["latestpayment_at"]),
    latestAmount: json["latest_amount"],
    latestStatusId: json["latest_StatusID"],
    reason: json["reason"],
    details: json["details"],
    activatedAt: json["activated_at"] == null ? null : DateTime.parse(json["activated_at"]),
    expiredAt: json["expired_at"] == null ? null : DateTime.parse(json["expired_at"]),
    latestFailedAttemptAt: json["latest_failed_attempt_at"],
    isActive: json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "payment_email": paymentEmail,
    "payment_method": paymentMethod,
    "orderCode": orderCode,
    "initial_transaction_id": initialTransactionId,
    "initialpayment_at": initialpaymentAt?.toIso8601String(),
    "initial_amount": initialAmount,
    "latest_transaction_id": latestTransactionId,
    "latestpayment_at": latestpaymentAt?.toIso8601String(),
    "latest_amount": latestAmount,
    "latest_StatusID": latestStatusId,
    "reason": reason,
    "details": details,
    "activated_at": activatedAt?.toIso8601String(),
    "expired_at": expiredAt?.toIso8601String(),
    "latest_failed_attempt_at": latestFailedAttemptAt,
    "is_active": isActive,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
