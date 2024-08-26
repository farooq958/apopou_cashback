// To parse this JSON data, do
//
//     final allFeatured = allFeaturedFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AllFeatured {
  AllFeatured({
    required this.data,
    required this.meta,
  });

  final List<Datum> data;
  final Meta meta;

  factory AllFeatured.fromRawJson(String str) =>
      AllFeatured.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllFeatured.fromJson(Map<String, dynamic> json) => AllFeatured(
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
    required this.networkId,
    required this.networkProgramId,
    required this.storeName,
    required this.redirectUrl,
    required this.storeImgUrl,
    required this.storeCashback,
    required this.storeTerms,
    required this.shortDescription,
    required this.storeDomain,
    required this.storeTags,
    required this.headTitle,
    required this.metaDescription,
    required this.shippingInfo,
    required this.featuredStore,
    required this.storeOfWeek,
    required this.noOfVisits,
    required this.status,
    required this.favoriters,
    this.flatShippingAmount,
    required this.aboveFlatShippingAmount,
    required this.apopouCommissionPercent,
    required this.expiringDate,
    required this.createdOnDate,
    required this.couponsCount,
    required this.productsCount,
  });

  final int identifier;
  final int networkId;
  final String networkProgramId;
  final String storeName;
  final String redirectUrl;
  final String storeImgUrl;
  final String storeCashback;
  final String storeTerms;
  final String shortDescription;
  final String storeDomain;
  final String storeTags;
  final String headTitle;
  final String metaDescription;
  final String shippingInfo;
  final int featuredStore;
  final int storeOfWeek;
  final int noOfVisits;
  final String status;
  int favoriters;
  final dynamic flatShippingAmount;
  final int aboveFlatShippingAmount;
  final int apopouCommissionPercent;
  final String expiringDate;
  final String createdOnDate;
  final int couponsCount;
  final int productsCount;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        identifier: json["identifier"],
        networkId: json["networkID"],
        networkProgramId: json["networkProgramID"],
        storeName: json["storeName"],
        redirectUrl: json["redirectURL"],
        storeImgUrl: json["storeImgURL"],
        storeCashback: json["storeCashback"],
        storeTerms: json["storeTerms"],
        shortDescription: json["shortDescription"],
        storeDomain: json["storeDomain"],
        storeTags: json["storeTags"],
        headTitle: json["headTitle"],
        metaDescription: json["metaDescription"],
        shippingInfo: json["shippingInfo"],
        featuredStore: json["featuredStore"],
        storeOfWeek: json["storeOfWeek"],
        noOfVisits: json["noOfVisits"],
        status: json["status"],
        favoriters: json["favoriters"],
        flatShippingAmount: json["flatShippingAmount"],
        aboveFlatShippingAmount: json["aboveFlatShippingAmount"],
        apopouCommissionPercent: json["apopouCommissionPercent"],
        expiringDate: json["expiringDate"],
        createdOnDate: json["createdOnDate"],
        couponsCount: json["coupons_count"],
        productsCount: json["products_count"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "networkID": networkId,
        "networkProgramID": networkProgramId,
        "storeName": storeName,
        "redirectURL": redirectUrl,
        "storeImgURL": storeImgUrl,
        "storeCashback": storeCashback,
        "storeTerms": storeTerms,
        "shortDescription": shortDescription,
        "storeDomain": storeDomain,
        "storeTags": storeTags,
        "headTitle": headTitle,
        "metaDescription": metaDescription,
        "shippingInfo": shippingInfo,
        "featuredStore": featuredStore,
        "storeOfWeek": storeOfWeek,
        "noOfVisits": noOfVisits,
        "status": status,
        "favoriters": favoriters,
        "flatShippingAmount": flatShippingAmount,
        "aboveFlatShippingAmount": aboveFlatShippingAmount,
        "apopouCommissionPercent": apopouCommissionPercent,
        "expiringDate": expiringDate,
        "createdOnDate": createdOnDate,
        "coupons_count": couponsCount,
        "products_count": productsCount,
      };
}

class Meta {
  Meta({
    required this.pagination,
  });

  final Pagination pagination;

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links();

  Map<String, dynamic> toJson() => {};
}
