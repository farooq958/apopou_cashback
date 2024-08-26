import 'dart:convert';

import 'package:equatable/equatable.dart';

class CouponModel extends Equatable {
  final int identifier;
  final String autoLinkID;
  final String offerType;
  final String title;
  final String couponCode;
  final String redirectURL;
  final String description;
  final String exclusive;
  final int NoOfLikes;
  final int NoOfTodayVisits;
  final int NoOfVisits;
  final int sortOrder;
  final int viewed;
  final String status;
  final String validFrom;
  final String validTo;
  final String addedOnDate;
  final String lastVisitedOnDate;
  CouponModel({
    required this.identifier,
    required this.autoLinkID,
    required this.offerType,
    required this.title,
    required this.couponCode,
    required this.redirectURL,
    required this.description,
    required this.exclusive,
    required this.NoOfLikes,
    required this.NoOfTodayVisits,
    required this.NoOfVisits,
    required this.sortOrder,
    required this.viewed,
    required this.status,
    required this.validFrom,
    required this.validTo,
    required this.addedOnDate,
    required this.lastVisitedOnDate,
  });

  CouponModel copyWith({
    int? identifier,
    String? autoLinkID,
    String? offerType,
    String? title,
    String? couponCode,
    String? redirectURL,
    String? description,
    String? exclusive,
    int? NoOfLikes,
    int? NoOfTodayVisits,
    int? NoOfVisits,
    int? sortOrder,
    int? viewed,
    String? status,
    String? validFrom,
    String? validTo,
    String? addedOnDate,
    String? lastVisitedOnDate,
  }) {
    return CouponModel(
      identifier: identifier ?? this.identifier,
      autoLinkID: autoLinkID ?? this.autoLinkID,
      offerType: offerType ?? this.offerType,
      title: title ?? this.title,
      couponCode: couponCode ?? this.couponCode,
      redirectURL: redirectURL ?? this.redirectURL,
      description: description ?? this.description,
      exclusive: exclusive ?? this.exclusive,
      NoOfLikes: NoOfLikes ?? this.NoOfLikes,
      NoOfTodayVisits: NoOfTodayVisits ?? this.NoOfTodayVisits,
      NoOfVisits: NoOfVisits ?? this.NoOfVisits,
      sortOrder: sortOrder ?? this.sortOrder,
      viewed: viewed ?? this.viewed,
      status: status ?? this.status,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      addedOnDate: addedOnDate ?? this.addedOnDate,
      lastVisitedOnDate: lastVisitedOnDate ?? this.lastVisitedOnDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'identifier': identifier,
      'autoLinkID': autoLinkID,
      'offerType': offerType,
      'title': title,
      'couponCode': couponCode,
      'redirectURL': redirectURL,
      'description': description,
      'exclusive': exclusive,
      'NoOfLikes': NoOfLikes,
      'NoOfTodayVisits': NoOfTodayVisits,
      'NoOfVisits': NoOfVisits,
      'sortOrder': sortOrder,
      'viewed': viewed,
      'status': status,
      'validFrom': validFrom,
      'validTo': validTo,
      'addedOnDate': addedOnDate,
      'lastVisitedOnDate': lastVisitedOnDate,
    };
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      identifier: map['identifier']?.toInt() ?? 0,
      autoLinkID: map['autoLinkID'].toString() ?? '',
      offerType: map['offerTypeText'].toString() ?? '',
      title: map['title'] ?? '',
      couponCode: map['couponCode'].toString() ?? '',
      redirectURL: map['redirectURL'] ?? '',
      description: map['description'] ?? '',
      exclusive: map['exclusive'].toString() ?? '',  ///this was the issue solved
      NoOfLikes: map['NoOfLikes']?.toInt() ?? 0,
      NoOfTodayVisits: map['NoOfTodayVisits']?.toInt() ?? 0,
      NoOfVisits: map['NoOfVisits']?.toInt() ?? 0,
      sortOrder: map['sortOrder']?.toInt() ?? 0,
      viewed: map['viewed']?.toInt() ?? 0,
      status: map['status'] ?? '',
      validFrom: map['validFrom'] ?? '',
      validTo: map['validTo'] ?? '',
      addedOnDate: map['addedOnDate'] ?? '',
      lastVisitedOnDate: map['lastVisitedOnDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponModel.fromJson(String source) =>
      CouponModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CouponModel(identifier: $identifier, autoLinkID: $autoLinkID, offerType: $offerType, title: $title, couponCode: $couponCode, redirectURL: $redirectURL, description: $description, exclusive: $exclusive, NoOfLikes: $NoOfLikes, NoOfTodayVisits: $NoOfTodayVisits, NoOfVisits: $NoOfVisits, sortOrder: $sortOrder, viewed: $viewed, status: $status, validFrom: $validFrom, validTo: $validTo, addedOnDate: $addedOnDate, lastVisitedOnDate: $lastVisitedOnDate)';
  }

  @override
  List<Object> get props {
    return [
      identifier,
      autoLinkID,
      offerType,
      title,
      couponCode,
      redirectURL,
      description,
      exclusive,
      NoOfLikes,
      NoOfTodayVisits,
      NoOfVisits,
      sortOrder,
      viewed,
      status,
      validFrom,
      validTo,
      addedOnDate,
      lastVisitedOnDate,
    ];
  }
}
