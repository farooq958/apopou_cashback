// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CategoriesModel {
  CategoriesModel({
    required this.data,
    required this.meta,
  });

  List<Datum> data;
  Meta meta;

  factory CategoriesModel.fromJson(String str) => CategoriesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromMap(Map<String, dynamic> json) => CategoriesModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    meta: Meta.fromMap(json["meta"]),
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "meta": meta.toMap(),
  };
}

class Datum {
  Datum({
    required this.identifier,
    required this.parentId,
    required this.categoryTitle,
    required this.img,
    required this.ico,
    required this.categoryDescription,
    required this.uri,
    required this.headTitle,
    required this.metaDescription,
    required this.sortNo,
  });

  int identifier;
  String parentId;
  String categoryTitle;
  String img;
  String ico;
  String categoryDescription;
  String uri;
  String headTitle;
  String metaDescription;
  String sortNo;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    identifier: json["identifier"],
    parentId: json["parentID"],
    categoryTitle: json["categoryTitle"],
    img: json["IMG"],
    ico: json["ICO"],
    categoryDescription: json["categoryDescription"]??"",
    uri: json["URI"],
    headTitle: json["headTitle"]??"",
    metaDescription: json["metaDescription"]??"",
    sortNo: json["sortNo"],
  );

  Map<String, dynamic> toMap() => {
    "identifier": identifier,
    "parentID": parentId,
    "categoryTitle": categoryTitle,
    "IMG": img,
    "ICO": ico,
    "categoryDescription": categoryDescription,
    "URI": uri,
    "headTitle": headTitle,
    "metaDescription": metaDescription,
    "sortNo": sortNo,
  };
}

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
    pagination: Pagination.fromMap(json["pagination"]),
  );

  Map<String, dynamic> toMap() => {
    "pagination": pagination.toMap(),
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

  factory Pagination.fromJson(String str) => Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    count: json["count"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    totalPages: json["total_pages"],
    links: Links.fromMap(json["links"]),
  );

  Map<String, dynamic> toMap() => {
    "total": total,
    "count": count,
    "per_page": perPage,
    "current_page": currentPage,
    "total_pages": totalPages,
    "links": links.toMap(),
  };
}

class Links {
  Links();

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
  );

  Map<String, dynamic> toMap() => {
  };
}
