// To parse this JSON data, do
//
//     final allStores = allStoresFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class FavouriteModel {
  FavouriteModel({
    required this.data,
    required this.meta,
  });

  List<Datum> data;
  Meta meta;

  factory FavouriteModel.fromRawJson(String str) =>
      FavouriteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
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
    required this.flatShippingAmount,
    required this.aboveFlatShippingAmount,
    required this.apopouCommissionPercent,
    required this.expiringDate,
    required this.createdOnDate,
    required this.couponsCount,
    required this.productsCount,
  });

  int identifier;
  int networkId;
  String networkProgramId;
  String storeName;
  String redirectUrl;
  String storeImgUrl;
  String storeCashback;
  String storeTerms;
  String shortDescription;
  String storeDomain;
  String storeTags;
  String headTitle;
  String metaDescription;
  String shippingInfo;
  int featuredStore;
  int storeOfWeek;
  int noOfVisits;
  String status;
  int flatShippingAmount;
  int aboveFlatShippingAmount;
  int apopouCommissionPercent;
  String expiringDate;
  DateTime createdOnDate;
  int couponsCount;
  int productsCount;

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
        flatShippingAmount: json["flatShippingAmount"],
        aboveFlatShippingAmount: json["aboveFlatShippingAmount"],
        apopouCommissionPercent: json["apopouCommissionPercent"],
        expiringDate: json["expiringDate"],
        createdOnDate: DateTime.parse(json["createdOnDate"]),
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
        "flatShippingAmount": flatShippingAmount,
        "aboveFlatShippingAmount": aboveFlatShippingAmount,
        "apopouCommissionPercent": apopouCommissionPercent,
        "expiringDate": expiringDate,
        "createdOnDate": createdOnDate.toIso8601String(),
        "coupons_count": couponsCount,
        "products_count": productsCount,
      };
}

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

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

  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;
  Links links;

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
  Links({
    required this.next,
  });

  String? next;

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "next": next,
      };
}
