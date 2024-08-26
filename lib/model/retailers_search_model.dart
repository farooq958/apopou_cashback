// To parse this JSON data, do
//
//     final retailersSearchModel = retailersSearchModelFromJson(jsonString);

import 'dart:developer';

import 'package:meta/meta.dart';
import 'dart:convert';

class RetailersSearchModel {
  RetailersSearchModel({
    required this.data,
  });

  List<RetailersSearchModelDatum> data;

  factory RetailersSearchModel.fromRawJson(String str) =>
      RetailersSearchModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RetailersSearchModel.fromJson(Map<String, dynamic> json) =>
      RetailersSearchModel(
        data: List<RetailersSearchModelDatum>.from(
            json["data"].map((x) => RetailersSearchModelDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RetailersSearchModelDatum {
  RetailersSearchModelDatum({
    required this.identifier,
    required this.storeName,
    required this.storeImgUrl,
    required this.storeCashback,
    required this.favoriters,
    required this.couponsCount,
    required this.productsCount,
    // required this.categories,
  });

  final int identifier;
  final String storeName;
  final String storeImgUrl;
  final String storeCashback;
  int favoriters;
  final int couponsCount;
  final int productsCount;
  // final Categories categories;

  factory RetailersSearchModelDatum.fromRawJson(String str) =>
      RetailersSearchModelDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RetailersSearchModelDatum.fromJson(Map<String, dynamic> json) =>
      RetailersSearchModelDatum(
        identifier: json["identifier"],
        storeName: json["storeName"],
        storeImgUrl: json["storeImgURL"],
        storeCashback: json["storeCashback"],
        favoriters: json["favoriters"],
        couponsCount: json["coupons_count"],
        productsCount: json["products_count"],
        // categories: Categories.fromJson(json["categories"]),
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "storeName": storeName,
        "storeImgURL": storeImgUrl,
        "storeCashback": storeCashback,
        "favoriters": favoriters,
        "coupons_count": couponsCount,
        "products_count": productsCount,
        // "categories": categories.toJson(),
      };
}

class Categories {
  Categories({
    required this.data,
  });

  final List<CategoriesDatum> data;

  factory Categories.fromRawJson(String str) =>
      Categories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Categories.fromJson(Map<String, dynamic> json) {
    log("testing joson ${json}");

    return Categories(
      data: List<CategoriesDatum>.from(
          json['data'].map((x) => CategoriesDatum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CategoriesDatum {
  CategoriesDatum({
    required this.identifier,
    required this.parentID,
    required this.categoryTitle,
    required this.img,
    required this.ico,
    required this.uri,
    required this.sortNo,
    required this.sucategories,
  });

  final int identifier;
  final String parentID;
  final String categoryTitle;
  final String img;
  final String ico;
  final String uri;
  final String sortNo;
  final String sucategories;

  factory CategoriesDatum.fromRawJson(String str) =>
      CategoriesDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesDatum.fromJson(Map<String, dynamic> json) {
    log("testing json ${json}");
    var test = CategoriesDatum(
      identifier: json["identifier"],
      parentID: json["parentID"],
      categoryTitle: json["categoryTitle"],
      img: json["IMG"],
      ico: json["ICO"],
      uri: json["URI"],
      sortNo: json["sortNo"],
      sucategories: json['sucategories'],
    );

    log("testing json2  ${test}");
    return CategoriesDatum(
      identifier: json["identifier"],
      parentID: json["parentID"],
      categoryTitle: json["categoryTitle"],
      img: json["IMG"],
      ico: json["ICO"],
      uri: json["URI"],
      sortNo: json["sortNo"],
      sucategories: json['sucategories'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "parentID": parentID,
        "categoryTitle": categoryTitle,
        "IMG": img,
        "ICO": ico,
        "URI": uri,
        "sortNo": sortNo,
        "sucategories": sucategories,
      };
}

class Sucategory {
  Sucategory({
    required this.categoryId,
    required this.parentId,
    required this.name,
    required this.icon,
    required this.img,
    required this.description,
    required this.categoryUrl,
    required this.metaDescription,
    required this.metaKeywords,
    required this.sortOrder,
    required this.featured,
  });

  final int categoryId;
  final int parentId;
  final String name;
  final String icon;
  final String img;
  final String description;
  final String categoryUrl;
  final String metaDescription;
  final String metaKeywords;
  final int sortOrder;
  final int featured;

  factory Sucategory.fromRawJson(String str) =>
      Sucategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sucategory.fromJson(Map<String, dynamic> json) => Sucategory(
        categoryId: json["category_id"],
        parentId: json["parent_id"],
        name: json["name"],
        icon: json["icon"],
        img: json["img"],
        description: json["description"],
        categoryUrl: json["category_url"],
        metaDescription: json["meta_description"],
        metaKeywords: json["meta_keywords"],
        sortOrder: json["sort_order"],
        featured: json["featured"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "parent_id": parentId,
        "name": name,
        "icon": icon,
        "img": img,
        "description": description,
        "category_url": categoryUrl,
        "meta_description": metaDescription,
        "meta_keywords": metaKeywords,
        "sort_order": sortOrder,
        "featured": featured,
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
