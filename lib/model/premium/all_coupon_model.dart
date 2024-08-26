// To parse this JSON data, do
//
//     final allCouponsPremiumModel = allCouponsPremiumModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllCouponsPremiumModel allCouponsPremiumModelFromJson(String str) => AllCouponsPremiumModel.fromJson(json.decode(str));

String allCouponsPremiumModelToJson(AllCouponsPremiumModel data) => json.encode(data.toJson());

class AllCouponsPremiumModel {
  AllCouponsPremiumModel({
    required this.data,
    required this.meta,
  });

  final List<HiddenAttrModel> data;
  final Meta meta;

  factory AllCouponsPremiumModel.fromJson(Map<String, dynamic> json) => AllCouponsPremiumModel(
    data: List<HiddenAttrModel>.from(json["data"].map((x) => HiddenAttrModel.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class HiddenAttrModel {
  HiddenAttrModel( {
    this.store_id,
    this.isFav,
    required this.identifier,
    required this.autoLinkId,
    required this.offerType,
    required this.title,
    required this.couponCode,
    required this.redirectUrl,
    required this.description,
    required this.exclusive,
    required this.noOfLikes,
    required this.noOfTodayVisits,
    required this.noOfVisits,
    required this.sortOrder,
    required this.viewed,
    required this.status,
    required this.retailerName,
    required this.retailerImg,
    required this.validFrom,
    required this.validTo,
    required this.addedOnDate,
    required this.lastVisitedOnDate,
    required this.offerTypeText,
    required this.barcodeQrUrl,
  });

  final int identifier;
  final int? store_id;
  final String autoLinkId;
  final String offerType;
  final String title;
  final String couponCode;
  final String redirectUrl;
  final String description;
  final int exclusive;
  final int noOfLikes;
  final int noOfTodayVisits;
  final int noOfVisits;
  final int sortOrder;
  final int viewed;
  final Status status;
  final String retailerName;
  final String retailerImg;
  final DateTime validFrom;
  final dynamic validTo;
  final DateTime addedOnDate;
  final String lastVisitedOnDate;
  final String offerTypeText;
  final String barcodeQrUrl;
  bool? isFav;

  factory HiddenAttrModel.fromJson(Map<String, dynamic> json) => HiddenAttrModel(
    identifier: json["identifier"],
    store_id: json['store_id'],
    autoLinkId: json["autoLinkID"]==null?"noLink":json["autoLinkID"],
    offerType:json["offerType"]==null?"test":json["offerType"],
    title: json["title"]==null?"test":json["title"],
    couponCode: json["couponCode"]==null?"test":json["couponCode"],
    redirectUrl: json["redirectURL"]==null?"test":json["redirectURL"],
    description: json["description"]==null?"test":json["description"],
    exclusive: json["exclusive"]==null?0:json["exclusive"],
    noOfLikes: json["NoOfLikes"]==null?0:json["NoOfLikes"],
    noOfTodayVisits: json["NoOfTodayVisits"]==null?0:json["NoOfTodayVisits"],
    noOfVisits: json["NoOfVisits"]==null?0:json["NoOfVisits"],
    sortOrder: json["sortOrder"]==null?0:json["sortOrder"],
    viewed: json["viewed"]==null?0:json["viewed"],
    status: statusValues.map[json["status"]]!,
    retailerName: json["retailerName"]==null?"":json["retailerName"],
    retailerImg: json["retailerImg"]==null?"test":json["retailerImg"],
    validFrom: DateTime.parse(json["validFrom"]),
    validTo: json["validTo"],
    addedOnDate: DateTime.parse(json["addedOnDate"]),
    lastVisitedOnDate: json["lastVisitedOnDate"],
    offerTypeText: json["offerTypeText"],
    barcodeQrUrl: json["barcodeQrURL"],
    isFav: false
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "autoLinkID": autoLinkId,
    "offerType": offerTypeValues.reverse[offerType],
    "title": title,
    "couponCode": couponCode,
    "redirectURL": redirectUrl,
    "description": description,
    "exclusive": exclusive,
    "NoOfLikes": noOfLikes,
    "NoOfTodayVisits": noOfTodayVisits,
    "NoOfVisits": noOfVisits,
    "sortOrder": sortOrder,
    "viewed": viewed,
    "status": statusValues.reverse[status],
    "retailerName": retailerName,
    "retailerImg": retailerImg,
    "validFrom": validFrom.toIso8601String(),
    "validTo": validTo,
    'store_id':store_id,
    "addedOnDate": addedOnDate.toIso8601String(),
    "lastVisitedOnDate": lastVisitedOnDate,
    "offerTypeText": offerTypeTextValues.reverse[offerTypeText],
    "barcodeQrURL": barcodeQrUrl,
  };
}

enum OfferType { DISCOUNT, COUPON }

final offerTypeValues = EnumValues({
  "coupon": OfferType.COUPON,
  "discount": OfferType.DISCOUNT
});

enum OfferTypeText { EMPTY, OFFER_TYPE_TEXT }

final offerTypeTextValues = EnumValues({
  "ΠΡΟΣΦΟΡΑ": OfferTypeText.EMPTY,
  "ΚΟΥΠΟΝΙ": OfferTypeText.OFFER_TYPE_TEXT
});

enum Status { ACTIVE }

final statusValues = EnumValues({
  "active": Status.ACTIVE
});

enum ValidToEnum { EMPTY }

final validToEnumValues = EnumValues({
  "-": ValidToEnum.EMPTY
});

class Meta {
  Meta({
    required this.pagination,
  });

  final Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  Pagination({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.links,
  });

  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;
  final Links links;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    count: json["count"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    totalPages: json["total_pages"],
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "count": count,
    "per_page": perPage,
    "current_page": currentPage,
    "total_pages": totalPages,
    "links": links.toJson(),
  };
}

class Links {
  Links();

  factory Links.fromJson(Map<String, dynamic> json) => Links(
  );

  Map<String, dynamic> toJson() => {
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
