// To parse this JSON data, do
//
//     final allCouponsPremiumCategoryModel = allCouponsPremiumCategoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllCouponsPremiumCategoryModel allCouponsPremiumCategoryModelFromJson(String str) => AllCouponsPremiumCategoryModel.fromJson(json.decode(str));

String allCouponsPremiumCategoryModelToJson(AllCouponsPremiumCategoryModel data) => json.encode(data.toJson());

class AllCouponsPremiumCategoryModel {
  AllCouponsPremiumCategoryModel({
    required this.data,
    required this.meta,
  });

  final List<Datum> data;
  final Meta meta;

  factory AllCouponsPremiumCategoryModel.fromJson(Map<String, dynamic> json) => AllCouponsPremiumCategoryModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class Datum {
  Datum({
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
  final String autoLinkId;
  final OfferType offerType;
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
  final ValidTo validTo;
  final DateTime addedOnDate;
  final DateTime lastVisitedOnDate;
  final OfferTypeText offerTypeText;
  final String barcodeQrUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    identifier: json["identifier"],
    autoLinkId: json["autoLinkID"],
    offerType: offerTypeValues.map[json["offerType"]]!,
    title: json["title"],
    couponCode: json["couponCode"],
    redirectUrl: json["redirectURL"],
    description: json["description"],
    exclusive: json["exclusive"],
    noOfLikes: json["NoOfLikes"],
    noOfTodayVisits: json["NoOfTodayVisits"],
    noOfVisits: json["NoOfVisits"],
    sortOrder: json["sortOrder"],
    viewed: json["viewed"],
    status: statusValues.map[json["status"]]!,
    retailerName: json["retailerName"],
    retailerImg: json["retailerImg"],
    validFrom: DateTime.parse(json["validFrom"]),
    validTo: validToValues.map[json["validTo"]]!,
    addedOnDate: DateTime.parse(json["addedOnDate"]),
    lastVisitedOnDate: DateTime.parse(json["lastVisitedOnDate"]),
    offerTypeText: offerTypeTextValues.map[json["offerTypeText"]]!,
    barcodeQrUrl: json["barcodeQrURL"],
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
    "validTo": validToValues.reverse[validTo],
    "addedOnDate": addedOnDate.toIso8601String(),
    "lastVisitedOnDate": lastVisitedOnDate.toIso8601String(),
    "offerTypeText": offerTypeTextValues.reverse[offerTypeText],
    "barcodeQrURL": barcodeQrUrl,
  };
}

enum OfferType { DISCOUNT }

final offerTypeValues = EnumValues({
  "discount": OfferType.DISCOUNT
});

enum OfferTypeText { EMPTY }

final offerTypeTextValues = EnumValues({
  "ΠΡΟΣΦΟΡΑ": OfferTypeText.EMPTY
});

enum Status { ACTIVE }

final statusValues = EnumValues({
  "active": Status.ACTIVE
});

enum ValidTo { EMPTY }

final validToValues = EnumValues({
  "-": ValidTo.EMPTY
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
  Links({
    required this.previous,
  });

  final String previous;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    previous: json["previous"],
  );

  Map<String, dynamic> toJson() => {
    "previous": previous,
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
