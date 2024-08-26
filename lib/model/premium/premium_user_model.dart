import 'dart:convert';

class PremiumUserModel {
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

  PremiumUserModel({
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

  PremiumUserModel copyWith({
    int? id,
    int? userId,
    String? paymentEmail,
    String? paymentMethod,
    String? orderCode,
    String? initialTransactionId,
    DateTime? initialpaymentAt,
    String? initialAmount,
    String? latestTransactionId,
    DateTime? latestpaymentAt,
    String? latestAmount,
    String? latestStatusId,
    String? reason,
    String? details,
    DateTime? activatedAt,
    DateTime? expiredAt,
    dynamic latestFailedAttemptAt,
    int? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PremiumUserModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        paymentEmail: paymentEmail ?? this.paymentEmail,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        orderCode: orderCode ?? this.orderCode,
        initialTransactionId: initialTransactionId ?? this.initialTransactionId,
        initialpaymentAt: initialpaymentAt ?? this.initialpaymentAt,
        initialAmount: initialAmount ?? this.initialAmount,
        latestTransactionId: latestTransactionId ?? this.latestTransactionId,
        latestpaymentAt: latestpaymentAt ?? this.latestpaymentAt,
        latestAmount: latestAmount ?? this.latestAmount,
        latestStatusId: latestStatusId ?? this.latestStatusId,
        reason: reason ?? this.reason,
        details: details ?? this.details,
        activatedAt: activatedAt ?? this.activatedAt,
        expiredAt: expiredAt ?? this.expiredAt,
        latestFailedAttemptAt: latestFailedAttemptAt ?? this.latestFailedAttemptAt,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PremiumUserModel.fromJson(String str) => PremiumUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PremiumUserModel.fromMap(Map<String, dynamic> json) => PremiumUserModel(
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
